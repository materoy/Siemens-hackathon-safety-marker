part of 'safety_bloc.dart';

abstract class SafetyEvent extends Equatable {
  const SafetyEvent(this.alert);
  final Alert alert;
  @override
  List<Object> get props => [];
}

class ActivateSafetyEvent extends SafetyEvent {
  const ActivateSafetyEvent(Alert alert) : super(alert);
}

class DeactivateSafetyEvent extends SafetyEvent {
  const DeactivateSafetyEvent(Alert alert) : super(alert);
}
