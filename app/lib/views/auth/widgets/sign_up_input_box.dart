import 'package:flutter/material.dart';
import 'package:ordering_system_client_app/views/core/style/main.dart';

class SignUpInputBox extends StatelessWidget {
  const SignUpInputBox({
    super.key,
    required this.controller,
    required this.title,
    required this.hintText,
    this.validator,
    this.keyboardType,
    this.maxLength,
    this.obscureText = false,
    this.suffixIcon,
    this.textCapitalization,
  });

  final TextEditingController? controller;
  final String title;
  final String hintText;

  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final int? maxLength;
  final bool obscureText;
  final Widget? suffixIcon;
  final TextCapitalization? textCapitalization;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          title,
          style: AppTextStyle.text(
            color: Colors.grey,
          ),
        ),
        TextFormField(
          controller: controller,
          validator: validator,
          maxLines: 1,
          maxLength: maxLength,
          obscureText: obscureText,
          keyboardType: keyboardType,
          textCapitalization: textCapitalization ?? TextCapitalization.none,
          style: AppTextStyle.heading3(),
          decoration: InputDecoration(
            isDense: true,
            contentPadding: const EdgeInsets.symmetric(
              vertical: AppPaddingSize.smallVertical,
            ),
            helperText: '',
            hintText: hintText,
            hintStyle: AppTextStyle.hintText(),
            enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(
                color: Colors.grey,
              ),
            ),
            suffixIcon: maxLength == null ? null : suffixIcon,
          ),
        ),
      ],
    );
  }
}
