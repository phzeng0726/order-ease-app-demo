import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:ordering_system_client_app/views/core/utils/app_localizations.dart';

SnackBar MessageSnackBar(
  BuildContext context, {
  RemoteMessage? message,
  void Function()? onTap,
}) {
  late String content;
  final String title = message?.notification?.title ?? '';
  final String body = message?.notification?.body ?? '';
  print(title);
  if (title == 'UPDATE_ORDER_TICKET') {
    content = AppLocalizations.of(context)!.orderUpdatedMessage(body);
  } else if (title == 'DELETE_ORDER_TICKET') {
    content = AppLocalizations.of(context)!.orderDeletedMessage(body);
  } else {
    content = '';
  }

  return SnackBar(
    content: GestureDetector(
      onTap: onTap,
      child: Text(content),
    ),
    behavior: SnackBarBehavior.floating,
  );
}
