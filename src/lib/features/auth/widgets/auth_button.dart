import 'package:flutter/material.dart';
import 'package:my_app/ui/widgets/custom_button.dart';
import 'package:my_app/core/constants/colors.dart';

class AuthButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isLoading;
  final bool isOutlined;

  const AuthButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isLoading = false,
    this.isOutlined = false,
  });

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      text: text,
      onPressed: onPressed,
      isLoading: isLoading,
      isOutlined: isOutlined,
      width: double.infinity,
      height: 56,
      backgroundColor: isOutlined ? AppColors.white : AppColors.primary,
      textColor: isOutlined ? AppColors.primary : AppColors.white,
    );
  }
}
