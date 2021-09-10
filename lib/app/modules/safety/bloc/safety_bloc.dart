import 'dart:async';

import 'package:authentication/authentication.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:siemens_hackathon_safety_marker/app/modules/alert/model/model.dart';
import 'package:siemens_hackathon_safety_marker/app/modules/safety/repository/safety_repository.dart';

part 'safety_event.dart';
part 'safety_state.dart';

class SafetyBloc extends Bloc<SafetyEvent, SafetyState> {
  SafetyBloc(this.user) : super(InactiveSafetyAlertState()) {
    _alertSubscription =
        _safetyRepository.activeAlertsStream.listen(_onalertStateChanged);
  }
  final SafetyRepository _safetyRepository = SafetyRepository();
  late final StreamSubscription<Alert?> _alertSubscription;
  final User user;

  void _onalertStateChanged(Alert? alert) {
    if (alert != null) {
      /// Does not immediately raise alert for current user until
      /// alert metadata is set
      if (alert.creatorId != user.uid) add(ActivateSafetyEvent(alert));
    } else {
      add(DeactivateSafetyEvent(Alert.empty));
    }
  }

  @override
  Stream<SafetyState> mapEventToState(
    SafetyEvent event,
  ) async* {
    if (event is ActivateSafetyEvent) {
      yield ActiveSafetyAlertState(event.alert);
    } else if (event is DeactivateSafetyEvent) {
      yield InactiveSafetyAlertState();
    } else if (event is SafeSafetyEvent) {
      // Update database to user safe
      await _safetyRepository.updateSafetyState(
          uid: event.user!.uid!, safe: true);
    } else if (event is NotSafeSafetyEvent) {
      // Update database to user not safe
      await _safetyRepository.updateSafetyState(
          uid: event.user!.uid!, safe: false);
    }
  }

  @override
  Future<void> close() {
    _alertSubscription.cancel();
    return super.close();
  }
}
