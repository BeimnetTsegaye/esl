import 'package:esl/core/theme/app_theme.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';

class KTextField extends StatelessWidget {
  final TextEditingController controller;
  final TextInputType keyboardType;
  final String helperText;
  final String labelText;
  final bool obscureText;
  final int? maxLines;
  final int? maxLength;
  final VoidCallback? onSuffixIconPressed;
  final String? Function(String?)? validator;

  const KTextField({
    super.key,
    required this.controller,
    this.keyboardType = TextInputType.text,
    this.helperText = '',
    this.labelText = '',
    this.maxLines = 1,
    this.maxLength,
    this.obscureText = false,
    this.onSuffixIconPressed,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
      style: authGreyTextStyle,
      maxLines: maxLines,
      maxLength: maxLength,
      validator: validator,
      decoration: InputDecoration(
        helperText: helperText,
        labelText: labelText,
        suffixIcon: onSuffixIconPressed != null
            ? IconButton(
                icon: Icon(
                  obscureText
                      ? FluentIcons.eye_12_filled
                      : FluentIcons.eye_off_16_regular,
                ),
                onPressed: onSuffixIconPressed,
              )
            : null,
      ),
    );
  }
}
