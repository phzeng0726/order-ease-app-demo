part of 'user_watcher_bloc.dart';

class UserWatcherState extends Equatable {
  const UserWatcherState({
    required this.user,
    required this.isAnonymousUser,
    required this.failureOption,
    required this.authStatus,
  });

  final UserData user;
  final bool isAnonymousUser;
  final Option<AuthFailure> failureOption;
  final AuthStatus authStatus;

  factory UserWatcherState.initial() => UserWatcherState(
        user: UserData.empty(),
        isAnonymousUser: false,
        failureOption: none(),
        authStatus: AuthStatus.unauthenticated,
      );

  UserWatcherState copyWith({
    UserData? user,
    bool? isAnonymousUser,
    Option<AuthFailure>? failureOption,
    AuthStatus? authStatus,
  }) {
    return UserWatcherState(
      user: user ?? this.user,
      isAnonymousUser: isAnonymousUser ?? this.isAnonymousUser,
      failureOption: failureOption ?? this.failureOption,
      authStatus: authStatus ?? this.authStatus,
    );
  }

  @override
  List<Object> get props => [
        user,
        isAnonymousUser,
        failureOption,
        authStatus,
      ];
}
