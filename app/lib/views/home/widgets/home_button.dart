import 'package:flutter/material.dart';

class HomeButton extends StatelessWidget {
  const HomeButton({
    super.key,
    required this.title,
    this.icon,
    required this.onPressed,
  });

  final String title;
  final IconData? icon;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        splashFactory: NoSplash.splashFactory,
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
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
          children: [
            if (icon != null) ...[
              Icon(icon),
            ],
            const SizedBox(width: 20.0),
            Text(
              title,
            ),
          ],
        ),
      ),
    );
  }
}
