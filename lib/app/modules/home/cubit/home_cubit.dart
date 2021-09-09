import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:siemens_hackathon_safety_marker/app/modules/alert/model/model.dart';
import 'package:siemens_hackathon_safety_marker/app/modules/home/repository/home_repository.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit({HomeRepository? homeRepository})
      : _repository = homeRepository ?? HomeRepository(),
        super(const HomeState([])) {
    _disastersSubscription = _repository.getDisasters.listen((event) {
      emit(HomeState(event));
    });
  }

  final HomeRepository _repository;
  late StreamSubscription _disastersSubscription;

  @override
  Future<void> close() {
    _disastersSubscription.cancel();
    return super.close();
  }
}
