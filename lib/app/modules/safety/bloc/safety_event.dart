part of 'safety_bloc.dart';

abstract class SafetyEvent extends Equatable {
  const SafetyEvent({required this.alert, this.user});
  final Alert alert;
  final User? user;
  @override
  List<Object> get props => [];
}

class ActivateSafetyEvent extends SafetyEvent {
  const ActivateSafetyEvent(Alert alert) : super(alert: alert);
}

class NotSafeSafetyEvent extends SafetyEvent {
  const NotSafeSafetyEvent({required Alert alert, required User user})
      : super(alert: alert, user: user);
}

class SafeSafetyEvent extends SafetyEvent {
  const SafeSafetyEvent({required Alert alert, required User user})
      : super(alert: alert, user: user);
}

class DeactivateSafetyEvent extends SafetyEvent {
  const DeactivateSafetyEvent(Alert alert) : super(alert: alert);
}
