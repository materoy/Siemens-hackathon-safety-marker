import 'package:authentication/authentication.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:image_picker/image_picker.dart';
import 'package:siemens_hackathon_safety_marker/app/global/global.dart';
import 'package:siemens_hackathon_safety_marker/app/modules/signup/cubit/signup_cubit.dart';

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
      child: Container(
        alignment: const Alignment(0, -1 / 3),
        padding: EdgeInsets.symmetric(horizontal: SizeConfig.unitWidth * 10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _ProfileImage(),
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

class _ProfileImage extends StatelessWidget {
  _ProfileImage({Key? key}) : super(key: key);
  final ImagePicker _picker = ImagePicker();

  Future _pickImage(BuildContext context) async {
    final image = await _picker.pickImage(source: ImageSource.camera);
    if (image != null) {
      final imageBytes = await image.readAsBytes();
      context.read<SignupCubit>().imageChanged(imageBytes);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignupCubit, SignupState>(
      buildWhen: (previous, current) => current.image != null,
      builder: (context, state) {
        final size = SizeConfig.unitHeight * 20;
        return Container(
          width: size,
          height: size,
          clipBehavior: Clip.hardEdge,
          decoration: const BoxDecoration(
            color: Colors.grey,
            shape: BoxShape.circle,
          ),
          child: Stack(
            children: [
              if (state.image != null)
                Center(
                    child: SizedBox(
                        width: double.infinity,
                        height: double.infinity,
                        child: Image.memory(state.image!, fit: BoxFit.cover))),
              Align(
                alignment: state.image != null
                    ? Alignment.bottomRight
                    : Alignment.center,
                child: IconButton(
                  icon: const Icon(CupertinoIcons.photo_camera),
                  color: Colors.blue,
                  onPressed: () async {
                    await _pickImage(context);
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class FormTextField extends StatelessWidget {
  const FormTextField({
    Key? key,
    this.textFieldKey,
    required this.onChanged,
    required this.keyboardType,
    required this.labelText,
    this.errorText,
    this.obscureText,
  }) : super(key: key);

  final Key? textFieldKey;
  final Function(String) onChanged;
  final TextInputType keyboardType;
  final String labelText;
  final String? errorText;
  final bool? obscureText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: SizeConfig.unitHeight * 2),
      child: TextFormField(
        key: key,
        onChanged: onChanged,
        obscureText: obscureText ?? false,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
          labelText: labelText,
          errorText: errorText,
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
        return FormTextField(
          key: const Key('signupForm_emailInput_textField'),
          onChanged: (email) => context.read<SignupCubit>().emailChanged(email),
          keyboardType: TextInputType.emailAddress,
          labelText: 'email',
          errorText: state.email.invalid ? 'invalid email' : null,
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
        return FormTextField(
          key: const Key('signupForm_passwordInput_textField'),
          keyboardType: TextInputType.visiblePassword,
          onChanged: (password) =>
              context.read<SignupCubit>().passwordChanged(password),
          obscureText: true,
          labelText: 'password',
          errorText: state.password.invalid ? 'invalid password' : null,
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
        return FormTextField(
          key: const Key('signupForm_confirmPasswordInput_textField'),
          onChanged: (confirmPassword) => context
              .read<SignupCubit>()
              .confirmPasswordChanged(confirmPassword),
          obscureText: true,
          keyboardType: TextInputType.visiblePassword,
          labelText: 'confirm password',
          errorText:
              state.confirmPassword.invalid ? 'passwords do not match' : null,
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
