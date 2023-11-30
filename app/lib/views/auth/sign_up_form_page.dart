import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ordering_system_client_app/configurations.dart';
import 'package:ordering_system_client_app/core/controllers/auth/sign_in/sign_in_bloc.dart';
import 'package:ordering_system_client_app/core/controllers/auth/sign_up/sign_up_bloc.dart';
import 'package:ordering_system_client_app/views/auth/widgets/auth_button.dart';
import 'package:ordering_system_client_app/views/auth/widgets/sign_up_input_box_form.dart';
import 'package:ordering_system_client_app/views/core/screen/auth_page_layout.dart';
import 'package:ordering_system_client_app/views/core/utils/app_localizations.dart';
import 'package:ordering_system_client_app/views/core/widgets/custom_dialog.dart';

class SignUpFormPage extends StatelessWidget {
  SignUpFormPage({super.key});

  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final _email = context.read<SignInBloc>().state.email;
    const _languageId = languageId;

    return BlocBuilder<SignUpBloc, SignUpState>(
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
                SignUpInputBoxForm(
                  passwordController: _passwordController,
                  confirmPasswordController: _confirmPasswordController,
                  firstNameController: _firstNameController,
                  lastNameController: _lastNameController,
                ),
                const SizedBox(
                  height: 100,
                ),
                AuthButton(
                  title: AppLocalizations.of(context)!.registerButton,
                  onPressed: () async {
                    FocusScope.of(context).unfocus();
                    if (_formKey.currentState!.validate()) {
                      context.read<SignUpBloc>()
                        ..add(
                          ChangeSignUpFormEvent(
                            password: _passwordController.text,
                            confirmPassword: _confirmPasswordController.text,
                            firstName: _firstNameController.text,
                            lastName: _lastNameController.text,
                          ),
                        )
                        ..add(
                          CreateUserEvent(
                            email: _email,
                            languageId: _languageId,
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
    );
  }
}
