import 'package:equatable/equatable.dart';

class OrderTicketItemData extends Equatable {
  const OrderTicketItemData({
    this.id,
    required this.productId,
    required this.productName,
    required this.productPrice,
    required this.quantity,
  });

  final int? id;
  final int productId;
  final String productName;
  final double productPrice;
  final int quantity;

  factory OrderTicketItemData.empty() => const OrderTicketItemData(
        id: 0,
        productId: 0,
        productName: '',
        productPrice: 0.0,
        quantity: 0,
      );

  OrderTicketItemData copyWith({
    int? id,
    int? productId,
    String? productName,
    double? productPrice,
    int? quantity,
  }) {
    return OrderTicketItemData(
      id: id ?? this.id,
      productId: productId ?? this.productId,
      productName: productName ?? this.productName,
      productPrice: productPrice ?? this.productPrice,
      quantity: quantity ?? this.quantity,
    );
  }

  @override
  List<Object?> get props => [
        id,
        productId,
        productName,
        productPrice,
        quantity,
      ];
}
