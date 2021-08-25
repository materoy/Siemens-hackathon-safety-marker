import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'safety_event.dart';
part 'safety_state.dart';

class SafetyBloc extends Bloc<SafetyEvent, SafetyState> {
  SafetyBloc() : super(SafetyInitial());

  @override
  Stream<SafetyState> mapEventToState(
    SafetyEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
