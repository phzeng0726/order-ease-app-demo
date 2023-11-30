import 'package:equatable/equatable.dart';
import 'package:ordering_system_client_app/core/models/menu_item_data.dart';
import 'package:ordering_system_client_app/core/models/store_data.dart';

class MenuData extends Equatable {
  const MenuData({
    this.id,
    required this.storeId,
    required this.title,
    required this.description,
    required this.menuItems,
    required this.store,
  });

  final String? id;
  final String storeId;
  final String title;
  final String description;
  final List<MenuItemData> menuItems;
  final StoreData store;

  factory MenuData.empty() => MenuData(
        id: '',
        storeId: '',
        title: '',
        description: '',
        menuItems: const <MenuItemData>[],
        store: StoreData.empty(),
      );

  MenuData copyWith({
    String? id,
    String? storeId,
    String? title,
    String? description,
    List<MenuItemData>? menuItems,
    StoreData? store,
  }) {
    return MenuData(
      id: id ?? this.id,
      storeId: storeId ?? this.storeId,
      title: title ?? this.title,
      description: description ?? this.description,
      menuItems: menuItems ?? this.menuItems,
      store: store ?? this.store,
    );
  }

  @override
  List<Object?> get props => [
        id,
        storeId,
        title,
        description,
        menuItems,
        store,
      ];
}
