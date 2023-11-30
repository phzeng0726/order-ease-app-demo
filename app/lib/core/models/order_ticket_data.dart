import 'package:equatable/equatable.dart';
import 'package:ordering_system_client_app/core/models/enums/order_status_enum.dart';
import 'package:ordering_system_client_app/core/models/order_ticket_item_data.dart';

class OrderTicketData extends Equatable {
  const OrderTicketData({
    this.id,
    this.seatId,
    this.storeName,
    required this.userId,
    this.totalPrice,
    required this.orderItems,
    this.createdAt,
    this.orderStatus,
  });

  final int? id;
  final int? seatId;
  final String? storeName;
  final String userId;
  final double? totalPrice;
  final List<OrderTicketItemData> orderItems;
  final DateTime? createdAt;
  final OrderStatus? orderStatus;

  factory OrderTicketData.empty() => OrderTicketData(
        id: 0,
        seatId: 0,
        storeName: '',
        userId: '',
        totalPrice: 0.0,
        orderItems: const <OrderTicketItemData>[],
        createdAt: DateTime.now(),
        orderStatus: OrderStatus.open,
      );

  OrderTicketData copyWith({
    int? id,
    int? seatId,
    String? storeName,
    String? userId,
    double? totalPrice,
    List<OrderTicketItemData>? orderItems,
    DateTime? createdAt,
    OrderStatus? orderStatus,
  }) {
    return OrderTicketData(
      id: id ?? this.id,
      seatId: seatId ?? this.seatId,
      storeName: storeName ?? this.storeName,
      userId: userId ?? this.userId,
      totalPrice: totalPrice ?? this.totalPrice,
      orderItems: orderItems ?? this.orderItems,
      createdAt: createdAt ?? this.createdAt,
      orderStatus: orderStatus ?? this.orderStatus,
    );
  }

  @override
  List<Object?> get props => [
        id,
        seatId,
        storeName,
        userId,
        totalPrice,
        orderItems,
        createdAt,
        orderStatus,
      ];
}
