part of 'map_bloc.dart';

abstract class MapEvent extends Equatable {
  MapEvent({List<User>? users}) : users = users ?? [];

  final List<User> users;
  @override
  List<Object> get props => [users];
}

class MapCreatedEvent extends MapEvent {}

class GoToCurrentLocationEvent extends MapEvent {}

class GoToUserLocationEvent extends MapEvent {}

class TrackUsersEvent extends MapEvent {}

class BroadcastLocationEvent extends MapEvent {}
