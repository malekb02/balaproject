import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../../../../utils/Loaders/AppLoaders.dart';
import '../../../repositories/banner/AuthenticationRepository.dart';
import 'emailSucess.dart';



class VerifyEmailController extends GetxController{
  static VerifyEmailController get instance => Get.find();

  @override
  void onInit(){
    sendEmailVerification();
    setTimerForAutoRedirect();
    super.onInit();
  }


  ///send Email Verification link
  sendEmailVerification()async{
    try{
      await AuthenticationRepository.instance.sendEmailVerification();
      AppLoaders.successSnackbar(title: 'Email Sent', message: "Please check your inbox and verify your email.");

    }catch(e){
      AppLoaders.errorSnackbar(title: 'Oh snap!', message: e.toString());
    }
  }

  ///Timer to automatically redirect on email verificatio
  setTimerForAutoRedirect()  {
    Timer.periodic( Duration(seconds: 1),(timer) async{
      await FirebaseAuth.instance.currentUser?.reload();
      final user = FirebaseAuth.instance.currentUser;
      if(user?.emailVerified ?? false){
        timer.cancel();
        Get.off(EmailSuccessScreen());
      }
    });
  }

  ///Manually check if email verified
  checkEmailVerificationStatus() async{
    final currentUser =  FirebaseAuth.instance.currentUser;
    if(currentUser != null && currentUser.emailVerified){
      Get.off(
          ()=> EmailSuccessScreen()
      );
    }
  }
}