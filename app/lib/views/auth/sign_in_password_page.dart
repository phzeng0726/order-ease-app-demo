import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ordering_system_client_app/core/controllers/auth/sign_in/sign_in_bloc.dart';
import 'package:ordering_system_client_app/core/models/core/auth_validator.dart';
import 'package:ordering_system_client_app/views/auth/widgets/auth_button.dart';
import 'package:ordering_system_client_app/views/auth/widgets/auth_input_box.dart';
import 'package:ordering_system_client_app/views/core/screen/auth_page_layout.dart';
import 'package:ordering_system_client_app/views/core/style/main.dart';
import 'package:ordering_system_client_app/views/core/utils/app_localizations.dart';
import 'package:ordering_system_client_app/views/routes/go_router.dart';

class SignInPasswordPage extends StatelessWidget {
  SignInPasswordPage({super.key});

  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignInBloc, SignInState>(
      builder: (context, state) {
        return AuthPageLayout(
          appBarTitle: AppLocalizations.of(context)!.appTitle,
          bodyForm: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                AuthInputBox(
                  controller: _passwordController,
                  labelText: AppLocalizations.of(context)!.enteredPassword,
                  obscureText: !state.isPasswordVisible,
                  suffixIcon: IconButton(
                    onPressed: () => context.read<SignInBloc>().add(
                          const ChangePasswordVisibleEvent(),
                        ),
                    icon: Icon(
                      state.isPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                      size: 24.0,
                    ),
                  ),
                  validator: (input) => input!.isValidSignInPassword(context),
                ),
                const SizedBox(
                  height: 6,
                ),
                // Forgot password
                GestureDetector(
                  onTap: () => context.pushNamed(
                    AppRoutes.verifyOTP.toName,
                    queryParameters: {
                      'email': state.email,
                      'succeedRouteToName': AppRoutes.forgotPassword.toName,
                    },
                  ),
                  child: Text(
                    AppLocalizations.of(context)!.forgotPassword,
                    style: AppTextStyle.text(
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 100,
                ),
                AuthButton(
                  title: AppLocalizations.of(context)!.loginButton,
                  onPressed: () async {
                    FocusScope.of(context).unfocus();
                    if (_formKey.currentState!.validate()) {
                      context.read<SignInBloc>()
                        ..add(
                          ChangePasswordEvent(_passwordController.text),
                        )
                        ..add(
                          const PressSignInWithEmailEvent(),
                        );
                    }
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
