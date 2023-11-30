import 'package:json_annotation/json_annotation.dart';
import 'package:ordering_system_client_app/core/models/store_data.dart';

part 'store_data_dto.g.dart';

@JsonSerializable()
class StoreDataDto {
  const StoreDataDto({
    required this.id,
    required this.userId,
    required this.name,
    required this.description,
    required this.phone,
    required this.address,
    required this.timezone,
    required this.isBreak,
  });

  final String id;
  final String userId;
  final String name;
  final String description;
  final String phone;
  final String address;
  final String timezone;
  final bool isBreak;

  factory StoreDataDto.fromModel(StoreData store) => StoreDataDto(
        id: store.id,
        userId: store.userId,
        name: store.name,
        description: store.description,
        phone: store.phone,
        address: store.address,
        timezone: store.timezone,
        isBreak: store.isBreak,
      );

  StoreData toModel() => StoreData(
        id: id,
        userId: userId,
        name: name,
        description: description,
        phone: phone,
        address: address,
        timezone: timezone,
        isBreak: isBreak,
      );

  factory StoreDataDto.fromJson(Map<String, dynamic> json) =>
      _$StoreDataDtoFromJson(json);

  Map<String, dynamic> toJson() => _$StoreDataDtoToJson(this);
}
