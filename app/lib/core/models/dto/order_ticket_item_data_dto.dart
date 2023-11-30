import 'package:json_annotation/json_annotation.dart';
import 'package:ordering_system_client_app/core/models/order_ticket_item_data.dart';

part 'order_ticket_item_data_dto.g.dart';

@JsonSerializable()
class OrderTicketItemDataDto {
  const OrderTicketItemDataDto({
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

  factory OrderTicketItemDataDto.fromModel(
    OrderTicketItemData orderTicketItem,
  ) =>
      OrderTicketItemDataDto(
        id: orderTicketItem.id,
        productId: orderTicketItem.productId,
        productName: orderTicketItem.productName,
        productPrice: orderTicketItem.productPrice,
        quantity: orderTicketItem.quantity,
      );

  OrderTicketItemData toModel() => OrderTicketItemData(
        id: id,
        productId: productId,
        productName: productName,
        productPrice: productPrice,
        quantity: quantity,
      );

  factory OrderTicketItemDataDto.fromJson(Map<String, dynamic> json) =>
      _$OrderTicketItemDataDtoFromJson(json);

  Map<String, dynamic> toJson() => _$OrderTicketItemDataDtoToJson(this);
}
