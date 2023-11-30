part of 'notification_bloc.dart';

class NotificationState extends Equatable {
  const NotificationState({
    required this.remoteMessage,
    required this.isReceivedRemoteMessage,
  });

  final RemoteMessage remoteMessage;
  final bool isReceivedRemoteMessage;

  factory NotificationState.initial() => const NotificationState(
        remoteMessage: RemoteMessage(),
        isReceivedRemoteMessage: false,
      );

  NotificationState copyWith({
    RemoteMessage? remoteMessage,
    bool? isReceivedRemoteMessage,
  }) {
    return NotificationState(
      remoteMessage: remoteMessage ?? this.remoteMessage,
      isReceivedRemoteMessage:
          isReceivedRemoteMessage ?? this.isReceivedRemoteMessage,
    );
  }

  @override
  List<Object> get props => [
        remoteMessage,
        isReceivedRemoteMessage,
      ];
}
