import 'package:json_annotation/json_annotation.dart';
import 'package:ordering_system_client_app/core/models/core/date_time_converter.dart';
import 'package:ordering_system_client_app/core/models/core/order_status_converter.dart';
import 'package:ordering_system_client_app/core/models/dto/order_ticket_item_data_dto.dart';
import 'package:ordering_system_client_app/core/models/order_ticket_data.dart';

part 'order_ticket_data_dto.g.dart';

@JsonSerializable()
class OrderTicketDataDto {
  const OrderTicketDataDto({
    this.id,
    this.seatId, // 如果Seat被Store刪掉的時候就不會有Seat了（為了斷開table ref）
    this.storeName,
    required this.userId,
    required this.totalPrice,
    required this.orderItems,
    this.createdAt,
    this.orderStatus,
  });

  final int? id;
  final String? storeName;
  final int? seatId;
  final String userId;
  final double totalPrice;
  final List<OrderTicketItemDataDto> orderItems;
  final String? createdAt;
  final String? orderStatus;

  factory OrderTicketDataDto.fromModel(OrderTicketData orderTicket) =>
      OrderTicketDataDto(
        id: orderTicket.id ?? 0,
        seatId: orderTicket.seatId,
        userId: orderTicket.userId,
        totalPrice: orderTicket.totalPrice ?? 0,
        orderItems: orderTicket.orderItems
            .map((item) => OrderTicketItemDataDto.fromModel(item))
            .toList(),
      );

  OrderTicketData toModel() => OrderTicketData(
        id: id,
        seatId: seatId ?? 0,
        storeName: storeName,
        userId: userId,
        orderItems: orderItems.map((dto) => dto.toModel()).toList(),
        totalPrice: totalPrice,
        createdAt: DateTimeConverter.fromString(createdAt!).toDateTime(),
        orderStatus: OrderStatusConverter.fromString(orderStatus!).toDomain(),
      );

  factory OrderTicketDataDto.fromJson(Map<String, dynamic> json) =>
      _$OrderTicketDataDtoFromJson(json);

  Map<String, dynamic> toJson() => _$OrderTicketDataDtoToJson(this);
}
