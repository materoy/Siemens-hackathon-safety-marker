part of 'signup_cubit.dart';

enum ConfirmPasswordValidationError { invalid }

class SignupState extends Equatable {
  const SignupState(
      {this.email = const Email.pure(),
      this.password = const Password.pure(),
      this.confirmPassword = const ConfirmPassword.pure(),
      this.status = FormzStatus.pure,
      this.image});

  final Email email;
  final Password password;
  final ConfirmPassword confirmPassword;
  final FormzStatus status;
  final Uint8List? image;

  @override
  List<Object> get props => [email, password, confirmPassword, status];

  SignupState copyWith({
    Email? email,
    Password? password,
    ConfirmPassword? confirmPassword,
    FormzStatus? status,
    Uint8List? image,
  }) {
    return SignupState(
      email: email ?? this.email,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      status: status ?? this.status,
      image: image ?? this.image,
    );
  }
}
