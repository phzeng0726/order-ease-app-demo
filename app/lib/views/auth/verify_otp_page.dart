import 'package:flutter/material.dart';
import 'package:ordering_system_client_app/views/auth/widgets/otp_verify_widget.dart';
import 'package:ordering_system_client_app/views/core/screen/auth_page_layout.dart';
import 'package:ordering_system_client_app/views/core/utils/app_localizations.dart';

class VerifyOTPPage extends StatelessWidget {
  const VerifyOTPPage({
    super.key,
    required this.email,
    required this.succeedRouteToName,
  });

  final String email;
  final String succeedRouteToName;

  @override
  Widget build(BuildContext context) {
    return AuthPageLayout(
      appBarTitle: AppLocalizations.of(context)!.appTitle,
      bodyForm: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          OTPVerifyWidget(
            email: email,
            succeedRouteToName: succeedRouteToName,
          ),
          const SizedBox(height: 20.0),
        ],
      ),
    );
  }
}
