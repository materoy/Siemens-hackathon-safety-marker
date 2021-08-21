import 'dart:developer';

import 'package:authentication/authentication.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:form_inputs/form_inputs.dart';

part 'signup_state.dart';

class SignupCubit extends Cubit<SignupState> {
  SignupCubit(this._authenticationRepository) : super(const SignupState());

  final AuthenticationRepository _authenticationRepository;

  void emailChanged(String value) {
    final email = Email.dirty(value);
    emit(state.copyWith(
        email: email,
        status:
            Formz.validate([email, state.password, state.confirmPassword])));
  }

  void passwordChanged(String value) {
    final password = Password.dirty(value);
    emit(state.copyWith(
        password: password,
        status:
            Formz.validate([state.email, password, state.confirmPassword])));
  }

  void confirmPasswordChanged(String value) {
    final confirmPassword =
        ConfirmPassword.dirty(password: state.password.value, value: value);
    emit(state.copyWith(
        confirmPassword: confirmPassword,
        status:
            Formz.validate([state.email, confirmPassword, state.password])));
  }

  Future<void> signupFormSubmitted() async {
    if (!state.status.isValidated) return;
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    try {
      final mockUser = User(
          firstName: 'firstName',
          lastName: 'lastName',
          email: state.email.value,
          phone: 'phone');
      await _authenticationRepository.signup(mockUser, state.password.value);
      emit(state.copyWith(status: FormzStatus.submissionSuccess));
    } catch (e) {
      log(e.toString());
      emit(state.copyWith(status: FormzStatus.submissionFailure));
    }
  }
}
