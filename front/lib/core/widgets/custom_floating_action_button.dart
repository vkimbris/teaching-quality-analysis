import 'package:flutter/material.dart';
import 'package:xakaton/assets/colors/app_colors.dart';

class CustomFloatingActionButton extends StatelessWidget {
  final void Function()? onPressed;

  const CustomFloatingActionButton({super.key, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: onPressed,
      backgroundColor: AppColors.white,
    );
  }
}
