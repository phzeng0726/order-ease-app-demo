import 'package:json_annotation/json_annotation.dart';
import 'package:ordering_system_client_app/core/models/dto/menu_item_data_dto.dart';
import 'package:ordering_system_client_app/core/models/dto/store_data_dto.dart';
import 'package:ordering_system_client_app/core/models/menu_data.dart';
import 'package:ordering_system_client_app/core/models/store_data.dart';

part 'menu_data_dto.g.dart';

@JsonSerializable()
class MenuDataDto {
  const MenuDataDto({
    required this.id,
    required this.userId,
    required this.title,
    required this.description,
    required this.menuItems,
    this.store,
  });

  final String id;
  final String userId;
  final String title;
  final String description;
  final List<MenuItemDataDto> menuItems;
  final StoreDataDto? store;

  factory MenuDataDto.fromModel(MenuData menu) => MenuDataDto(
        id: menu.id ?? '',
        userId: menu.storeId,
        title: menu.title,
        description: menu.description,
        menuItems: menu.menuItems
            .map((menuItem) => MenuItemDataDto.fromModel(menuItem))
            .toList(),
        store: StoreDataDto.fromModel(menu.store),
      );

  MenuData toModel() => MenuData(
        id: id,
        storeId: userId,
        title: title,
        description: description,
        menuItems: menuItems.map((dto) => dto.toModel()).toList(),
        store: store?.toModel() ?? StoreData.empty(),
      );

  factory MenuDataDto.fromJson(Map<String, dynamic> json) =>
      _$MenuDataDtoFromJson(json);

  Map<String, dynamic> toJson() => _$MenuDataDtoToJson(this);
}
