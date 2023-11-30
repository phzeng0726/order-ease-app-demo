import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ordering_system_client_app/core/controllers/notification/notification_bloc.dart';
import 'package:ordering_system_client_app/core/controllers/order_watcher/order_watcher_bloc.dart';
import 'package:ordering_system_client_app/core/controllers/user_watcher/user_watcher_bloc.dart';
import 'package:ordering_system_client_app/views/core/utils/app_localizations.dart';
import 'package:ordering_system_client_app/views/home/widgets/message_snack_bar.dart';
import 'package:ordering_system_client_app/views/routes/go_router.dart';

class BottomNavigationPage extends StatelessWidget {
  const BottomNavigationPage({
    required this.navigationShell,
    Key? key,
  }) : super(key: key ?? const ValueKey<String>('BottomNavigationPage'));

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return BlocListener<NotificationBloc, NotificationState>(
      listenWhen: (p, c) =>
          p.isReceivedRemoteMessage != c.isReceivedRemoteMessage &&
          c.isReceivedRemoteMessage == true,
      listener: (context, state) {
        final userId = context.read<UserWatcherBloc>().state.user.id!;

        // 跳通知
        ScaffoldMessenger.of(context).showSnackBar(
          MessageSnackBar(
            context,
            message: state.remoteMessage,
            onTap: () => context.goNamed(AppRoutes.orderHistory.toName),
          ),
        );
        // 重抓API
        context.read<OrderWatcherBloc>().add(
              FetchOrderHistoryEvent(userId: userId),
            );
        // 將isReceivedRemoteMessage更改回false
        context.read<NotificationBloc>().add(
              const UpdateRemoteMessageStatusEvent(false),
            );
      },
      child: Scaffold(
        body: navigationShell,
        bottomNavigationBar: BottomNavigationBar(
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: const Icon(Icons.restaurant_menu_outlined),
              activeIcon: const Icon(Icons.restaurant_menu),
              label: AppLocalizations.of(context)!.homeTitle,
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.receipt_long_outlined),
              activeIcon: const Icon(Icons.receipt_long),
              label: AppLocalizations.of(context)!.orderHistoryTitle,
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.person_outline),
              activeIcon: const Icon(Icons.person),
              label: AppLocalizations.of(context)!.accountTitle,
            ),
          ],
          currentIndex: navigationShell.currentIndex,
          onTap: (int index) => _onTap(context, index),
        ),
      ),
    );
  }

  void _onTap(BuildContext context, int index) {
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }
}
