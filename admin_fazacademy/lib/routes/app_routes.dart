import 'package:flutter/material.dart';
import 'package:flutter_english_course/menus/Screens/ProfsScreen.dart';
import 'package:flutter_english_course/menus/classes_view.dart';
import 'package:flutter_english_course/routes/app_routesl.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:go_router/go_router.dart';

import '../menus/StudentsView.dart';
import '../menus/home_view.dart';
import '../menus/profile_view.dart';

class AppRoutes {
  static final mainMenuRoutes = [
    GetPage(name: AppRoutesl.home, page: ()=> HomeView()),
    GetPage(name: AppRoutesl.classes, page: ()=> ClassesView()),
    GetPage(name: AppRoutesl.courses, page: ()=> StudentsView()),
    GetPage(name: AppRoutesl.profs, page: ()=> ProfsScreen()),
    GetPage(name: AppRoutesl.profile, page: ()=> ProfileView()),
  ];
}
