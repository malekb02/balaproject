import 'package:flutter/material.dart';
import 'package:flutter_english_course/cores/cores.dart';
import 'package:flutter_english_course/routes/app_router.dart';
import 'package:flutter_english_course/routes/app_routes.dart';
import 'package:flutter_english_course/utils/bindings/general_bindings.dart';
import 'package:flutter_english_course/utils/constants/colors.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      locale: Locale('ar'), // Set Arabic as default language
      supportedLocales: [
        Locale('en'), // English
        Locale('ar'), // Arabic
      ],
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      debugShowCheckedModeBanner: false,
      title: 'Faz Academy',
      theme: AppTheme.lightTheme,
      themeMode: ThemeMode.light,
      getPages: AppRoutes.mainMenuRoutes,
      initialBinding: GeneralBindings(),
      home: Scaffold(backgroundColor: Appcolors.primaryColor,body:Center(child: CircularProgressIndicator(color: Colors.white))),

    );
  }
}