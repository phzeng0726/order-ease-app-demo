part of 'order_form_bloc.dart';

@immutable
sealed class OrderFormEvent {
  const OrderFormEvent();
}

class InitialEvent extends OrderFormEvent {
  const InitialEvent({
    required this.seatId,
    required this.userId,
    required this.menu,
  });

  final int seatId;
  final String userId;
  final MenuData menu;
}

class ChangeWatchingCategoryEvent extends OrderFormEvent {
  const ChangeWatchingCategoryEvent({
    required this.index,
  });

  final int index;
}

class AddOrderItemEvent extends OrderFormEvent {
  const AddOrderItemEvent({
    required this.menuItem,
  });

  final MenuItemData menuItem;
}

class RemoveOrderItemEvent extends OrderFormEvent {
  const RemoveOrderItemEvent({
    required this.menuItem,
  });

  final MenuItemData menuItem;
}

class CreateOrderTicketEvent extends OrderFormEvent {
  const CreateOrderTicketEvent();
}

class CleanOrderFormEvent extends OrderFormEvent {
  const CleanOrderFormEvent();
}
