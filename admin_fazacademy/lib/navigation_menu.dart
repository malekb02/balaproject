import 'package:flutter/material.dart';
import 'package:flutter_english_course/controllers/remarqueController.dart';
import 'package:flutter_english_course/menus/classes_view.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:iconsax/iconsax.dart';

import 'banner/AuthenticationRepository.dart';
import 'controllers/AdminController.dart';
import 'controllers/ClassController.dart';
import 'menus/Screens/ProfsScreen.dart';
import 'menus/StudentsView.dart';
import 'menus/home_view.dart';
import 'menus/profile_view.dart';
import 'utils/constants/colors.dart';

class NavigationMenu extends StatelessWidget {
  const NavigationMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final profcontroller = Get.put(AdminController());
    final classcontroller = Get.put(CLassController());
    final controller = Get.put(NavigationControler());

    return Scaffold(
      bottomNavigationBar: Obx(
            () => NavigationBar(
          height: 80,
          elevation: 1,
          selectedIndex: controller.selectedIndex.value,
          onDestinationSelected: (index) => controller.selectedIndex.value = index,
          backgroundColor:  Colors.white,
          indicatorColor:  Appcolors.black.withOpacity(0.1) ,
          destinations: [
            NavigationDestination(icon: Icon(Iconsax.home), label: "الصفحة الرئيسية"),
            NavigationDestination(icon: Icon(Iconsax.clock), label: "الحصص"),
            NavigationDestination(icon: Icon(Icons.child_care), label: "التلاميذ"),
            NavigationDestination(icon: Icon(Iconsax.user), label: "الأساتذة"),
            NavigationDestination(icon: Icon(Iconsax.chart), label: "الاحصائيات"),
          ],
        ),
      ),
      body: Obx(() => controller.screens[controller.selectedIndex.value]),
    );
  }
}

class NavigationControler extends GetxController{
  final Rx<int> selectedIndex = 0.obs;

  final screens = [const HomeView(), ClassesView(),const StudentsView(),ProfsScreen(),const ProfileView()];

}
