import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ordering_system_client_app/core/controllers/user_watcher/user_watcher_bloc.dart';
import 'package:ordering_system_client_app/core/models/enums/auth_status_enum.dart';
import 'package:ordering_system_client_app/views/core/functions/auth_functions.dart';
import 'package:ordering_system_client_app/views/core/style/main.dart';
import 'package:ordering_system_client_app/views/core/utils/app_localizations.dart';
import 'package:ordering_system_client_app/views/routes/go_router.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<UserWatcherBloc, UserWatcherState>(
      listener: (context, state) async {
        if (state.authStatus == AuthStatus.authenticated) {
          await userAuthInitFunction(context).whenComplete(
            () => context.goNamed(AppRoutes.orderNow.toName),
          );
        } else {
          context.goNamed(AppRoutes.auth.toName);
        }
      },
      child: Scaffold(
        body: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Theme.of(context).colorScheme.inversePrimary,
                const Color.fromARGB(255, 253, 104, 58),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.restaurant,
                size: 66,
                color: Colors.white,
              ),
              const SizedBox(
                height: 6,
              ),
              FittedBox(
                child: Text(
                  AppLocalizations.of(context)!.appTitle.toUpperCase(),
                  style: AppTextStyle.heading1(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
