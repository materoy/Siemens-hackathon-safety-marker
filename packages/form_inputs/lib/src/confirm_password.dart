import 'package:formz/formz.dart';

/// Validation errors for the [Password] [FormzInput].
enum ConfirmPasswordValidationError {
  /// Generic invalid error.
  invalid
}

/// {@template password}
/// Form input for an password input.
/// {@endtemplate}
class ConfirmPassword
    extends FormzInput<String, ConfirmPasswordValidationError> {
  /// {@macro password}
  const ConfirmPassword.pure({this.password = ''}) : super.pure('');

  /// {@macro password}
  const ConfirmPassword.dirty({this.password = '', String value = ''})
      : super.dirty(value);

  static final _passwordRegExp =
      RegExp(r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$');

  // original password
  final String password;

  @override
  ConfirmPasswordValidationError? validator(String? value) {
    return _passwordRegExp.hasMatch(value ?? '')
        ? null
        : ConfirmPasswordValidationError.invalid;
  }
}
