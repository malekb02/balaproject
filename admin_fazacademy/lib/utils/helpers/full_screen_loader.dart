import 'package:flutter/material.dart';
import 'package:get/get.dart';


import '../constants/colors.dart';
import '../device/device_utils.dart';
import 'AnimationLoader.dart';
import 'helper_functions.dart';

class AppFullScrenLoader {
  static void openLoadingDialog(String text, String animation) {
    showDialog(
        context: Get.overlayContext!,
        barrierDismissible: false,
        builder: (_) => PopScope(
            canPop: false,
            child: Container(
              color: AppHelperFunctions.isDarkMode(Get.context!) ? Colors.black : Colors.white ,
              width: 100,
              height: 100,
              child: Column(
                children: [
                  SizedBox(height: AppDeviceUtils.getAppBarHeight()*6,),
                 Center(
                   child: CircularProgressIndicator(color: Appcolors.primaryColor,),
                 ),

                  // Center(child: AnimationLoader(text: text,animation: animation)),
                ],
              ),


            )
        )
    );
  }

  static stopLoading(){
      Navigator.of(Get.overlayContext!).pop();
  }

}