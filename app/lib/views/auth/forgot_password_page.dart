import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ordering_system_client_app/core/controllers/auth/forgot_password/forgot_password_bloc.dart';
import 'package:ordering_system_client_app/core/controllers/auth/sign_in/sign_in_bloc.dart';
import 'package:ordering_system_client_app/core/repos/auth_repository.dart';
import 'package:ordering_system_client_app/views/auth/widgets/auth_button.dart';
import 'package:ordering_system_client_app/views/auth/widgets/forgot_password_input_box_form.dart';
import 'package:ordering_system_client_app/views/core/screen/auth_page_layout.dart';
import 'package:ordering_system_client_app/views/core/utils/app_localizations.dart';
import 'package:ordering_system_client_app/views/core/utils/app_screen_util.dart';
import 'package:ordering_system_client_app/views/core/widgets/custom_dialog.dart';
import 'package:ordering_system_client_app/views/core/widgets/loading_overlay.dart';
import 'package:ordering_system_client_app/views/routes/go_router.dart';

class ForgotPasswordPage extends StatelessWidget {
  ForgotPasswordPage({super.key});

  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final _tempUserId = context.read<SignInBloc>().state.tempUserId;

    return BlocProvider(
      create: (context) => ForgotPasswordBloc(
        context.read<AuthRepository>(),
      ),
      child: BlocConsumer<ForgotPasswordBloc, ForgotPasswordState>(
        listenWhen: (p, c) => p.status != c.status,
        listener: (context, state) {
          AppScreenUtil.mapLoadStatus(
            state.status,
            initial: () {},
            inProgress: () => LoadingOverlay.show(context),
            succeed: () {
              LoadingOverlay.hide();

              context.goPopUntilNamed(
                AppRoutes.signInPassword.toName,
              );
            },
            failed: () => showErrorDialog(
              context,
              contentOption: state.failureOption,
            ),
          );
        },
        builder: (context, state) {
          return AuthPageLayout(
            appBarTitle: AppLocalizations.of(context)!.appTitle,
            leading: IconButton(
              onPressed: () => showActionDialog(
                context,
                title: AppLocalizations.of(context)!.confirmExitDialogTitle,
                content: AppLocalizations.of(context)!.confirmExitDialogContent,
                leftTitle: AppLocalizations.of(context)!.back,
                rightTitle: AppLocalizations.of(context)!.exit,
                rightOnPressed: () => context
                  ..pop()
                  ..pop(),
              ),
              icon: const Icon(
                Icons.arrow_back_rounded,
              ),
            ),
            bodyForm: Form(
              key: _formKey,
              child: Column(
                children: [
                  ForgotPasswordInputBoxForm(
                    passwordController: _passwordController,
                    confirmPasswordController: _confirmPasswordController,
                  ),
                  const SizedBox(
                    height: 100,
                  ),
                  AuthButton(
                    title: AppLocalizations.of(context)!.submit,
                    onPressed: () async {
                      FocusScope.of(context).unfocus();
                      if (_formKey.currentState!.validate()) {
                        context.read<ForgotPasswordBloc>()
                          ..add(
                            ChangeForgotPasswordFormEvent(
                              password: _passwordController.text,
                              confirmPassword: _confirmPasswordController.text,
                            ),
                          )
                          ..add(
                            ResetPasswordEvent(
                              userId: _tempUserId,
                            ),
                          );
                      }
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
