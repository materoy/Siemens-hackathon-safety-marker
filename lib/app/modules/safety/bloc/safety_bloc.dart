import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:siemens_hackathon_safety_marker/app/modules/alert/model/model.dart';
import 'package:siemens_hackathon_safety_marker/app/modules/safety/repository/safety_repository.dart';

part 'safety_event.dart';
part 'safety_state.dart';

class SafetyBloc extends Bloc<SafetyEvent, SafetyState> {
  SafetyBloc() : super(InactiveSafetyAlertState()) {
    _alertSubscription =
        _safetyRepository.activeAlertsStream.listen(_onalertStateChanged);
  }
  final SafetyRepository _safetyRepository = SafetyRepository();
  late final StreamSubscription<Alert> _alertSubscription;

  void _onalertStateChanged(Alert alert) => add(ActivateSafetyEvent(alert));

  @override
  Stream<SafetyState> mapEventToState(
    SafetyEvent event,
  ) async* {
    if (event is ActivateSafetyEvent) {
      log('Active event');
      yield ActiveSafetyAlertState(event.alert);
    } else if (event is DeactivateSafetyEvent) {
      yield InactiveSafetyAlertState();
    }
  }

  @override
  Future<void> close() {
    _alertSubscription.cancel();
    return super.close();
  }
}
