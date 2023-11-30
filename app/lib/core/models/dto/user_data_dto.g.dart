// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_data_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserDataDto _$UserDataDtoFromJson(Map<String, dynamic> json) => UserDataDto(
      id: json['id'] as String?,
      email: json['email'] as String,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      languageId: json['languageId'] as int,
    );

Map<String, dynamic> _$UserDataDtoToJson(UserDataDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'languageId': instance.languageId,
    };
