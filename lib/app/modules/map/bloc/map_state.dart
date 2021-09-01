part of 'map_bloc.dart';

abstract class MapState extends Equatable {
  const MapState({this.currentPosition, this.markers});
  final LatLng? currentPosition;
  final Set<Marker>? markers;

  @override
  List<Object> get props => [];
}

class MapInitial extends MapState {}

class MapCreated extends MapState {
  const MapCreated(LatLng? currentPosition)
      : super(currentPosition: currentPosition);
}

class TrackUserState extends MapState {
  const TrackUserState({LatLng? currentPosition, required Set<Marker> markers})
      : super(currentPosition: currentPosition, markers: markers);
}
