import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_english_course/models/prof/adminModel.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../../utils/Network/networkmanager.dart';
import '../../../../utils/constants/imageStrings.dart';
import '../../../banner/AuthenticationRepository.dart';
import '../../../controllers/AdminController.dart';
import '../../../utils/Loaders/AppLoaders.dart';
import '../../../utils/helpers/full_screen_loader.dart';






class LoginController extends GetxController{

  final remeberMe = false.obs;
  final hidepassword = false.obs;
  final localStorage = GetStorage();
  final email = TextEditingController();
  final password = TextEditingController();


  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();

  final adminController =  Get.put(AdminController());
  @override
  void onInit(){
    email.text= localStorage.read("REMEMBER_ME_EMAIL") ?? "";
    password.text= localStorage.read("REMEMBER_ME_PASSWORD") ?? "";
    super.onInit();
  }


  Future<void> emailAndPasswordSignIn()async{
    try{

      AppFullScrenLoader.openLoadingDialog("Loggin you in...", ImageStings.SuccessScreen);
      ///check internet connection
      final isConnected = await NetworkManager.instance.isConnected();
      if(!isConnected){
        AppFullScrenLoader.stopLoading();
        return;
      }

      ///form validation
      if(!loginFormKey.currentState!.validate()){
        AppFullScrenLoader.stopLoading();
        return;
      }

      if(remeberMe.value){
        localStorage.write("REMEMBER_ME_EMAIL", email.text.trim());
        localStorage.write("REMEMBER_ME_PASSWORD", password.text.trim());
      }


      final UserCredential userCredentials = await AuthenticationRepository.instance.loginWithEmailAndPassword(email.text.trim(), password.text.trim());
      await adminController.fetchAdminRecord();


      AppFullScrenLoader.stopLoading();
      AuthenticationRepository.instance.sreenRedirect();

    }catch(e){
      AppFullScrenLoader.stopLoading();
      AppLoaders.errorSnackbar(title: "Login failed",message: "Email or password Wrong");
    }
  }
}
