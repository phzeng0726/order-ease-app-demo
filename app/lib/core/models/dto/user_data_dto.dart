import 'package:json_annotation/json_annotation.dart';
import 'package:ordering_system_client_app/core/models/user_data.dart';

part 'user_data_dto.g.dart';

@JsonSerializable()
class UserDataDto {
  UserDataDto({
    this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.languageId,
  });

  final String? id;
  final String email;
  final String firstName;
  final String lastName;
  final int languageId;

  factory UserDataDto.fromModel(UserData user) => UserDataDto(
        email: user.email,
        firstName: user.firstName,
        lastName: user.lastName,
        languageId: user.languageId,
      );

  UserData toModel() => UserData(
        id: id ?? '',
        email: email,
        firstName: firstName,
        lastName: lastName,
        languageId: languageId,
      );

  factory UserDataDto.fromJson(Map<String, dynamic> json) =>
      _$UserDataDtoFromJson(json);

  Map<String, dynamic> toJson() => _$UserDataDtoToJson(this);
}
