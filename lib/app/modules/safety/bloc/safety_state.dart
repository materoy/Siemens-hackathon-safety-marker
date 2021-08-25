part of 'safety_bloc.dart';

abstract class SafetyState extends Equatable {
  const SafetyState();
  
  @override
  List<Object> get props => [];
}

class SafetyInitial extends SafetyState {}
