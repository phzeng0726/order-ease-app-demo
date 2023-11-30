import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:ordering_system_client_app/core/models/core/auth_failure.dart';
import 'package:ordering_system_client_app/core/models/core/cache_helper.dart';
import 'package:ordering_system_client_app/core/models/enums/load_status_enum.dart';
import 'package:ordering_system_client_app/core/models/user_data.dart';
import 'package:ordering_system_client_app/core/repos/i_auth_repository.dart';
import 'package:ordering_system_client_app/core/repos/i_firebase_facade.dart';

part 'sign_up_event.dart';
part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final IAuthRepository _authRepo;
  final IFirebaseFacade _firebaseFacade;

  SignUpBloc(
    this._authRepo,
    this._firebaseFacade,
  ) : super(SignUpState.initial()) {
    on<SignUpEvent>(_onEvent);
  }

  FutureOr<void> _onEvent(
    SignUpEvent event,
    Emitter<SignUpState> emit,
  ) async {
    if (event is ChangeSignUpFormEvent) {
      emit(
        state.copyWith(
          password: event.password ?? state.password,
          confirmPassword: event.confirmPassword ?? state.confirmPassword,
          firstName: event.firstName ?? state.firstName,
          lastName: event.lastName ?? state.lastName,
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
    } else if (event is CreateUserEvent) {
      emit(
        state.copyWith(
          failureOption: none(),
          status: LoadStatus.inProgress,
        ),
      );

      final failureOption = await _authRepo.createUser(
        user: UserData(
          email: event.email,
          firstName: state.firstName,
          lastName: state.lastName,
          languageId: event.languageId,
        ),
        password: state.password,
      );

      failureOption.fold(
        () => add(
          SignInFirebaseAfterCreatedEvent(
            email: event.email,
            password: state.password,
          ),
        ),
        (f) => emit(
          state.copyWith(
            failureOption: some(f),
            status: LoadStatus.failed,
          ),
        ),
      );
    } else if (event is SignInFirebaseAfterCreatedEvent) {
      emit(
        state.copyWith(
          failureOption: none(),
          status: LoadStatus.inProgress,
        ),
      );

      final failureOrSuccess = await _firebaseFacade.signInWithEmailAndPassword(
        email: event.email,
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
          print('firebaseUid: $firebaseUid');

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
