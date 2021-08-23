import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'create_alert_state.dart';

class CreateAlertCubit extends Cubit<CreateAlertState> {
  CreateAlertCubit() : super(CreateAlertInitial());
}
