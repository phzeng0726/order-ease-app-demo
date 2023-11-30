import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:ordering_system_client_app/core/models/category_data.dart';
import 'package:ordering_system_client_app/core/models/core/failure.dart';
import 'package:ordering_system_client_app/core/models/enums/load_status_enum.dart';
import 'package:ordering_system_client_app/core/models/menu_data.dart';
import 'package:ordering_system_client_app/core/models/menu_item_data.dart';
import 'package:ordering_system_client_app/core/models/order_ticket_data.dart';
import 'package:ordering_system_client_app/core/models/order_ticket_item_data.dart';
import 'package:ordering_system_client_app/core/repos/order_repository.dart';

part 'order_form_event.dart';
part 'order_form_state.dart';

class OrderFormBloc extends Bloc<OrderFormEvent, OrderFormState> {
  final OrderRepository _orderRepo;

  OrderFormBloc(
    this._orderRepo,
  ) : super(OrderFormState.initial()) {
    on<OrderFormEvent>(_onEvent);
  }

  FutureOr<void> _onEvent(
    OrderFormEvent event,
    Emitter<OrderFormState> emit,
  ) async {
    if (event is InitialEvent) {
      emit(OrderFormState.initial());

      late Map<MenuItemData, int> orderItemMap = {};
      late List<CategoryData> categoryList = [
        CategoryData.all(),
      ];

      for (MenuItemData menuItem in event.menu.menuItems) {
        orderItemMap[menuItem] = 0;
        if (!categoryList.contains(menuItem.category)) {
          categoryList.add(menuItem.category);
        }
      }

      emit(
        state.copyWith(
          menu: event.menu,
          orderTicket: state.orderTicket.copyWith(
            userId: event.userId,
            seatId: event.seatId,
          ),
          filteredMenuItemList: event.menu.menuItems,
          orderItemMap: orderItemMap,
          categoryList: categoryList,
        ),
      );
    } else if (event is ChangeWatchingCategoryEvent) {
      emit(
        state.copyWith(
          selectedCategoryIndex: event.index,
          filteredMenuItemList: filterMenuItemsByCategoryIndex(event.index),
        ),
      );
    } else if (event is AddOrderItemEvent) {
      Map<MenuItemData, int> newMap = {...state.orderItemMap};
      newMap[event.menuItem] = newMap[event.menuItem]! + 1;
      final itemAndTotalPriceTuple = filterOrderTicketItems(newMap);

      emit(
        state.copyWith(
          orderItemMap: newMap,
          orderTicket: state.orderTicket.copyWith(
            orderItems: itemAndTotalPriceTuple.value1,
          ),
          totalPrice: itemAndTotalPriceTuple.value2,
        ),
      );
    } else if (event is RemoveOrderItemEvent) {
      Map<MenuItemData, int> newMap = {...state.orderItemMap};
      // 數量不可為負數
      if (newMap[event.menuItem]! > 0) {
        newMap[event.menuItem] = newMap[event.menuItem]! - 1;
        final itemAndTotalPriceTuple = filterOrderTicketItems(newMap);

        emit(
          state.copyWith(
            orderItemMap: newMap,
            orderTicket: state.orderTicket.copyWith(
              orderItems: itemAndTotalPriceTuple.value1,
            ),
            totalPrice: itemAndTotalPriceTuple.value2,
          ),
        );
      }
    } else if (event is CreateOrderTicketEvent) {
      emit(
        state.copyWith(
          failureOption: none(),
          status: LoadStatus.inProgress,
        ),
      );

      final failureOption = await _orderRepo.createOrderTicket(
        orderTicket: state.orderTicket,
      );

      failureOption.fold(
        () {
          add(const CleanOrderFormEvent());

          emit(
            state.copyWith(
              failureOption: none(),
              status: LoadStatus.succeed,
            ),
          );
        },
        (f) => emit(
          state.copyWith(
            failureOption: some(f),
            status: LoadStatus.failed,
          ),
        ),
      );
    } else if (event is CleanOrderFormEvent) {
      final String userId = state.orderTicket.userId;
      final int seatId = state.orderTicket.seatId!;
      final MenuData menu = state.menu;

      add(
        InitialEvent(
          seatId: seatId,
          userId: userId,
          menu: menu,
        ),
      );
    }
  }

  List<MenuItemData> filterMenuItemsByCategoryIndex(
    int index,
  ) {
    return index == 0
        ? state.menu.menuItems
        : state.menu.menuItems
            .where((menuItem) => menuItem.category == state.categoryList[index])
            .toList();
  }

  Tuple2<List<OrderTicketItemData>, double> filterOrderTicketItems(
    Map<MenuItemData, int> orderItemMap,
  ) {
    late List<OrderTicketItemData> newOrderTicketItemList = [];
    late double totalPrice = 0;

    orderItemMap.forEach((menuItem, quantity) {
      if (quantity != 0) {
        newOrderTicketItemList.add(
          OrderTicketItemData(
            productId: menuItem.id,
            productName: menuItem.title,
            productPrice: menuItem.price.toDouble(),
            quantity: quantity,
          ),
        );
        totalPrice += menuItem.price.toDouble() * quantity;
      }
    });

    return Tuple2(newOrderTicketItemList, totalPrice);
  }
}
