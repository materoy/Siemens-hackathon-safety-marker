part of 'alert_bloc.dart';

abstract class AlertState extends Equatable {
  const AlertState(this.alert);

  final Alert alert;
  @override
  List<Object> get props => [];
}

class NoAlertState extends AlertState {
  NoAlertState() : super(Alert.empty);
}

class CurrentAlertState extends AlertState {
  const CurrentAlertState(Alert alert) : super(alert);

  CurrentAlertState copyWith(Alert newAlert) {
    return CurrentAlertState(Alert(
        time: alert.time,
        creatorId: alert.creatorId,
        alertId: newAlert.alertId ?? alert.alertId,
        current: newAlert.current,
        description: newAlert.description ?? alert.description,
        title: newAlert.title ?? alert.title,
        type: newAlert.type ?? alert.type));
  }
}
