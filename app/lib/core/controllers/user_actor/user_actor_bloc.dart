import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:ordering_system_client_app/core/models/core/auth_failure.dart';
import 'package:ordering_system_client_app/core/models/enums/load_status_enum.dart';
import 'package:ordering_system_client_app/core/repos/i_auth_repository.dart';
import 'package:ordering_system_client_app/core/repos/i_firebase_facade.dart';

part 'user_actor_event.dart';
part 'user_actor_state.dart';

class UserActorBloc extends Bloc<UserActorEvent, UserActorState> {
  final IAuthRepository _authRepository;
  final IFirebaseFacade _firebaseFacade;

  UserActorBloc(
    this._authRepository,
    this._firebaseFacade,
  ) : super(UserActorState.initial()) {
    on<UserActorEvent>(_onEvent);
  }

  FutureOr<void> _onEvent(
    UserActorEvent event,
    Emitter<UserActorState> emit,
  ) async {
    if (event is DeleteUserEvent) {
      emit(
        state.copyWith(
          failureOption: none(),
          status: LoadStatus.inProgress,
        ),
      );

      final failureOption = await _authRepository.deleteUser(
        userId: event.userId,
      );

      failureOption.fold(
        () => emit(
          state.copyWith(
            failureOption: none(),
            status: LoadStatus.succeed,
          ),
        ),
        (f) => emit(
          state.copyWith(
            failureOption: some(f),
            status: LoadStatus.failed,
          ),
        ),
      );
    } else if (event is DeleteAnonymousUserEvent) {
      emit(
        state.copyWith(
          failureOption: none(),
          status: LoadStatus.inProgress,
        ),
      );

      final failureOption = await _firebaseFacade.deleteAnonymousUser();

      failureOption.fold(
        () => emit(
          state.copyWith(
            failureOption: none(),
            status: LoadStatus.succeed,
          ),
        ),
        (f) => emit(
          state.copyWith(
            failureOption: some(f),
            status: LoadStatus.failed,
          ),
        ),
      );
    }
  }
}
