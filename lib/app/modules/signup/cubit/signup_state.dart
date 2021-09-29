part of 'signup_cubit.dart';

enum ConfirmPasswordValidationError { invalid }

class SignupState extends Equatable {
  const SignupState(
      {this.email = const Email.pure(),
      this.firstName = '',
      this.lastName = '',
      this.password = const Password.pure(),
      this.confirmPassword = const ConfirmPassword.pure(),
      this.status = FormzStatus.pure,
      this.image});

  final Email email;
  final Password password;
  final String firstName;
  final String lastName;
  final ConfirmPassword confirmPassword;
  final FormzStatus status;
  final Uint8List? image;

  @override
  List<Object> get props =>
      [email, password, confirmPassword, status, firstName, lastName];

  SignupState copyWith({
    String? firstName,
    String? lastName,
    Email? email,
    Password? password,
    ConfirmPassword? confirmPassword,
    FormzStatus? status,
    Uint8List? image,
  }) {
    return SignupState(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      status: status ?? this.status,
      image: image ?? this.image,
    );
  }
}
