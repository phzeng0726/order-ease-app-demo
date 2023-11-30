part of 'order_form_bloc.dart';

class OrderFormState extends Equatable {
  const OrderFormState({
    required this.menu, // 從商店抓到的菜單
    required this.categoryList, // 篩選category，Map<MenuItemData, Quantity>
    required this.selectedCategoryIndex,
    required this.filteredMenuItemList,
    required this.orderItemMap, // 要訂購的數量，Map<MenuItemData, Quantity>
    required this.orderTicket, // 最終要送的訂單
    required this.totalPrice,
    required this.failureOption,
    required this.status,
  });

  final MenuData menu;
  final List<CategoryData> categoryList;
  final int selectedCategoryIndex;
  final List<MenuItemData> filteredMenuItemList;

  final Map<MenuItemData, int> orderItemMap;
  final OrderTicketData orderTicket;
  final double totalPrice;
  final Option<Failure> failureOption;
  final LoadStatus status;

  factory OrderFormState.initial() => OrderFormState(
        menu: MenuData.empty(),
        categoryList: const <CategoryData>[],
        selectedCategoryIndex: 0,
        filteredMenuItemList: const <MenuItemData>[],
        orderItemMap: const <MenuItemData, int>{},
        orderTicket: OrderTicketData.empty(),
        totalPrice: 0.0,
        failureOption: none(),
        status: LoadStatus.initial,
      );

  OrderFormState copyWith({
    MenuData? menu,
    List<CategoryData>? categoryList,
    int? selectedCategoryIndex,
    List<MenuItemData>? filteredMenuItemList,
    Map<MenuItemData, int>? orderItemMap,
    OrderTicketData? orderTicket,
    double? totalPrice,
    Option<Failure>? failureOption,
    LoadStatus? status,
  }) {
    return OrderFormState(
      menu: menu ?? this.menu,
      categoryList: categoryList ?? this.categoryList,
      selectedCategoryIndex:
          selectedCategoryIndex ?? this.selectedCategoryIndex,
      filteredMenuItemList: filteredMenuItemList ?? this.filteredMenuItemList,
      orderItemMap: orderItemMap ?? this.orderItemMap,
      orderTicket: orderTicket ?? this.orderTicket,
      totalPrice: totalPrice ?? this.totalPrice,
      failureOption: failureOption ?? this.failureOption,
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props => [
        menu,
        categoryList,
        selectedCategoryIndex,
        filteredMenuItemList,
        orderItemMap,
        orderTicket,
        totalPrice,
        failureOption,
        status,
      ];
}
