import 'package:flutter/material.dart';
import 'package:ordering_system_client_app/core/models/enums/order_status_enum.dart';
import 'package:ordering_system_client_app/views/core/utils/app_localizations.dart';

class OrderStatusConverter {
  const OrderStatusConverter(this.value);

  final OrderStatus value;

  String toText(BuildContext context) {
    switch (value) {
      case OrderStatus.open:
        return AppLocalizations.of(context)!.open;
      case OrderStatus.inProgress:
        return AppLocalizations.of(context)!.inProgress;
      case OrderStatus.done:
        return AppLocalizations.of(context)!.done;
      case OrderStatus.cancelled:
        return AppLocalizations.of(context)!.cancelled;

      default:
        return 'unknown';
    }
  }

  Color toColor() {
    switch (value) {
      case OrderStatus.open:
        return const Color.fromARGB(255, 255, 203, 48);
      case OrderStatus.inProgress:
        return const Color.fromARGB(255, 129, 236, 255);
      case OrderStatus.cancelled:
        return const Color.fromARGB(255, 255, 134, 125);
      case OrderStatus.done:
        return const Color.fromARGB(255, 158, 255, 120);
      default:
        return Colors.black;
    }
  }

  factory OrderStatusConverter.fromString(String statusString) {
    var _status = OrderStatus.open;

    switch (statusString) {
      case 'open':
        _status = OrderStatus.open;
      case 'inProgress':
        _status = OrderStatus.inProgress;
      case 'done':
        _status = OrderStatus.done;
      case 'cancelled':
        _status = OrderStatus.cancelled;
      default:
        _status = OrderStatus.open;
    }
    return OrderStatusConverter(_status);
  }

  OrderStatus toDomain() => value;
}
