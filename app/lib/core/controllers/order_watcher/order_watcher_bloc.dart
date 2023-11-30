import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:ordering_system_client_app/core/models/core/failure.dart';
import 'package:ordering_system_client_app/core/models/enums/load_status_enum.dart';
import 'package:ordering_system_client_app/core/models/order_ticket_data.dart';
import 'package:ordering_system_client_app/core/repos/order_repository.dart';

part 'order_watcher_event.dart';
part 'order_watcher_state.dart';

class OrderWatcherBloc extends Bloc<OrderWatcherEvent, OrderWatcherState> {
  final OrderRepository _orderRepo;

  OrderWatcherBloc(
    this._orderRepo,
  ) : super(OrderWatcherState.initial()) {
    on<OrderWatcherEvent>(_onEvent);
  }

  FutureOr<void> _onEvent(
    OrderWatcherEvent event,
    Emitter<OrderWatcherState> emit,
  ) async {
    if (event is FetchOrderHistoryEvent) {
      emit(
        state.copyWith(
          failureOption: none(),
          status: LoadStatus.inProgress,
        ),
      );

      final failureOrSuccess = await _orderRepo.getOrderTickets(
        userId: event.userId,
      );

      failureOrSuccess.fold(
        (f) => emit(
          state.copyWith(
            failureOption: some(f),
            status: LoadStatus.failed,
          ),
        ),
        (orderTicketList) => emit(
          state.copyWith(
            orderTicketList: orderTicketList,
            failureOption: none(),
            status: LoadStatus.succeed,
          ),
        ),
      );
    }
  }
}
