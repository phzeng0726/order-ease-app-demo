import 'package:flutter/material.dart';
import 'package:ordering_system_client_app/views/core/style/main.dart';
import 'package:ordering_system_client_app/views/core/widgets/custom_app_bar_widget.dart';
import 'package:ordering_system_client_app/views/core/widgets/tap_out_dismiss_keyboard.dart';

class AuthPageLayout extends StatelessWidget {
  const AuthPageLayout({
    super.key,
    required this.appBarTitle,
    this.actions,
    this.leading,
    required this.bodyForm,
  });

  final String appBarTitle;
  final List<Widget>? actions;
  final Widget? leading;
  final Widget bodyForm;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: pageLayoutAppBar(
        context,
        appBarTitle: appBarTitle,
        leading: leading,
        actions: actions,
      ),
      body: SingleChildScrollView(
        child: TapOutDismissKeyboard(
          child: Padding(
            padding: kPagePadding,
            child: Center(
              child: bodyForm,
            ),
          ),
        ),
      ),
    );
  }
}
