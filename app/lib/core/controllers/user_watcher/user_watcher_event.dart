part of 'user_watcher_bloc.dart';

@immutable
sealed class UserWatcherEvent {
  const UserWatcherEvent();
}

class CheckAuthEvent extends UserWatcherEvent {
  const CheckAuthEvent();
}

class FetchUserDataEvent extends UserWatcherEvent {
  const FetchUserDataEvent();
}

class CheckSignUpEvent extends UserWatcherEvent {
  const CheckSignUpEvent();
}

class LogoutEvent extends UserWatcherEvent {
  const LogoutEvent();
}
