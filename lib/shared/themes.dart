import 'package:flutter/material.dart';
import 'package:ikinyarwanda/shared/colors.dart';

class ThemeConfig {
  static ThemeData lightTheme = ThemeData(
    primaryColor: AppColors.primaryLight,
    scaffoldBackgroundColor: AppColors.backgroundLight,
    backgroundColor: AppColors.backgroundLight,
    brightness: Brightness.light,
  );

  static ThemeData dartTheme = ThemeData();
}
