import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:ordering_system_client_app/core/models/core/auth_failure.dart';
import 'package:ordering_system_client_app/core/models/core/cache_helper.dart';
import 'package:ordering_system_client_app/core/models/enums/load_status_enum.dart';
import 'package:ordering_system_client_app/core/repos/i_auth_repository.dart';
import 'package:ordering_system_client_app/core/repos/i_firebase_facade.dart';

part 'sign_in_event.dart';
part 'sign_in_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  final IAuthRepository _authRepo;
  final IFirebaseFacade _firebaseFacade;

  SignInBloc(
    this._authRepo,
    this._firebaseFacade,
  ) : super(SignInState.initial()) {
    on<SignInEvent>(_onEvent);
  }

  FutureOr<void> _onEvent(
    SignInEvent event,
    Emitter<SignInState> emit,
  ) async {
    if (event is InitialEvent) {
      emit(SignInState.initial());
    } else if (event is ChangeEmailEvent) {
      emit(
        state.copyWith(
          email: event.email,
        ),
      );
    } else if (event is CheckHasUserEvent) {
      emit(
        state.copyWith(
          failureOption: none(),
          isEmailNotFound: false,
          step: SignInStep.email,
          status: LoadStatus.inProgress,
        ),
      );

      final failureOrSuccess = await _authRepo.getUserIdByEmail(
        email: state.email,
      );

      failureOrSuccess.fold(
        (f) {
          if (f == AuthFailure.emailNotFoundInDatabase()) {
            // 找不到email，前往註冊頁面
            emit(
              state.copyWith(
                isEmailNotFound: true,
                status: LoadStatus.succeed,
              ),
            );
          } else {
            emit(
              state.copyWith(
                failureOption: some(f),
                status: LoadStatus.failed,
              ),
            );
          }
        },
        (userId) => emit(
          // 找的到userId，前往登入頁面
          state.copyWith(
            tempUserId: userId,
            status: LoadStatus.succeed,
          ),
        ),
      );
    } else if (event is ChangePasswordEvent) {
      emit(
        state.copyWith(
          password: event.password,
        ),
      );
    } else if (event is ChangePasswordVisibleEvent) {
      emit(
        state.copyWith(
          isPasswordVisible: !state.isPasswordVisible,
        ),
      );
    } else if (event is PressSignInWithEmailEvent) {
      emit(
        state.copyWith(
          failureOption: none(),
          step: SignInStep.password,
          isAnonymouslyUser: false,
          status: LoadStatus.inProgress,
        ),
      );

      final failureOrSuccess = await _firebaseFacade.signInWithEmailAndPassword(
        email: state.email,
        password: state.password,
      );

      failureOrSuccess.fold(
        (f) => emit(
          state.copyWith(
            failureOption: some(f),
            status: LoadStatus.failed,
          ),
        ),
        (firebaseUid) {
          // 存firebaseUid到cache，並在userWatcher以firebaseUid獲取userData
          CacheHelper.saveUserCode(firebaseUid);

          emit(
            state.copyWith(
              status: LoadStatus.succeed,
            ),
          );
        },
      );
    } else if (event is PressSignInAnonymouslyEvent) {
      emit(
        state.copyWith(
          failureOption: none(),
          isAnonymouslyUser: true,
          step: SignInStep.email,
          status: LoadStatus.inProgress,
        ),
      );

      final failureOrSuccess = await _firebaseFacade.signInAnonymously();

      failureOrSuccess.fold(
        (f) => emit(
          state.copyWith(
            failureOption: some(f),
            status: LoadStatus.failed,
          ),
        ),
        (firebaseUid) {
          // 存firebaseUid到cache，並在userWatcher以firebaseUid獲取userData
          CacheHelper.saveUserCode(firebaseUid);

          emit(
            state.copyWith(
              status: LoadStatus.succeed,
            ),
          );
        },
      );
    }
  }
}
