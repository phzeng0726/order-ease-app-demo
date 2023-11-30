import 'package:flutter/material.dart';
import 'package:ordering_system_client_app/views/core/style/main.dart';

class AuthInputBox extends StatelessWidget {
  const AuthInputBox({
    super.key,
    required this.controller,
    required this.labelText,
    this.suffixIcon,
    this.keyboardType,
    this.obscureText = false,
    this.validator,
  });

  final TextEditingController? controller;
  final String labelText;
  final Widget? suffixIcon;
  final TextInputType? keyboardType;
  final bool obscureText;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
      maxLines: 1,
      validator: validator,
      decoration: InputDecoration(
        suffixIcon: suffixIcon,
        helperText: '', // 固定TextFormField高度，避免errorText改變高度
        labelText: labelText,
        labelStyle: AppTextStyle.text(
          color: ColorStyle.lightGrey,
        ),
        isDense: true,
        contentPadding: const EdgeInsets.all(4.0),
      ),
    );
  }
}
