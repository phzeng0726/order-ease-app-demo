import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:ordering_system_client_app/core/models/dto/category_data_dto.dart';
import 'package:ordering_system_client_app/core/models/menu_item_data.dart';

part 'menu_item_data_dto.g.dart';

@JsonSerializable()
class MenuItemDataDto {
  MenuItemDataDto({
    required this.id,
    required this.title,
    required this.description,
    required this.quantity,
    required this.price,
    required this.category,
    this.imageBytes,
  });

  final int id;
  final String title;
  final String description;
  final int quantity;
  final int price;
  final CategoryDataDto category;
  final dynamic imageBytes;

  factory MenuItemDataDto.fromModel(MenuItemData menuItem) => MenuItemDataDto(
        id: 0,
        title: menuItem.title,
        description: menuItem.description,
        quantity: menuItem.quantity,
        price: menuItem.price,
        category: CategoryDataDto.fromModel(menuItem.category),
        imageBytes: menuItem.imageBytes,
      );

  MenuItemData toModel() => MenuItemData(
        id: id,
        title: title,
        description: description,
        quantity: quantity,
        price: price,
        category: category.toModel(),
        imageBytes: imageBytes == "" // 沒有圖片
            ? null
            : base64Decode(imageBytes), // 將base64轉換為Uint8List
      );

  factory MenuItemDataDto.fromJson(Map<String, dynamic> json) =>
      _$MenuItemDataDtoFromJson(json);

  Map<String, dynamic> toJson() => _$MenuItemDataDtoToJson(this);
}
