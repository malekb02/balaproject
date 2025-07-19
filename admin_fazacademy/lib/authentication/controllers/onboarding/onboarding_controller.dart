import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../screens/login/login.dart';


class OnboardingController extends GetxController{
  static OnboardingController get instace => Get.find();

  final pageContoller = PageController();
  Rx<int> currentPageIndex = 0.obs;


  void updatePageIndicator(index) => currentPageIndex.value = index;


  void dotNavigationClick(index) {
    currentPageIndex.value = index;
    pageContoller.jumpTo(index);
  }

  void nextPage() {
    if(currentPageIndex.value == 2){
      final storage = GetStorage();
      storage.write("isFirstTime", false);
     Get.offAll(const LoginScreen());
    } else {
      int page = currentPageIndex.value + 1;
      pageContoller.jumpToPage(page);
    }
  }

  void skipPage() {
    currentPageIndex.value = 2;
    pageContoller.jumpToPage(2);
  }
}


