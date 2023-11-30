// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_ticket_data_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderTicketDataDto _$OrderTicketDataDtoFromJson(Map<String, dynamic> json) =>
    OrderTicketDataDto(
      id: json['id'] as int?,
      seatId: json['seatId'] as int?,
      storeName: json['storeName'] as String?,
      userId: json['userId'] as String,
      totalPrice: (json['totalPrice'] as num).toDouble(),
      orderItems: (json['orderItems'] as List<dynamic>)
          .map(
              (e) => OrderTicketItemDataDto.fromJson(e as Map<String, dynamic>))
          .toList(),
      createdAt: json['createdAt'] as String?,
      orderStatus: json['orderStatus'] as String?,
    );

Map<String, dynamic> _$OrderTicketDataDtoToJson(OrderTicketDataDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'storeName': instance.storeName,
      'seatId': instance.seatId,
      'userId': instance.userId,
      'totalPrice': instance.totalPrice,
      'orderItems': instance.orderItems,
      'createdAt': instance.createdAt,
      'orderStatus': instance.orderStatus,
    };
