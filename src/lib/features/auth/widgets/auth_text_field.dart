import 'package:flutter/material.dart';
import 'package:my_app/ui/widgets/custom_text_field.dart';

class AuthTextField extends StatelessWidget {
  final String label;
  final String hint;
  final bool isPassword;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final String? errorText;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;

  const AuthTextField({
    super.key,
    required this.label,
    required this.hint,
    this.isPassword = false,
    this.controller,
    this.onChanged,
    this.errorText,
    this.keyboardType = TextInputType.text,
    this.textInputAction = TextInputAction.next,
  });

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      label: label,
      hint: hint,
      obscureText: isPassword,
      controller: controller,
      onChanged: onChanged,
      errorText: errorText,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
    );
  }
}
