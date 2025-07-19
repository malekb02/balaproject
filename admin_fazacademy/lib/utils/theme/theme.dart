import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'Customthemes/ChipTheme.dart';
import 'Customthemes/appBarTheme.dart';
import 'Customthemes/button_sheet_theme.dart';
import 'Customthemes/checkbox_theme.dart';
import 'Customthemes/elevatebutton_theme.dart';
import 'Customthemes/outlined_button_theme.dart';
import 'Customthemes/text_fiekd_theme.dart';
import 'Customthemes/text_theme.dart';



class Apptheme{
  Apptheme._();

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    fontFamily: GoogleFonts.poppins().fontFamily,
    brightness: Brightness.light,
    primaryColor: Colors.pink,
    primarySwatch: Colors.pink,
    scaffoldBackgroundColor: Colors.white,
    textTheme: AppTextTheme.lightTextTheme,
    elevatedButtonTheme: ElevateTheme.lightElevateButtonTheme,
    bottomSheetTheme: AppBottomSheetTheme.lightBottomSheetTheme,
    checkboxTheme: AppCheckBoxTheme.lightCheckBoxTheme,
    chipTheme: AppChipTheme.lightChipTheme,
    outlinedButtonTheme: AppOutlinedButoonTheme.lightOutlinedButtonTheme,
    inputDecorationTheme: AppTextFieldTheme.lightInputDecoration,
    appBarTheme: AppBBarTheme.lightAppBarTheme,
  );
  static ThemeData DarkTheme = ThemeData(
    useMaterial3: true,
    fontFamily: GoogleFonts.poppins().fontFamily,
    brightness: Brightness.dark,
    primaryColor: Colors.pink,
    scaffoldBackgroundColor: Colors.black,
    textTheme: AppTextTheme.darkTextTheme,
    elevatedButtonTheme: ElevateTheme.darkElevateButtonTheme,
    bottomSheetTheme: AppBottomSheetTheme.darkBottomSheetTheme,
    checkboxTheme: AppCheckBoxTheme.darkCheckBoxTheme,
    chipTheme: AppChipTheme.darkChipTheme,
    outlinedButtonTheme: AppOutlinedButoonTheme.darkOutlinedButtonTheme,
    inputDecorationTheme: AppTextFieldTheme.darkInputDecoration,
    appBarTheme: AppBBarTheme.darkAppBarTheme,

  );
}