part of 'user_actor_bloc.dart';

class UserActorState extends Equatable {
  const UserActorState({
    required this.failureOption,
    required this.status,
  });

  final Option<AuthFailure> failureOption;
  final LoadStatus status;

  factory UserActorState.initial() => UserActorState(
        failureOption: none(),
        status: LoadStatus.initial,
      );

  UserActorState copyWith({
    Option<AuthFailure>? failureOption,
    LoadStatus? status,
  }) {
    return UserActorState(
      failureOption: failureOption ?? this.failureOption,
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props => [
        failureOption,
        status,
      ];
}
