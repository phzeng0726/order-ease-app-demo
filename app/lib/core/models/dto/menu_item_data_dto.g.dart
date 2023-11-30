// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'menu_item_data_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MenuItemDataDto _$MenuItemDataDtoFromJson(Map<String, dynamic> json) =>
    MenuItemDataDto(
      id: json['id'] as int,
      title: json['title'] as String,
      description: json['description'] as String,
      quantity: json['quantity'] as int,
      price: json['price'] as int,
      category:
          CategoryDataDto.fromJson(json['category'] as Map<String, dynamic>),
      imageBytes: json['imageBytes'],
    );

Map<String, dynamic> _$MenuItemDataDtoToJson(MenuItemDataDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'quantity': instance.quantity,
      'price': instance.price,
      'category': instance.category,
      'imageBytes': instance.imageBytes,
    };
