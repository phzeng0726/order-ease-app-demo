import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:meta/meta.dart';
import 'package:ordering_system_client_app/core/models/core/cache_helper.dart';
import 'package:ordering_system_client_app/core/repos/i_notification_repository.dart';
import 'package:ordering_system_client_app/views/core/utils/notification_util.dart';

part 'notification_event.dart';
part 'notification_state.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  final INotificationRepository _notificationRepository;

  NotificationBloc(
    this._notificationRepository,
  ) : super(NotificationState.initial()) {
    on<NotificationEvent>(_onEvent);
  }

  FutureOr<void> _onEvent(
    NotificationEvent event,
    Emitter<NotificationState> emit,
  ) async {
    if (event is CreateFCMTokenEvent) {
      final String? token = await NotificationUtil.getFCMToken();
      print('This FCM token: $token');

      final String tempToken = CacheHelper.getTempFCMToken();

      if (token != null && token != tempToken) {
        print('New FCM token: $token');
        final failureOption = await _notificationRepository.createFcmToken(
          userId: event.userId,
          token: token,
        );

        failureOption.fold(
          () => CacheHelper.saveTempFCMToken(token),
          (f) => print(f),
        );
      }
    } else if (event is CreateFCMListenerEvent) {
      FirebaseMessaging.onMessage.listen(
        (message) {
          print('Remote message received!');
          add(UpdateRemoteMessageEvent(message));
          add(const UpdateRemoteMessageStatusEvent(true));
        },
      );
    } else if (event is UpdateRemoteMessageEvent) {
      emit(
        state.copyWith(
          remoteMessage: event.message,
        ),
      );
    } else if (event is UpdateRemoteMessageStatusEvent) {
      emit(
        state.copyWith(
          isReceivedRemoteMessage: event.isReceivedRemoteMessage,
        ),
      );
    } else if (event is DeleteFCMTokenEvent) {
      print('Delete ${event.userId}');
      final String? token = await NotificationUtil.getFCMToken();

      if (token != null) {
        final failureOption = await _notificationRepository.deleteFcmToken(
          userId: event.userId,
          token: token,
        );

        await NotificationUtil.delFCMToken();

        failureOption.fold(
          () => print('Delete token success'),
          (f) => print(f),
        );
      }
    }
  }
}
