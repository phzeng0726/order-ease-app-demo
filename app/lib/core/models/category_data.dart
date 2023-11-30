import 'package:equatable/equatable.dart';

class CategoryData extends Equatable {
  const CategoryData({
    required this.id,
    required this.title,
    required this.identifier,
  });

  final int id;
  final String title;
  final String identifier;

  factory CategoryData.empty() => const CategoryData(
        id: -1,
        title: '',
        identifier: '',
      );

  factory CategoryData.all() => const CategoryData(
        id: -1,
        title: 'All',
        identifier: 'all icon',
      );

  CategoryData copyWith({
    int? id,
    String? title,
    String? identifier,
  }) {
    return CategoryData(
      id: id ?? this.id,
      title: title ?? this.title,
      identifier: identifier ?? this.identifier,
    );
  }

  @override
  List<Object?> get props => [id];
}
