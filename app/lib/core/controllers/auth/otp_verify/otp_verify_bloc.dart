import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:ordering_system_client_app/core/models/core/auth_failure.dart';
import 'package:ordering_system_client_app/core/models/enums/load_status_enum.dart';
import 'package:ordering_system_client_app/core/repos/i_auth_repository.dart';
import 'package:uuid/uuid.dart';

part 'otp_verify_event.dart';
part 'otp_verify_state.dart';

class OTPVerifyBloc extends Bloc<OTPVerifyEvent, OTPVerifyState> {
  final IAuthRepository _authRepo;

  OTPVerifyBloc(
    this._authRepo,
  ) : super(OTPVerifyState.initial()) {
    on<OTPVerifyEvent>(_onEvent);
  }

  FutureOr<void> _onEvent(
    OTPVerifyEvent event,
    Emitter<OTPVerifyState> emit,
  ) async {
    if (event is SendOTPEvent) {
      final token = const Uuid().v4();

      emit(
        state.copyWith(
          verifyAttempts: 0,
          failureOption: none(),
        ),
      );

      final failureOption = await _authRepo.createOTP(
        email: event.email,
        token: token,
      );

      failureOption.fold(
        () => emit(
          state.copyWith(
            token: token,
          ),
        ),
        (f) => emit(
          state.copyWith(
            failureOption: some(f),
          ),
        ),
      );
    } else if (event is ChangeOTPEvent) {
      emit(
        state.copyWith(
          otpCode: event.otpCode,
        ),
      );
    } else if (event is VerifyOTPEvent) {
      emit(
        state.copyWith(
          failureOption: none(),
          status: LoadStatus.inProgress,
        ),
      );

      final failureOption = await _authRepo.verifyOTP(
        token: state.token,
        otpCode: state.otpCode,
      );

      failureOption.fold(
        () => emit(
          state.copyWith(
            status: LoadStatus.succeed,
          ),
        ),
        (f) => emit(
          state.copyWith(
            verifyAttempts: state.verifyAttempts += 1,
            failureOption: some(f),
            status: LoadStatus.failed,
          ),
        ),
      );
    }
  }
}
