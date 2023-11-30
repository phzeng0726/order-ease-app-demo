import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:ordering_system_client_app/core/models/core/auth_failure.dart';
import 'package:ordering_system_client_app/core/models/enums/load_status_enum.dart';
import 'package:ordering_system_client_app/core/repos/i_auth_repository.dart';

part 'forgot_password_event.dart';
part 'forgot_password_state.dart';

class ForgotPasswordBloc
    extends Bloc<ForgotPasswordEvent, ForgotPasswordState> {
  final IAuthRepository _authRepo;

  ForgotPasswordBloc(
    this._authRepo,
  ) : super(ForgotPasswordState.initial()) {
    on<ForgotPasswordEvent>(_onEvent);
  }

  FutureOr<void> _onEvent(
    ForgotPasswordEvent event,
    Emitter<ForgotPasswordState> emit,
  ) async {
    if (event is ChangeForgotPasswordFormEvent) {
      emit(
        state.copyWith(
          password: event.password ?? state.password,
          confirmPassword: event.confirmPassword ?? state.confirmPassword,
        ),
      );
    } else if (event is ChangePasswordVisibleEvent) {
      emit(
        state.copyWith(
          isPasswordVisible: !state.isPasswordVisible,
        ),
      );
    } else if (event is ChangeConfirmPasswordVisibleEvent) {
      emit(
        state.copyWith(
          isConfirmPasswordVisible: !state.isConfirmPasswordVisible,
        ),
      );
    } else if (event is ResetPasswordEvent) {
      emit(
        state.copyWith(
          failureOption: none(),
          status: LoadStatus.inProgress,
        ),
      );

      final failureOption = await _authRepo.resetPassword(
        userId: event.userId,
        password: state.password,
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
    }
  }
}
