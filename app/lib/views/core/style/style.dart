part of 'main.dart';

final ButtonStyle kButtonStyle = ElevatedButton.styleFrom(
  splashFactory: NoSplash.splashFactory,
  backgroundColor: ColorStyle.orange,
  elevation: 0.0,
  shadowColor: Colors.transparent,
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(
      12.0,
    ),
  ),
);
