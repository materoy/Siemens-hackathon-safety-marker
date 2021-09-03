part of 'safety_bloc.dart';

abstract class SafetyState extends Equatable {
  const SafetyState(this.alert);

  final Alert alert;
  @override
  List<Object> get props => [];
}

class ActiveSafetyAlertState extends SafetyState {
  const ActiveSafetyAlertState(Alert alert) : super(alert);
}

class InactiveSafetyAlertState extends SafetyState {
  InactiveSafetyAlertState() : super(Alert.empty);
}
