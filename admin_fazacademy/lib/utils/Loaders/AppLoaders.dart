import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../constants/colors.dart';
import '../helpers/helper_functions.dart';

class AppLoaders  {
  static hideSnackBar() => ScaffoldMessenger.of(Get.context!).hideCurrentSnackBar();


  static customToast({required message}){
    ScaffoldMessenger.of(Get.context!).showSnackBar(
      SnackBar(
        elevation: 0,
        duration: Duration(seconds :3),
        backgroundColor: Colors.transparent,
        content: Container(
          padding: EdgeInsets.all(12),
          margin: EdgeInsets.symmetric(horizontal: 30),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: AppHelperFunctions.isDarkMode(Get.context!) ? Appcolors.darkergrey.withOpacity(0.9):Appcolors.grey.withOpacity(0.9),

          ),
          child: Center(
            child: Text(message,style: Theme.of(Get.context!).textTheme.labelLarge,),
          ),
        ),
      ),
    );
  }
  static successSnackbar({required title, message = '', duration = 3}) {
    Get.snackbar(title, message,
        isDismissible: true,
        shouldIconPulse: true,
        colorText: Appcolors.white,
        backgroundColor: Appcolors.primaryColor,
        snackPosition: SnackPosition.BOTTOM,
        duration: Duration(seconds: duration),
        margin: EdgeInsets.all(10),
        icon: Icon(Iconsax.check,color: Appcolors.white,),
    );
  }
  static errorSnackbar({required title, message = '', duration = 3}) {
    Get.snackbar(title, message,
      isDismissible: true,
      shouldIconPulse: true,
      colorText: Appcolors.white,
      backgroundColor: Colors.red.shade800,
      snackPosition: SnackPosition.BOTTOM,
      duration: Duration(seconds: duration),
      margin: EdgeInsets.all(10),
      icon: Icon(Iconsax.warning_2,color: Appcolors.white,),
    );
  }
  static warningSnackbar({required title, message = '',}) {
    Get.snackbar(title, message,
      isDismissible: true,
      shouldIconPulse: true,
      colorText: Appcolors.white,
      backgroundColor: Colors.orange,
      snackPosition: SnackPosition.BOTTOM,
      duration: Duration(seconds: 3),
      margin: EdgeInsets.all(20),
      icon: Icon(Iconsax.warning_2,color: Appcolors.white,),
    );
  }
}
