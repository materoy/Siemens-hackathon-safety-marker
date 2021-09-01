import 'dart:async';
import 'dart:developer';

import 'package:authentication/authentication.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:siemens_hackathon_safety_marker/app/modules/map/repository/map_repository.dart';

part 'map_event.dart';
part 'map_state.dart';

class MapBloc extends Bloc<MapEvent, MapState> {
  MapBloc(this._authenticationRepository)
      : _repository = MapRepository(),
        super(MapInitial()) {
    add(MapCreatedEvent());
  }
  final AuthenticationRepository _authenticationRepository;
  final MapRepository _repository;
  late final StreamSubscription _usersStreamSubscription;
  late final StreamSubscription _positionStream;

  @override
  Stream<MapState> mapEventToState(
    MapEvent event,
  ) async* {
    if (event is MapCreatedEvent) {
      // Initialize
      final currentPosition = await _getUserLocation();
      yield MapCreated(currentPosition);
    } else if (event is TrackUsersEvent) {
      yield* _mapTrackUserEventToState();
    } else if (event is BroadcastLocationEvent) {
      _positionStream = Geolocator.getPositionStream(
              intervalDuration: const Duration(seconds: 10))
          .listen((newPosition) async {
        await _repository.updateUserPosition(
            position: LatLng(newPosition.latitude, newPosition.longitude),
            uid: _authenticationRepository.currentUser.uid!);
      });
    }
  }

  Future<LatLng> _getUserLocation() async {
    final position = await _repository.getCurrentPosition();
    return LatLng(position.latitude, position.longitude);
  }

  Stream<MapState> _mapTrackUserEventToState() async* {
    yield* _repository.usersStream.map((users) {
      return TrackUserState(
        currentPosition: state.currentPosition,
        markers: List.generate(users.length, (index) {
          log('Marker');
          if (users[index].latLng != null) {
            return Marker(
                markerId: MarkerId(users[index].uid!),
                position: users[index].latLng!);
          } else {
            return Marker(markerId: MarkerId(users[index].uid!));
          }
        }).toSet(),
      );
    });
  }

  void onMapCreated(GoogleMapController gmContoller) {
    add(BroadcastLocationEvent());
    add(TrackUsersEvent());
    Future.delayed(const Duration(seconds: 1), () {});
  }

  @override
  Future<void> close() {
    _usersStreamSubscription.cancel();
    _positionStream.cancel();
    return super.close();
  }
}
