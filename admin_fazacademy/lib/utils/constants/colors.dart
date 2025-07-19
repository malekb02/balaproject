import 'package:flutter/material.dart';





class Appcolors {
  Appcolors._();

  static const Color primaryColor = Colors.purple;
  static const Color seconderyColor = Colors.cyanAccent;
  static const Color accent = Colors.pinkAccent;

  //text colors

  static const Color textPrimary = Color(0xFF333333);
  static const Color textSecondary = Color(0xFF6C7570);
  static const Color textWhite = Colors.white;

  //background colors

  static const Color light = Color(0xFFF6F6F6);
  static const Color dark = Color(0xFF272727);
  static const Color primaryBackgroundColor = Color(0xFFF3F5FF);

  //container colors

  static const Color lightContainer = Color(0xFFF6F6F6);
  static Color darkContainer = Appcolors.white.withOpacity(0.1);

  //button colors

  static const Color buttonPrimary = Colors.pink;
  static const Color buttonSecondary = Color(0xff6c7570);
  static const Color buttonDisabled = Color(0xFFC4C4C4);

  //border colors

  static const Color boderPrimary = Color(0xFFD9D9D9);
  static const Color borderSecondary = Color(0xFFE6E6E6);



  static const Color error = Color(0xFFD32F2F);
  static const Color success = Color(0xFF388E3C);
  static const Color warning = Color(0xFFF57C00);
  static const Color info = Color(0xFF1976D2);

  //shades

  static const Color black = Color(0xFF232323);
  static const Color darkergrey = Color(0xFF4F4F4F);
  static const Color darkgrey = Color(0xFF939393);
  static const Color grey = Color(0xFFE0E0E0);
  static const Color softgrey = Color(0xFFF4F4F4);
  static const Color lightgrey = Color(0xFFF9F9F9);
  static const Color white = Color(0xFFFFFFFF);


//gradient

  static const Gradient linearGradient = LinearGradient(
      begin: Alignment(0.0, 0.0),
      end: Alignment(0.707, -0.707),
      colors: [
        primaryColor,
        seconderyColor
      ]
  );





}