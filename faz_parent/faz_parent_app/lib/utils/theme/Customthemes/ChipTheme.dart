import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/colors.dart';


class AppChipTheme{
  AppChipTheme._();

  static ChipThemeData lightChipTheme = ChipThemeData(
    disabledColor: Appcolors.grey.withOpacity(0.4),
    labelStyle: TextStyle(color: Appcolors.black),
    selectedColor: Appcolors.primaryColor,
    padding: EdgeInsets.symmetric(horizontal: 12,vertical: 12),
    checkmarkColor: Appcolors.white
  );

  static ChipThemeData darkChipTheme = ChipThemeData(
      disabledColor: Appcolors.darkergrey,
      labelStyle: TextStyle(color: Appcolors.white),
      selectedColor: Appcolors.primaryColor,
      padding: EdgeInsets.symmetric(horizontal: 12,vertical: 12),
      checkmarkColor: Appcolors.white,
  );
}