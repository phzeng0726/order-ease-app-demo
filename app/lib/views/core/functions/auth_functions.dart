import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ordering_system_client_app/core/controllers/auth/sign_in/sign_in_bloc.dart';
import 'package:ordering_system_client_app/core/controllers/notification/notification_bloc.dart';
import 'package:ordering_system_client_app/core/controllers/order_watcher/order_watcher_bloc.dart';
import 'package:ordering_system_client_app/core/controllers/user_watcher/user_watcher_bloc.dart';

// 登入成功的listener
Future<void> userAuthInitFunction(BuildContext context) async {
  final String userId = context.read<UserWatcherBloc>().state.user.id!;

  // 更新firebase message的token到server
  context.read<NotificationBloc>()
    ..add(CreateFCMTokenEvent(userId))
    ..add(const CreateFCMListenerEvent());

  context.read<OrderWatcherBloc>().add(
        FetchOrderHistoryEvent(
          userId: userId,
        ),
      );
}

// 登出時要清空的所有東西
Future<void> userUnAuthFunction(BuildContext context) async {
  final String userId = context.read<UserWatcherBloc>().state.user.id!;

  // 清除Auth相關
  context.read<SignInBloc>().add(const InitialEvent());

  // 清除FCM
  context.read<NotificationBloc>().add(
        DeleteFCMTokenEvent(userId),
      );
}
