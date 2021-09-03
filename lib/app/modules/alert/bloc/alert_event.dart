part of 'alert_bloc.dart';

abstract class AlertEvent extends Equatable {
  AlertEvent({Alert? alert}) : alert = alert ?? Alert.empty;

  final Alert alert;
  @override
  List<Object> get props => [];
}

class CreateAlertEvent extends AlertEvent {
  CreateAlertEvent(Alert alert) : super(alert: alert);
}

class UpdateAlertEvent extends AlertEvent {
  UpdateAlertEvent(Alert alert) : super(alert: alert);
}

class CloseAlertEvent extends AlertEvent {}
