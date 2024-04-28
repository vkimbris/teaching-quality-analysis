import 'package:flutter/material.dart';
import 'package:xakaton/assets/colors/app_colors.dart';
import 'package:xakaton/assets/theme/app_theme.dart';

class CustomCircularProgressIndicator extends StatelessWidget {
  final String text;

  const CustomCircularProgressIndicator(
      {super.key, this.text = 'Данные загружаются'});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: 300,
      decoration: AppTheme.shadowBoxDecoration,
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 10),
          const SizedBox.square(
            dimension: 40,
            child: CircularProgressIndicator(
              strokeWidth: 4,
              valueColor: AlwaysStoppedAnimation<Color>(AppColors.accent),
            ),
          ),
          const SizedBox(height: 24),
          Text(
            text,
            style: AppTheme.textStyle.copyWith(
              color: AppColors.accent,
              fontSize: 18,
            ),
          )
        ],
      ),
    );
  }
}
