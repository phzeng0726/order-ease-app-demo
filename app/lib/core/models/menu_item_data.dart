import 'dart:typed_data';

import 'package:equatable/equatable.dart';
import 'package:ordering_system_client_app/core/models/category_data.dart';

class MenuItemData extends Equatable {
  const MenuItemData({
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
  final CategoryData category;
  final Uint8List? imageBytes;

  factory MenuItemData.empty() => MenuItemData(
        id: -1,
        title: '',
        description: '',
        quantity: 0,
        price: 0,
        category: CategoryData.empty(),
        imageBytes: Uint8List(0),
      );

  MenuItemData copyWith({
    int? id,
    String? title,
    String? description,
    int? quantity,
    int? price,
    CategoryData? category,
    Uint8List? imageBytes,
  }) {
    return MenuItemData(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      quantity: quantity ?? this.quantity,
      price: price ?? this.price,
      category: category ?? this.category,
      imageBytes: imageBytes ?? this.imageBytes,
    );
  }

  @override
  List<Object?> get props => [
        id,
        title,
        description,
        quantity,
        price,
        category,
        imageBytes,
      ];
}
