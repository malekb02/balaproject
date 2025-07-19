import 'package:flutter/material.dart';
import 'package:flutter_english_course/controllers/ParentController.dart';
import 'package:flutter_english_course/modules/menus/courses_view.dart';
import 'package:flutter_english_course/modules/menus/home_view.dart';
import 'package:flutter_english_course/modules/menus/profile_view.dart';
import 'package:flutter_english_course/repositories/banner/AuthenticationRepository.dart';
import 'package:flutter_english_course/utils/constants/colors.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:iconsax/iconsax.dart';

import 'modules/menus/programmensuel.dart';


class NavigationMenu extends StatelessWidget {
  const NavigationMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final controller = Get.put(NavigationControler());
    final authcontroller = Get.put(AuthenticationRepository());

    return Scaffold(
      bottomNavigationBar: Obx(
            () => NavigationBar(
          height: 80,
          elevation: 0,
          selectedIndex: controller.selectedIndex.value,
          onDestinationSelected: (index) => controller.selectedIndex.value = index,
          backgroundColor:  Colors.white,
          indicatorColor:  Appcolors.black.withOpacity(0.1) ,
          destinations: [
            NavigationDestination(icon: Icon(Iconsax.home), label: "اليومية"),
            NavigationDestination(icon: Icon(Iconsax.book), label: "البرنامج"),
            NavigationDestination(icon: Icon(Iconsax.user), label: "الإعدادات"),
          ],
        ),
      ),
      body: Obx(() => controller.screens[controller.selectedIndex.value]),
    );
  }
}

class NavigationControler extends GetxController{
  final Rx<int> selectedIndex = 0.obs;

  final screens = [const HomeView(),const ProgramMens(),const ProfileView()];

}
