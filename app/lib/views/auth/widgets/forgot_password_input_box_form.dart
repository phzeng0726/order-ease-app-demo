import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ordering_system_client_app/core/controllers/auth/sign_up/sign_up_bloc.dart';
import 'package:ordering_system_client_app/core/models/core/auth_validator.dart';
import 'package:ordering_system_client_app/views/auth/widgets/sign_up_input_box.dart';
import 'package:ordering_system_client_app/views/core/utils/app_localizations.dart';

class ForgotPasswordInputBoxForm extends StatelessWidget {
  const ForgotPasswordInputBoxForm({
    super.key,
    this.passwordController,
    this.confirmPasswordController,
  });

  final TextEditingController? passwordController;
  final TextEditingController? confirmPasswordController;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpBloc, SignUpState>(
      builder: (context, state) {
        final List<SignUpInputBox> inputBoxList = [
          SignUpInputBox(
            controller: passwordController,
            title: AppLocalizations.of(context)!.setPassword,
            hintText: AppLocalizations.of(context)!.passwordHintText,
            maxLength: 16,
            obscureText: !state.isPasswordVisible,
            suffixIcon: IconButton(
              onPressed: () => context.read<SignUpBloc>().add(
                    const ChangePasswordVisibleEvent(),
                  ),
              icon: Icon(
                state.isPasswordVisible
                    ? Icons.visibility
                    : Icons.visibility_off,
                size: 24.0,
              ),
            ),
            validator: (input) => input!.isValidPassword(
              context,
              confirmPasswordController!.text,
            ),
          ),
          SignUpInputBox(
            controller: confirmPasswordController,
            title: AppLocalizations.of(context)!.confirmPassword,
            hintText: AppLocalizations.of(context)!.passwordHintText,
            maxLength: 16,
            obscureText: !state.isConfirmPasswordVisible,
            suffixIcon: IconButton(
              onPressed: () => context.read<SignUpBloc>().add(
                    const ChangeConfirmPasswordVisibleEvent(),
                  ),
              icon: Icon(
                state.isConfirmPasswordVisible
                    ? Icons.visibility
                    : Icons.visibility_off,
                size: 24.0,
              ),
            ),
            validator: (input) => input!.isValidConfirmPassword(
              context,
              passwordController!.text,
            ),
          ),
        ];

        return Column(
          children: inputBoxList
              .map(
                (inputBox) => Column(
                  children: [
                    inputBox,
                    const SizedBox(
                      height: 12.0,
                    )
                  ],
                ),
              )
              .toList(),
        );
      },
    );
  }
}
