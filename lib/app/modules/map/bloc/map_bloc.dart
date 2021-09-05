import 'dart:async';
import 'dart:developer';

import 'package:authentication/authentication.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
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

    /// Starts and event to broadcast the users location
    add(BroadcastLocationEvent());
  }
  final AuthenticationRepository _authenticationRepository;
  final MapRepository _repository;
  late final StreamSubscription _usersStreamSubscription;
  late final StreamSubscription _positionStream;
  late final GoogleMapController mapController;

  static const int UPDATE_LOCATION_TIME_DELTA = 30;

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
      /// Updates the current location of the user in the database
      /// Every [UPDATE_LOCATION_TIME_DELTA]
      _positionStream = Geolocator.getPositionStream(
              intervalDuration:
                  const Duration(seconds: UPDATE_LOCATION_TIME_DELTA))
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
    log('Tracking other users');
    yield* _repository.usersStream.map((users) {
      return TrackUserState(
        currentPosition: state.currentPosition,
        markers: List.generate(users.length, (index) {
          final user = users[index];
          if (user.latLng != null) {
            log('Marker');
            return Marker(
              markerId: MarkerId(users[index].uid!),
              position: users[index].latLng!,
              onTap: () {
                mapController.animateCamera(CameraUpdate.newCameraPosition(
                  CameraPosition(
                    target: user.latLng!,
                    zoom: 19.151926040649414,
                    tilt: 59.440717697143555,
                  ),
                ));
              },
            );
          } else {
            return Marker(markerId: MarkerId(users[index].uid!));
          }
        }).toSet(),
      );
    });
  }

  void onMapCreated(GoogleMapController gmController) {
    mapController = gmController;

    /// As soon as the map is created an event is triggered to track other users
    add(TrackUsersEvent());
  }

  @override
  Future<void> close() {
    _usersStreamSubscription.cancel();
    _positionStream.cancel();
    return super.close();
  }
}
