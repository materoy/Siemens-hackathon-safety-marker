import 'package:formz/formz.dart';

/// Vaidation errors for the [FormzInput] [Email]
enum EmailValidationError {
  /// Just a generic invalid error
  invalid
}

/// Form input for email field
class Email extends FormzInput<String, EmailValidationError> {
  const Email.pure() : super.pure('');

  const Email.dirty([String value = '']) : super.dirty(value);

  static final RegExp _emailRegExp = RegExp(
    r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$',
  );

  @override
  EmailValidationError? validator(String value) {
    return _emailRegExp.hasMatch(value) ? null : EmailValidationError.invalid;
  }
}
