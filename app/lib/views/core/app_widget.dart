import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ordering_system_client_app/core/controllers/auth/sign_in/sign_in_bloc.dart';
import 'package:ordering_system_client_app/core/controllers/auth/sign_up/sign_up_bloc.dart';
import 'package:ordering_system_client_app/core/controllers/menu_watcher/menu_watcher_bloc.dart';
import 'package:ordering_system_client_app/core/controllers/notification/notification_bloc.dart';
import 'package:ordering_system_client_app/core/controllers/order_form/order_form_bloc.dart';
import 'package:ordering_system_client_app/core/controllers/order_watcher/order_watcher_bloc.dart';
import 'package:ordering_system_client_app/core/controllers/user_watcher/user_watcher_bloc.dart';
import 'package:ordering_system_client_app/core/repos/auth_repository.dart';
import 'package:ordering_system_client_app/core/repos/firebase_facade.dart';
import 'package:ordering_system_client_app/core/repos/notification_repository.dart';
import 'package:ordering_system_client_app/core/repos/order_repository.dart';
import 'package:ordering_system_client_app/views/core/style/main.dart';
import 'package:ordering_system_client_app/views/core/utils/app_localizations.dart';
import 'package:ordering_system_client_app/views/routes/go_router.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => FirebaseFacade(),
        ),
        RepositoryProvider(
          create: (context) => AuthRepository(),
        ),
        RepositoryProvider(
          create: (context) => NotificationRepository(),
        ),
        RepositoryProvider(
          create: (context) => OrderRepository(),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => NotificationBloc(
              context.read<NotificationRepository>(),
            ),
          ),
          BlocProvider(
            create: (context) => UserWatcherBloc(
              context.read<AuthRepository>(),
              context.read<FirebaseFacade>(),
            )..add(const CheckAuthEvent()),
          ),
          BlocProvider(
            create: (context) => SignInBloc(
              context.read<AuthRepository>(),
              context.read<FirebaseFacade>(),
            ),
          ),
          BlocProvider(
            create: (context) => SignUpBloc(
              context.read<AuthRepository>(),
              context.read<FirebaseFacade>(),
            ),
          ),
          BlocProvider(
            create: (context) => MenuWatcherBloc(
              context.read<OrderRepository>(),
            ),
          ),
          BlocProvider(
            create: (context) => OrderWatcherBloc(
              context.read<OrderRepository>(),
            ),
          ),
          BlocProvider(
            create: (context) => OrderFormBloc(
              context.read<OrderRepository>(),
            ),
          ),
        ],
        child: MaterialApp.router(
          title: 'Ordering Client App',
          theme: ThemeData(
            appBarTheme: const AppBarTheme(
              centerTitle: true,
            ),
            colorScheme: ColorScheme.fromSeed(
              seedColor: ColorStyle.orange,
            ),
            useMaterial3: true,
          ),
          routerConfig: goRouter,
          debugShowCheckedModeBanner: false,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
        ),
      ),
    );
  }
}
