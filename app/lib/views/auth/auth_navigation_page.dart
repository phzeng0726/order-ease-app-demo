import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ordering_system_client_app/core/controllers/auth/sign_in/sign_in_bloc.dart';
import 'package:ordering_system_client_app/core/controllers/auth/sign_up/sign_up_bloc.dart';
import 'package:ordering_system_client_app/core/controllers/user_watcher/user_watcher_bloc.dart';
import 'package:ordering_system_client_app/core/models/enums/auth_status_enum.dart';
import 'package:ordering_system_client_app/views/auth/sign_in_email_page.dart';
import 'package:ordering_system_client_app/views/core/functions/auth_functions.dart';
import 'package:ordering_system_client_app/views/core/utils/app_screen_util.dart';
import 'package:ordering_system_client_app/views/core/widgets/custom_dialog.dart';
import 'package:ordering_system_client_app/views/core/widgets/loading_overlay.dart';
import 'package:ordering_system_client_app/views/routes/go_router.dart';

class AuthNavigationPage extends StatelessWidget {
  const AuthNavigationPage({super.key});

  @override
  Widget build(BuildContext context) {
    for (var route in goRouter.routerDelegate.currentConfiguration.matches) {
      print(route.matchedLocation);
    }

    return MultiBlocListener(
      listeners: [
        // User 狀態判斷，CheckAuthEvent得到的結果
        BlocListener<UserWatcherBloc, UserWatcherState>(
          listenWhen: (p, c) => p.authStatus != c.authStatus,
          listener: (context, state) async {
            LoadingOverlay.hide();

            if (state.authStatus == AuthStatus.authenticated) {
              await userAuthInitFunction(context).whenComplete(
                () => context.goNamed(AppRoutes.orderNow.toName),
              );
            }
          },
        ),
        // 登入狀態判斷
        BlocListener<SignInBloc, SignInState>(
          listenWhen: (p, c) => p.status != c.status,
          listener: (context, state) {
            AppScreenUtil.mapLoadStatus(
              state.status,
              initial: () {},
              inProgress: () => LoadingOverlay.show(context),
              succeed: () {
                if (state.step == SignInStep.email) {
                  if (state.isEmailNotFound) {
                    LoadingOverlay.hide();

                    // 前往註冊前OTP驗證
                    context.pushNamed(
                      AppRoutes.verifyOTP.toName,
                      queryParameters: {
                        'email': state.email,
                        'succeedRouteToName': AppRoutes.signUpForm.toName,
                      },
                    );
                  } else if (state.isAnonymouslyUser) {
                    context.read<UserWatcherBloc>().add(
                          const CheckAuthEvent(),
                        );
                  } else {
                    LoadingOverlay.hide();
                    context.pushNamed(AppRoutes.signInPassword.toName);
                  }
                } else if (state.step == SignInStep.password) {
                  context.read<UserWatcherBloc>().add(
                        const CheckAuthEvent(),
                      );
                }
              },
              failed: () => showErrorDialog(
                context,
                contentOption: state.failureOption,
              ),
            );
          },
        ),
        // 註冊狀態判斷
        BlocListener<SignUpBloc, SignUpState>(
          listenWhen: (p, c) => p.status != c.status,
          listener: (context, state) {
            AppScreenUtil.mapLoadStatus(
              state.status,
              initial: () {},
              inProgress: () => LoadingOverlay.show(context),
              succeed: () {
                context.read<UserWatcherBloc>().add(
                      const CheckAuthEvent(),
                    );
              },
              failed: () => showErrorDialog(
                context,
                contentOption: state.failureOption,
              ),
            );
          },
        )
      ],
      child: SignInEmailPage(),
    );
  }
}
