// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_data_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CategoryDataDto _$CategoryDataDtoFromJson(Map<String, dynamic> json) =>
    CategoryDataDto(
      id: json['id'] as int,
      title: json['title'] as String,
      identifier: json['identifier'] as String,
    );

Map<String, dynamic> _$CategoryDataDtoToJson(CategoryDataDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'identifier': instance.identifier,
    };
