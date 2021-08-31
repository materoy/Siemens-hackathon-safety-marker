part of 'map_bloc.dart';

abstract class MapEvent extends Equatable {
  const MapEvent();

  @override
  List<Object> get props => [];
}

class MapCreatedEvent extends MapEvent {}

class GoToCurrentLocationEvent extends MapEvent {}

class GoToUserLocationEvent extends MapEvent {}

class ActivateLiveShareLocationEvent extends MapEvent {}
