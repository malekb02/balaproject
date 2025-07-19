import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_english_course/cores/cores.dart';
import 'package:flutter_english_course/routes/app_router.dart';


import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get_storage/get_storage.dart';
import 'banner/AuthenticationRepository.dart';
import 'firebase_options.dart';
import 'package:get/get.dart';
import 'App.dart';



void main() async {
  runApp(MyApp());

  WidgetsFlutterBinding.ensureInitialized();
  ///  Widgts Binding

  final WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  /// GetX local storage
  await GetStorage.init();

  /// Await native Splash
  FlutterNativeSplash.preserve(widgetsBinding : widgetsBinding);


  /// initializing Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  ).then(
          (FirebaseApp value) => Get.put(AuthenticationRepository())
  );
  //TODO: initializing Authentication

  //Get.put(UserController());
  //await Notificationfunctions().initNotifications();
  FirebaseAnalytics analytics = FirebaseAnalytics.instance;
 /* FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print('Got a message whilst in the foreground!');
    UserController.instance.Notification.value = message;
    //AppLoaders.successSnackbar(title: message.notification!.title,message: message.notification!.body);
    print('Message data: ${message.data}');
    Notificationfunctions().shownotification(message);

    if (message.notification != null) {
      print('Message also contained a notification: ${message.notification}');
    }
  }) ;*/
  //FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);



  FlutterNativeSplash.remove();
}



Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
 // UserController.instance.Notification.value = message;
  print("Handling a background message: ${message.messageId}");
}