import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../../utils/Network/networkmanager.dart';
import '../../../../utils/constants/imageStrings.dart';
import '../../../repositories/banner/AuthenticationRepository.dart';
import '../../../utils/Loaders/AppLoaders.dart';
import '../../../utils/helpers/full_screen_loader.dart';
import '../../screens/paswword_configuration/ResetPassword.dart';




class ResetPasswordController extends GetxController{


  final email = TextEditingController();
  GlobalKey<FormState> ResetPaswordKey = GlobalKey<FormState>();

  @override
  void onInit(){
    super.onInit();
  }

  Future<void> resetPassword()async{
    try{

      AppFullScrenLoader.openLoadingDialog("Loggin you in...", ImageStings.SuccessScreen);
      Get.put(AuthenticationRepository());
      ///check internet connection
      final isConnected = await NetworkManager.instance.isConnected();
      if(!isConnected){
        AppFullScrenLoader.stopLoading();
        return;
      }
      if(!ResetPaswordKey.currentState!.validate()){
        AppFullScrenLoader.stopLoading();
        return;
      }
      await AuthenticationRepository.instance.resetPassword(email.text.trim());
      AppFullScrenLoader.stopLoading();
      AppLoaders.successSnackbar(title: "Reset password",message: "Reset password link sent. Please check your inbox");

      Get.to(()=>ResetPasswordScreen());
    }catch(e){
      AppFullScrenLoader.stopLoading();
      AppLoaders.errorSnackbar(title: "Oops something went wrong Reseting password",message: e.toString());
    }
  }
}
