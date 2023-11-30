import 'package:flutter/material.dart';
import 'package:ordering_system_client_app/views/core/style/main.dart';

class AuthButton extends StatelessWidget {
  const AuthButton({
    super.key,
    required this.title,
    required this.onPressed,
    this.backgroundColor,
    this.leadingIcon,
  });

  final String title;
  final void Function()? onPressed;
  final Color? backgroundColor;
  final Icon? leadingIcon;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        splashFactory: NoSplash.splashFactory,
        backgroundColor:
            backgroundColor ?? Theme.of(context).colorScheme.primaryContainer,
        elevation: 0.0,
        shadowColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            12.0,
          ),
        ),
      ),
      onPressed: onPressed,
      child: Container(
        alignment: Alignment.center,
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (leadingIcon != null) ...[
              leadingIcon!,
              const SizedBox(
                width: 10.0,
              )
            ],
            Text(
              title,
              style: AppTextStyle.heading4(),
            ),
          ],
        ),
      ),
    );
  }
}
