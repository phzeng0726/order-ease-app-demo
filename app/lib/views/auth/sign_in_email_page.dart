import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ordering_system_client_app/core/controllers/auth/sign_in/sign_in_bloc.dart';
import 'package:ordering_system_client_app/core/models/core/auth_validator.dart';
import 'package:ordering_system_client_app/views/auth/widgets/auth_button.dart';
import 'package:ordering_system_client_app/views/auth/widgets/auth_input_box.dart';
import 'package:ordering_system_client_app/views/core/screen/auth_page_layout.dart';
import 'package:ordering_system_client_app/views/core/style/main.dart';
import 'package:ordering_system_client_app/views/core/utils/app_localizations.dart';

class SignInEmailPage extends StatelessWidget {
  SignInEmailPage({super.key});

  final _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

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
                  controller: _emailController,
                  labelText: AppLocalizations.of(context)!.email,
                  keyboardType: TextInputType.emailAddress,
                  validator: (input) => input!.isValidEmail(context),
                ),
                const SizedBox(
                  height: 6,
                ),
                SizedBox(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(
                        Icons.warning_rounded,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Text(
                          AppLocalizations.of(context)!.authWarning,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 100,
                ),
                AuthButton(
                  title: AppLocalizations.of(context)!.authTitle,
                  onPressed: () async {
                    FocusScope.of(context).unfocus();
                    if (_formKey.currentState!.validate()) {
                      context.read<SignInBloc>()
                        ..add(
                          ChangeEmailEvent(
                            _emailController.text,
                          ),
                        )
                        ..add(
                          const CheckHasUserEvent(),
                        );
                    }
                  },
                ),
                const SizedBox(height: 20),
                AuthButton(
                  title: AppLocalizations.of(context)!.anonymousLogin,
                  backgroundColor: ColorStyle.paleGrey,
                  leadingIcon: const Icon(
                    Icons.person_outline,
                    color: ColorStyle.darkGrey,
                  ),
                  onPressed: () async {
                    FocusScope.of(context).unfocus();
                    context.read<SignInBloc>().add(
                          const PressSignInAnonymouslyEvent(),
                        );
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
