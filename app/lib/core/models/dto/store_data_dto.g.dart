// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'store_data_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StoreDataDto _$StoreDataDtoFromJson(Map<String, dynamic> json) => StoreDataDto(
      id: json['id'] as String,
      userId: json['userId'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      phone: json['phone'] as String,
      address: json['address'] as String,
      timezone: json['timezone'] as String,
      isBreak: json['isBreak'] as bool,
    );

Map<String, dynamic> _$StoreDataDtoToJson(StoreDataDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'name': instance.name,
      'description': instance.description,
      'phone': instance.phone,
      'address': instance.address,
      'timezone': instance.timezone,
      'isBreak': instance.isBreak,
    };
