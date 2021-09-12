import 'dart:async';
import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:siemens_hackathon_safety_marker/app/modules/alert/model/alert.dart';
import 'package:siemens_hackathon_safety_marker/app/modules/alert/repository/alert_repository.dart';

part 'alert_event.dart';
part 'alert_state.dart';

class AlertBloc extends Bloc<AlertEvent, AlertState> {
  AlertBloc(this._alertRepository) : super(NoAlertState());

  final AlertRepository _alertRepository;

  @override
  Stream<AlertState> mapEventToState(
    AlertEvent event,
  ) async* {
    if (event is CreateAlertEvent) {
      final createdAlert = await _alertRepository.createAlertWithDetails(
          event.alert, event.images);
      yield CurrentAlertState(createdAlert);
    } else if (event is UpdateAlertEvent) {
      // await _alertRepository.updateAlertDetails(event.alert, event.images);
      yield CurrentAlertState(event.alert);
    } else {
      yield NoAlertState();
    }
  }
}
