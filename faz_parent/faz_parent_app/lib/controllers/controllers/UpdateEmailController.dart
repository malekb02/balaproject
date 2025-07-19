import 'package:flutter/material.dart';
import 'package:flutter_english_course/controllers/ParentController.dart';
import 'package:flutter_english_course/repositories/banner/ParentRepository.dart';
import 'package:get/get.dart';
import '../../../utils/Network/networkmanager.dart';
import '../../../utils/constants/imageStrings.dart';
import '../../../utils/helpers/full_screen_loader.dart';
import '../../authentication/screens/Profile/profileScreen.dart';
import '../../utils/Loaders/AppLoaders.dart';


class UpdateEmailController extends GetxController{
  static UpdateEmailController get instance => Get.find();

  final email = TextEditingController();

  final parentController = ParentController.instance;
  final parentRespository = Get.put(ParentRepository());
  GlobalKey<FormState> updateEmailForm = GlobalKey<FormState>();

  @override
  void onInit(){
    initializeNames();
    super.onInit();
  }
  Future<void> initializeNames() async{
    email.text = parentController.Parent.value.email;
  }
  Future<void> updateAndConfirmEmail() async{
    try{
      ///start loading
      AppFullScrenLoader.openLoadingDialog("We are processing your information...", ImageStings.SuccessScreen);

      ///check internet connection
      final isConnected = await NetworkManager.instance.isConnected();
      if(!isConnected){
        return;
      }
      ///form validation
      if(!updateEmailForm.currentState!.validate()){
        AppFullScrenLoader.stopLoading();
        return;
      }

      Map<String,dynamic> name = {'Email' : email.text.trim(),};

      await parentRespository.updateSingleField(name);

      parentController.Parent.value.email = email.text.trim();


      AppFullScrenLoader.stopLoading();

      Get.off(()=>ProfileScreen());
    }catch(e){
      AppFullScrenLoader.stopLoading();
      AppLoaders.errorSnackbar(title: "Oops",message: e.toString());
    }

  }

}