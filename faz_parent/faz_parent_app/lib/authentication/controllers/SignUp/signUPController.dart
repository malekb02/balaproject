
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';


import '../../../../utils/Network/networkmanager.dart';
import '../../../controllers/ParentController.dart';
import '../../../models/prof/profModel.dart';
import '../../../repositories/banner/AuthenticationRepository.dart';
import '../../../utils/Loaders/AppLoaders.dart';
import '../../../utils/constants/imageStrings.dart';
import '../../../utils/helpers/full_screen_loader.dart';
import '../../screens/SignUp/verify_email.dart';
import '../user/userReposit.dart';



class SignupController extends GetxController{
  static SignupController get instance => Get.find();


  final hidePassword = true.obs;
  final checked = false.obs;
  final email = TextEditingController();
  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final username = TextEditingController();
  final phonenumber = TextEditingController();
  final password   = TextEditingController();
  GlobalKey<FormState> signUpForm = GlobalKey<FormState>();
  Future<void> signup() async{
    try{
      ///start loading
      AppFullScrenLoader.openLoadingDialog("We are processing your information...", ImageStings.SuccessScreen);

      ///check internet connection
      final isConnected = await NetworkManager.instance.isConnected();
      if(!isConnected){
        return;
      }
      ///form validation
      if(!signUpForm.currentState!.validate()){
        AppFullScrenLoader.stopLoading();
        return;
      }

      ///privacy policy check
      if(!checked.value){
        AppLoaders.warningSnackbar(title: "Accept privacy policy",message: "in order to create an account , you must have to read and accept the privacy policy & terms of use ");
        return;
      }

      ///register user in firebase auth  and save user  data in firebase
      final userCredential = await AuthenticationRepository.instance.registerWithEmailAndPassword(email.text.trim(), password.text.trim());

      ///save authenticated  user data  in firebase  firestore
      final newUser = ProfModel(
        id: userCredential.user!.uid,
        prenom : firstName.text.trim(),
        nom : lastName.text.trim(),
        username : username.text.trim(),
        email: email.text.trim(),
        numero: phonenumber.text.trim(),
        service: [],
      );
      final fCMToken = await FirebaseMessaging.instance.getToken();

      final userRepository  = Get.put(UserRepositoty());


      await userRepository.saveUserModel(newUser);
      ParentController.instance.fetchParentRecord();


      ///Remove Loader
      AppFullScrenLoader.stopLoading();

      ///show success message
      AppLoaders.successSnackbar(title: "Congratulations",message: "Your account  has been  created! verify your email to continue. ");

      /// move  to verify email screen
      Get.to(() => VerifyEmailScreen(email: email.text.trim(),));


    }catch(e){
      AppFullScrenLoader.stopLoading();
      /// show some error to user
      AppLoaders.errorSnackbar(title: "Oh Snap!",message: e.toString());

    }


  }





}

