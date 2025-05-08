import 'package:flutter/material.dart';
import 'package:winto/core/functions/lang_f.dart';

import '../constants/color.dart';
import 'appbar_theme.dart';
import 'bottom_sheet_theme.dart';
import 'elevated_button.theme.dart';
import 'text_field_theme.dart';
import 'text_theme.dart';

class TAppTheme {
  TAppTheme._();
  static ThemeData lightTheme = ThemeData(
      useMaterial3: true,
      fontFamily: isArabicLocale() ? 'Tajawal-Medium' : 'Nunito Sans',
      brightness: Brightness.light,
      primaryColor: const Color(0xFF0099ff),
      primaryColorLight: const Color(0xFF0099ff),
      primaryColorDark: const Color(0xFF0099ff),

      // accentColor:Color.yellow,

      // primaryColor: TColors.primary,
      scaffoldBackgroundColor: Colors.white,
      textTheme: TTextTheme.lightTextTheme,
      appBarTheme: TAppBarTheme.lightAppBarTheme,
      bottomSheetTheme: TBottomSheetTheme.lightBottomSheetTheme,
      elevatedButtonTheme: TElevatedButtonTheme.lightElevatedButtonTheme,
      inputDecorationTheme: TTextFormFieldTheme.lightInputDecorationThem);

  static ThemeData darkThemeEg = ThemeData(
      useMaterial3: true,
      fontFamily: isArabicLocale() ? 'Tajawal-Medium' : 'Nunito Sans',
      brightness: Brightness.dark,
      primaryColor: const Color(0xFF3F50CB),
      primaryColorLight: const Color(0xFF0099ff),
      primaryColorDark: const Color(0xFF3F50CB),
      // primaryColor: TColors.primary,
      scaffoldBackgroundColor: TColors.containerdarkColor,
      textTheme: TTextTheme.darkTextTheme,
      appBarTheme: TAppBarTheme.darkAppBarTheme,
      bottomSheetTheme: TBottomSheetTheme.darkBottomSheetTheme,
      elevatedButtonTheme: TElevatedButtonTheme.darkElevatedButtonTheme,
      inputDecorationTheme: TTextFormFieldTheme.darkInputDecorationThem);
}
