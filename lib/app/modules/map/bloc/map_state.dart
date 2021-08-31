part of 'map_bloc.dart';

abstract class MapState extends Equatable {
  const MapState(this.currentPosition);
  final LatLng? currentPosition;

  @override
  List<Object> get props => [];
}

class MapInitial extends MapState {
  const MapInitial() : super(null);
}

class MapCreated extends MapState {
  const MapCreated(LatLng? currentPosition) : super(currentPosition);
}

class MapTrackUser extends MapState {
  const MapTrackUser(LatLng? currentPosition) : super(currentPosition);
}
