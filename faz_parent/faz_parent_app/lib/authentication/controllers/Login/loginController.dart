import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_english_course/models/prof/profModel.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../../utils/Network/networkmanager.dart';
import '../../../../utils/constants/imageStrings.dart';
import '../../../controllers/ParentController.dart';
import '../../../repositories/banner/AuthenticationRepository.dart';
import '../../../utils/Loaders/AppLoaders.dart';
import '../../../utils/helpers/full_screen_loader.dart';






class LoginController extends GetxController{

  final remeberMe = false.obs;
  final hidepassword = false.obs;
  final localStorage = GetStorage();
  final email = TextEditingController();
  final password = TextEditingController();


  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();

  final parentController =   Get.put(ParentController());

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
      await parentController.fetchParentRecord();


      if(userCredentials.user!.email == "aggomehdi79@gmail.com" || userCredentials.user!.email == "infinitybeauty218@gmail.com" ){
        ProfModel.isAdmin(true);
        localStorage.write("IS_ADMIN", true);
      }

      AppFullScrenLoader.stopLoading();
      AuthenticationRepository.instance.sreenRedirect();

    }catch(e){
      AppFullScrenLoader.stopLoading();
      AppLoaders.errorSnackbar(title: "Login failed",message: "Email or password Wrong");
    }
  }

  Future<void> googlSignIn() async{
    try{
      AppFullScrenLoader.openLoadingDialog("Loggin you in...", ImageStings.SuccessScreen);

      //Check internet connetivity
      final isConnected = await NetworkManager.instance.isConnected();

      if(!isConnected){
        AppFullScrenLoader.stopLoading();
        return;
      }

      final userCredential = await AuthenticationRepository.instance.signInWithGoogle();
      /// save user record
      await parentController.saveParentRecord(userCredential);

      /// remove the loader

      if(userCredential.user!.email == "aggomehdi79@gmail.com" ){
        ProfModel.isAdmin(true);
        localStorage.write("IS_ADMIN", true);
      }
      await parentController.fetchParentRecord();
      /// Stop Loader
      AppFullScrenLoader.stopLoading();
      ///redirect user
      AuthenticationRepository.instance.sreenRedirect();
    }catch(e){
      AppFullScrenLoader.stopLoading();
      AppLoaders.errorSnackbar(title: "Login failed",message: "${e.toString()} googlSignIn");
    }
  }
}
