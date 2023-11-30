import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ordering_system_client_app/views/auth/auth_navigation_page.dart';
import 'package:ordering_system_client_app/views/auth/forgot_password_page.dart';
import 'package:ordering_system_client_app/views/auth/sign_in_email_page.dart';
import 'package:ordering_system_client_app/views/auth/sign_in_password_page.dart';
import 'package:ordering_system_client_app/views/auth/sign_up_form_page.dart';
import 'package:ordering_system_client_app/views/auth/verify_otp_page.dart';
import 'package:ordering_system_client_app/views/home/account/account_page.dart';
import 'package:ordering_system_client_app/views/home/bottom_navigation_page.dart';
import 'package:ordering_system_client_app/views/home/order_history/order_history_page.dart';
import 'package:ordering_system_client_app/views/home/order_now/menu/menu_page.dart';
import 'package:ordering_system_client_app/views/home/order_now/order_now_page.dart';
import 'package:ordering_system_client_app/views/home/order_now/qr_view_page.dart';
import 'package:ordering_system_client_app/views/splash/splash_page.dart';

enum AppRoutes {
  splash,
  auth,
  signInEmail,
  signInPassword,
  verifyOTP,
  signUpForm,
  forgotPassword,
  orderNow,
  orderHistory,
  account,
  qrScan,
  menu,
}

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>(
  debugLabel: 'root',
);
final GlobalKey<NavigatorState> _sectionANavigatorKey =
    GlobalKey<NavigatorState>(
  debugLabel: 'sectionANav',
);
final GoRouter goRouter = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: AppRoutes.splash.toPath,
  observers: [MyNavigatorObserver()],
  routerNeglect: true,
  debugLogDiagnostics: true,
  routes: <RouteBase>[
    GoRoute(
      path: AppRoutes.splash.toPath,
      builder: (context, state) => const SplashPage(),
    ),
    // Auth
    GoRoute(
      path: AppRoutes.auth.toPath,
      name: AppRoutes.auth.toName,
      builder: (context, state) => const AuthNavigationPage(),
      routes: [
        GoRoute(
          path: AppRoutes.signInEmail.toPath,
          name: AppRoutes.signInEmail.toName,
          builder: (context, state) => SignInEmailPage(),
        ),
        GoRoute(
          path: AppRoutes.signInPassword.toPath,
          name: AppRoutes.signInPassword.toName,
          builder: (context, state) => SignInPasswordPage(),
        ),
        GoRoute(
          path: AppRoutes.verifyOTP.toPath,
          name: AppRoutes.verifyOTP.toName,
          builder: (context, state) {
            return VerifyOTPPage(
              email: state.uri.queryParameters['email'] ?? '',
              succeedRouteToName:
                  state.uri.queryParameters['succeedRouteToName'] ?? '',
            );
          },
        ),
        GoRoute(
          path: AppRoutes.signUpForm.toPath,
          name: AppRoutes.signUpForm.toName,
          builder: (context, state) => SignUpFormPage(),
        ),
        GoRoute(
          path: AppRoutes.forgotPassword.toPath,
          name: AppRoutes.forgotPassword.toName,
          builder: (context, state) => ForgotPasswordPage(),
        ),
      ],
    ),

    // Home
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return BottomNavigationPage(
          navigationShell: navigationShell,
        );
      },
      branches: <StatefulShellBranch>[
        StatefulShellBranch(
          navigatorKey: _sectionANavigatorKey,
          routes: <RouteBase>[
            GoRoute(
                path: AppRoutes.orderNow.toPath,
                name: AppRoutes.orderNow.toName,
                builder: (context, state) => const OrderNowPage(),
                routes: [
                  GoRoute(
                    path: AppRoutes.menu.toPath,
                    name: AppRoutes.menu.toName,
                    builder: (context, state) => const MenuPage(),
                  ),
                  GoRoute(
                    path: AppRoutes.qrScan.toPath,
                    name: AppRoutes.qrScan.toName,
                    builder: (context, state) => const QRViewPage(),
                  ),
                ]),
          ],
        ),
        StatefulShellBranch(
          routes: <RouteBase>[
            GoRoute(
              path: AppRoutes.orderHistory.toPath,
              name: AppRoutes.orderHistory.toName,
              builder: (context, state) => const OrderHistoryPage(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: <RouteBase>[
            GoRoute(
              path: AppRoutes.account.toPath,
              name: AppRoutes.account.toName,
              builder: (context, state) => const AccountPage(),
            ),
          ],
        ),
      ],
    ),
  ],
);

extension AppRoutesExtension on AppRoutes {
  String get toName {
    switch (this) {
      case AppRoutes.splash:
        return '';
      case AppRoutes.auth:
        return 'auth';
      case AppRoutes.signInEmail:
        return 'signInEmail';
      case AppRoutes.signInPassword:
        return 'signInPassword';
      case AppRoutes.verifyOTP:
        return 'verifyOTP';
      case AppRoutes.signUpForm:
        return 'signUpForm';
      case AppRoutes.forgotPassword:
        return 'forgotPassword';

      case AppRoutes.orderNow:
        return 'home';
      case AppRoutes.menu:
        return 'menu';
      case AppRoutes.qrScan:
        return 'qrScan';

      case AppRoutes.orderHistory:
        return 'orderHistory';
      case AppRoutes.account:
        return 'account';
    }
  }

  String get toPath {
    switch (this) {
      case AppRoutes.splash:
        return '/${AppRoutes.splash.toName}';
      case AppRoutes.auth:
        return '/${AppRoutes.auth.toName}';
      case AppRoutes.signInEmail:
        return AppRoutes.signInEmail.toName;
      case AppRoutes.signInPassword:
        return AppRoutes.signInPassword.toName;
      case AppRoutes.verifyOTP:
        return AppRoutes.verifyOTP.toName;
      case AppRoutes.signUpForm:
        return AppRoutes.signUpForm.toName;
      case AppRoutes.forgotPassword:
        return AppRoutes.forgotPassword.toName;

      case AppRoutes.orderNow:
        return '/${AppRoutes.orderNow.toName}';
      case AppRoutes.menu:
        return AppRoutes.menu.toName;
      case AppRoutes.qrScan:
        return AppRoutes.qrScan.toName;

      case AppRoutes.orderHistory:
        return '/${AppRoutes.orderHistory.toName}';
      case AppRoutes.account:
        return '/${AppRoutes.account.toName}';
    }
  }
}

class MyNavigatorObserver extends NavigatorObserver {
  static List<String> backStack = [];

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    backStack.add(route.settings.name ?? '');
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    backStack.removeLast();
  }
}

extension BuildContextExtension<T> on BuildContext {
  void goPopUntilNamed(String routeName) {
    if (kDebugMode) {
      print(MyNavigatorObserver.backStack);
    }

    if (!MyNavigatorObserver.backStack.contains(routeName)) return;

    while (MyNavigatorObserver.backStack.last != AppRoutes.splash.toName) {
      print(MyNavigatorObserver.backStack.last);
      if (MyNavigatorObserver.backStack.last == routeName) {
        return;
      }
      GoRouter.of(this).pop();
    }
  }

  void goPushAndRemoveUntilNamed(String routeName) {
    if (kDebugMode) {
      print('Before Remove: ${MyNavigatorObserver.backStack}');
    }

    while (MyNavigatorObserver.backStack.last != AppRoutes.splash.toName) {
      if (!canPop()) {
        if (kDebugMode) {
          print('After Remove: ${MyNavigatorObserver.backStack}');
        }
        GoRouter.of(this).goNamed(routeName);
      }

      print(MyNavigatorObserver.backStack.last);
      GoRouter.of(this).pop();
    }
  }
}
