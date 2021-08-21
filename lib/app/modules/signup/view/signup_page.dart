import 'package:authentication/authentication.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:siemens_hackathon_safety_marker/app/modules/signup/cubit/signup_cubit.dart';
import 'package:formz/formz.dart';

class SignupPage extends StatelessWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider<SignupCubit>(
        create: (context) =>
            SignupCubit(context.read<AuthenticationRepository>()),
        child: const SignupForm(),
      ),
    );
  }
}

class SignupForm extends StatelessWidget {
  const SignupForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignupCubit, SignupState>(
      listener: (context, state) {
        if (state.status.isSubmissionSuccess) {
          Navigator.pop(context);
        } else if (state.status.isSubmissionFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(const SnackBar(content: Text('Sign up failed')));
        }
      },
      child: Align(
        alignment: const Alignment(0, -1 / 3),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _EmailInput(),
            const SizedBox(height: 8),
            _PasswordInput(),
            const SizedBox(height: 8),
            _ConfirmPasswordInput(),
            const SizedBox(height: 8),
            _SignupButton(),
          ],
        ),
      ),
    );
  }
}

class _EmailInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignupCubit, SignupState>(
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) {
        return TextField(
          key: const Key('signupForm_emailInput_textField'),
          onChanged: (email) => context.read<SignupCubit>().emailChanged(email),
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            labelText: 'email',
            helperText: '',
            errorText: state.email.invalid ? 'invalid email' : null,
          ),
        );
      },
    );
  }
}

class _PasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignupCubit, SignupState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return TextField(
          key: const Key('signupForm_passwordInput_textField'),
          onChanged: (password) =>
              context.read<SignupCubit>().passwordChanged(password),
          obscureText: true,
          decoration: InputDecoration(
            labelText: 'password',
            helperText: '',
            errorText: state.password.invalid ? 'invalid password' : null,
          ),
        );
      },
    );
  }
}

class _ConfirmPasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignupCubit, SignupState>(
      buildWhen: (previous, current) =>
          previous.password != current.password ||
          previous.confirmPassword != current.confirmPassword,
      builder: (context, state) {
        return TextField(
          key: const Key('signupForm_confirmPasswordInput_textField'),
          onChanged: (confirmPassword) => context
              .read<SignupCubit>()
              .confirmPasswordChanged(confirmPassword),
          obscureText: true,
          decoration: InputDecoration(
            labelText: 'confirm password',
            helperText: '',
            errorText:
                state.confirmPassword.invalid ? 'passwords do not match' : null,
          ),
        );
      },
    );
  }
}

class _SignupButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignupCubit, SignupState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return state.status.isSubmissionInProgress
            ? const CircularProgressIndicator()
            : ElevatedButton(
                key: const Key('signupForm_continue_raisedButton'),
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  primary: Colors.orangeAccent,
                ),
                onPressed: state.status.isValidated
                    ? () => context.read<SignupCubit>().signupFormSubmitted()
                    : null,
                child: const Text('SIGN UP'),
              );
      },
    );
  }
}
