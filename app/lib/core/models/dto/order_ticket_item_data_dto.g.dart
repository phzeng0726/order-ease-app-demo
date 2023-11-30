// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_ticket_item_data_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderTicketItemDataDto _$OrderTicketItemDataDtoFromJson(
        Map<String, dynamic> json) =>
    OrderTicketItemDataDto(
      id: json['id'] as int?,
      productId: json['productId'] as int,
      productName: json['productName'] as String,
      productPrice: (json['productPrice'] as num).toDouble(),
      quantity: json['quantity'] as int,
    );

Map<String, dynamic> _$OrderTicketItemDataDtoToJson(
        OrderTicketItemDataDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'productId': instance.productId,
      'productName': instance.productName,
      'productPrice': instance.productPrice,
      'quantity': instance.quantity,
    };
