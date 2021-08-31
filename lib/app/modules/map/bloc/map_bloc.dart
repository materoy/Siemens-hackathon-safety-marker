import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:siemens_hackathon_safety_marker/app/modules/map/repository/map_repository.dart';

part 'map_event.dart';
part 'map_state.dart';

class MapBloc extends Bloc<MapEvent, MapState> {
  MapBloc()
      : _repository = MapRepository(),
        super(const MapInitial()) {
    add(MapCreatedEvent());
  }

  final MapRepository _repository;

  @override
  Stream<MapState> mapEventToState(
    MapEvent event,
  ) async* {
    if (event is MapCreatedEvent) {
      // Initialize
      final currentPosition = await _getUserLocation();
      yield MapCreated(currentPosition);
    } else if (event is MapTrackUser) {
      //
    }
  }

  Future<LatLng> _getUserLocation() async {
    final position = await _repository.getCurrentPosition();
    return LatLng(position.latitude, position.longitude);
  }
}
