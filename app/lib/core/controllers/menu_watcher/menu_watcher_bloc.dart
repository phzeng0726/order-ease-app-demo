import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:ordering_system_client_app/configurations.dart';
import 'package:ordering_system_client_app/core/models/core/failure.dart';
import 'package:ordering_system_client_app/core/models/enums/load_status_enum.dart';
import 'package:ordering_system_client_app/core/models/menu_data.dart';
import 'package:ordering_system_client_app/core/repos/order_repository.dart';

part 'menu_watcher_event.dart';
part 'menu_watcher_state.dart';

class MenuWatcherBloc extends Bloc<MenuWatcherEvent, MenuWatcherState> {
  final OrderRepository _orderRepo;

  MenuWatcherBloc(
    this._orderRepo,
  ) : super(MenuWatcherState.initial()) {
    on<MenuWatcherEvent>(_onEvent);
  }

  FutureOr<void> _onEvent(
    MenuWatcherEvent event,
    Emitter<MenuWatcherState> emit,
  ) async {
    if (event is ScanQRCodeEvent) {
      emit(MenuWatcherState.initial());

      emit(
        state.copyWith(
          storeSeatId: event.storeSeatId,
        ),
      );
    } else if (event is FetchMenuEvent) {
      final String storeId = state.storeSeatId.split('_')[0];

      emit(
        state.copyWith(
          failureOption: none(),
          status: LoadStatus.inProgress,
        ),
      );

      final failureOrSuccess = await _orderRepo.getStoreMenu(
        storeId: storeId,
        languageId: languageId,
      );

      failureOrSuccess.fold(
        (f) => emit(
          state.copyWith(
            failureOption: some(f),
            status: LoadStatus.failed,
          ),
        ),
        (menu) => emit(
          state.copyWith(
            menu: menu,
            failureOption: none(),
            status: LoadStatus.succeed,
          ),
        ),
      );
    }
  }
}
