part of 'notification_bloc.dart';

@immutable
sealed class NotificationEvent {
  const NotificationEvent();
}

class CreateFCMTokenEvent extends NotificationEvent {
  const CreateFCMTokenEvent(
    this.userId,
  );
  final String userId;
}

class CreateFCMListenerEvent extends NotificationEvent {
  const CreateFCMListenerEvent();
}

class UpdateRemoteMessageEvent extends NotificationEvent {
  const UpdateRemoteMessageEvent(
    this.message,
  );
  final RemoteMessage message;
}

class UpdateRemoteMessageStatusEvent extends NotificationEvent {
  const UpdateRemoteMessageStatusEvent(
    this.isReceivedRemoteMessage,
  );
  final bool isReceivedRemoteMessage;
}

class DeleteFCMTokenEvent extends NotificationEvent {
  const DeleteFCMTokenEvent(
    this.userId,
  );
  final String userId;
}
