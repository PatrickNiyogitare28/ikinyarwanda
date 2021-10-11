import 'package:flutter/material.dart';
import 'package:ikinyarwanda/shared/colors.dart';

class ThemeConfig {
  static ThemeData lightTheme = ThemeData(
    primaryColor: AppColors.primaryLight,
    scaffoldBackgroundColor: AppColors.backgroundLight,
    backgroundColor: AppColors.backgroundLight,
    colorScheme: ColorScheme.fromSwatch().copyWith(
      secondary: AppColors.primaryLight,
    ),
    cardColor: Colors.white,
    brightness: Brightness.light,
  );
  static ThemeData darkTheme = ThemeData(
    primaryColor: AppColors.primaryDark,
    scaffoldBackgroundColor: AppColors.backgroundDark,
    backgroundColor: AppColors.backgroundDark,
    colorScheme: ColorScheme.fromSwatch().copyWith(
      secondary: AppColors.primaryDark,
    ),
    cardColor: Colors.black,
    brightness: Brightness.dark,
  );
}
