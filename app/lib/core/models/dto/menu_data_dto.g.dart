// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'menu_data_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MenuDataDto _$MenuDataDtoFromJson(Map<String, dynamic> json) => MenuDataDto(
      id: json['id'] as String,
      userId: json['userId'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      menuItems: (json['menuItems'] as List<dynamic>)
          .map((e) => MenuItemDataDto.fromJson(e as Map<String, dynamic>))
          .toList(),
      store: json['store'] == null
          ? null
          : StoreDataDto.fromJson(json['store'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MenuDataDtoToJson(MenuDataDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'title': instance.title,
      'description': instance.description,
      'menuItems': instance.menuItems,
      'store': instance.store,
    };
