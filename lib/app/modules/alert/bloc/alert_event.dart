part of 'alert_bloc.dart';

abstract class AlertEvent extends Equatable {
  AlertEvent({Alert? alert}) : alert = alert ?? Alert.empty;

  final Alert alert;
  @override
  List<Object> get props => [];
}

class CreateAlertEvent extends AlertEvent {
  CreateAlertEvent(Alert alert, {this.images}) : super(alert: alert);
  final List<Uint8List>? images;
}

class UpdateAlertEvent extends AlertEvent {
  UpdateAlertEvent(Alert alert, {this.images}) : super(alert: alert);
  final List<Uint8List>? images;
}

class CloseAlertEvent extends AlertEvent {}
