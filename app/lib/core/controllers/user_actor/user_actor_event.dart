part of 'user_actor_bloc.dart';

@immutable
sealed class UserActorEvent {
  const UserActorEvent();
}

class DeleteUserEvent extends UserActorEvent {
  const DeleteUserEvent({
    required this.userId,
  });
  final String userId;
}

class DeleteAnonymousUserEvent extends UserActorEvent {
  const DeleteAnonymousUserEvent();
}
