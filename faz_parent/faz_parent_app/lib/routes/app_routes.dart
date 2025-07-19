import 'package:flutter/material.dart';
import 'package:flutter_english_course/modules/menus/courses_view.dart';
import 'package:flutter_english_course/modules/menus/home_view.dart';
import 'package:flutter_english_course/modules/menus/live_courses_view.dart';
import 'package:flutter_english_course/modules/menus/profile_view.dart';
import 'package:flutter_english_course/routes/app_routesl.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:go_router/go_router.dart';

class AppRoutes {
  static final mainMenuRoutes = [
    GetPage(name: AppRoutesl.home, page: ()=> HomeView()),
    GetPage(name: AppRoutesl.courses, page: ()=> CoursesView()),
    GetPage(name: AppRoutesl.profile, page: ()=> ProfileView()),

  ];
}
