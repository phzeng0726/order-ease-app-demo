import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:ordering_system_client_app/core/models/core/auth_failure.dart';
import 'package:ordering_system_client_app/core/models/core/cache_helper.dart';
import 'package:ordering_system_client_app/core/models/enums/auth_status_enum.dart';
import 'package:ordering_system_client_app/core/models/user_data.dart';
import 'package:ordering_system_client_app/core/repos/i_auth_repository.dart';
import 'package:ordering_system_client_app/core/repos/i_firebase_facade.dart';

part 'user_watcher_event.dart';
part 'user_watcher_state.dart';

class UserWatcherBloc extends Bloc<UserWatcherEvent, UserWatcherState> {
  final IAuthRepository _authRepository;
  final IFirebaseFacade _firebaseFacade;

  UserWatcherBloc(
    this._authRepository,
    this._firebaseFacade,
  ) : super(UserWatcherState.initial()) {
    on<UserWatcherEvent>(_onEvent);
  }

  FutureOr<void> _onEvent(
    UserWatcherEvent event,
    Emitter<UserWatcherState> emit,
  ) async {
    if (event is CheckAuthEvent) {
      final String userCode = CacheHelper.getSignInUserCode(); // firebaseUid

      await Future.delayed(const Duration(seconds: 2)); // 讓Splash page至少出現2秒

      if (userCode == '') {
        emit(
          state.copyWith(
            isAnonymousUser: false,
            authStatus: AuthStatus.unauthenticated,
          ),
        );
      } else {
        add(const FetchUserDataEvent());
      }
    } else if (event is FetchUserDataEvent) {
      // firebaseUid -> userId -> userData
      final String userCode = CacheHelper.getSignInUserCode(); // firebaseUid

      // 為後端所創，非匿名用戶
      if (userCode.contains('-')) {
        final failureOrSuccess = await _authRepository.getUserFromDatabase(
          firebaseUid: userCode,
        );

        failureOrSuccess.fold(
          (f) => emit(
            state.copyWith(
              failureOption: some(f),
            ),
          ),
          (user) => emit(
            state.copyWith(
              failureOption: none(),
              user: user,
              authStatus: AuthStatus.authenticated,
            ),
          ),
        );
      } else {
        // 匿名用戶
        emit(
          state.copyWith(
            user: UserData.anonymous(userCode),
            isAnonymousUser: true,
            authStatus: AuthStatus.authenticated,
          ),
        );
      }

      print(state.user);
    } else if (event is LogoutEvent) {
      await _firebaseFacade.logOut();
      await CacheHelper.saveUserCode(''); // clean firebase uid
      emit(
        state.copyWith(
          isAnonymousUser: false,
          authStatus: AuthStatus.unauthenticated,
        ),
      );
    }
  }
}
