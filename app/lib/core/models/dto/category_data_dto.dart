import 'package:json_annotation/json_annotation.dart';
import 'package:ordering_system_client_app/core/models/category_data.dart';

part 'category_data_dto.g.dart';

@JsonSerializable()
class CategoryDataDto {
  CategoryDataDto({
    required this.id,
    required this.title,
    required this.identifier,
  });

  final int id;
  final String title;
  final String identifier;

  factory CategoryDataDto.fromModel(CategoryData category) => CategoryDataDto(
        id: 0,
        title: category.title,
        identifier: category.identifier,
      );

  CategoryData toModel() => CategoryData(
        id: id,
        title: title,
        identifier: identifier,
      );

  factory CategoryDataDto.fromJson(Map<String, dynamic> json) =>
      _$CategoryDataDtoFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryDataDtoToJson(this);
}
