import 'package:flutter/material.dart';

AppBar pageLayoutAppBar(
  BuildContext context, {
  required String appBarTitle,
  final Widget? leading,
  final List<Widget>? actions,
}) {
  return AppBar(
    leading: leading,
    actions: actions,
    title: Text(
      appBarTitle,
    ),
    backgroundColor: Theme.of(context).colorScheme.inversePrimary,
  );
}
