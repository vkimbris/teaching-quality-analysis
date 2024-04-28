import 'package:flutter/material.dart';
import 'package:xakaton/assets/colors/app_colors.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static ThemeData get theme => ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        primaryColor: AppColors.accent,
        primaryColorDark: AppColors.white,
        primaryColorLight: AppColors.grey,
        scaffoldBackgroundColor: AppColors.lightGrey,
        textTheme: GoogleFonts.ubuntuMonoTextTheme(),
        splashColor: AppColors.lightGrey,
      );

  static TextStyle get textStyle => GoogleFonts.ubuntuMono(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: AppColors.dark,
        height: 1.2,
      );
  static TextStyle get hintStyle => GoogleFonts.ubuntuMono(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: AppColors.hint,
        height: 1.2,
      );
  static TextStyle get headerStyle => GoogleFonts.ubuntuMono(
        fontSize: 36,
        fontWeight: FontWeight.w600,
        color: AppColors.black,
        height: 1.2,
      );
  static TextStyle get subheaderStyle => GoogleFonts.ubuntuMono(
        fontSize: 24,
        fontWeight: FontWeight.w500,
        color: AppColors.dark,
        height: 1.2,
      );

  static BoxDecoration get shadowBoxDecoration => BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: AppColors.white,
        boxShadow: const [
          BoxShadow(
            color: AppColors.liner,
            blurRadius: 4,
            offset: Offset(0, 2), // Shadow position
          ),
        ],
      );
  AppTheme._();
}
