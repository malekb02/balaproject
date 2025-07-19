import 'package:flutter/material.dart';
import 'package:flutter_english_course/controllers/ParentController.dart';
import 'package:flutter_english_course/repositories/banner/ParentRepository.dart';
import 'package:get/get.dart';
import '../../authentication/screens/Profile/profileScreen.dart';
import '../../utils/Loaders/AppLoaders.dart';
import '../../../utils/Network/networkmanager.dart';
import '../../../utils/constants/imageStrings.dart';
import '../../../utils/helpers/full_screen_loader.dart';


class UpdateNameController extends GetxController{
  static UpdateNameController get instance => Get.find();

  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final parentController = ParentController.instance;
  final parentRespository = Get.put(ParentRepository());
  GlobalKey<FormState> updateNameForm = GlobalKey<FormState>();

  @override
  void onInit(){
    initializeNames();
    super.onInit();
  }
  Future<void> initializeNames() async{
    firstName.text = parentController.Parent.value.prenom;
    lastName.text = parentController.Parent.value.nom;
  }
  Future<void> updateUserName() async{
    try{
      ///start loading
      AppFullScrenLoader.openLoadingDialog("We are processing your information...", ImageStings.SuccessScreen);

      ///check internet connection
      final isConnected = await NetworkManager.instance.isConnected();
      if(!isConnected){
        return;
      }
      ///form validation
      if(!updateNameForm.currentState!.validate()){
        AppFullScrenLoader.stopLoading();
        return;
      }

      Map<String,dynamic> name = {'FirstName' : firstName.text.trim(),'LastName':lastName.text.trim()};

      await parentRespository.updateSingleField(name);

      parentController.Parent.value.prenom = firstName.text.trim();
      parentController.Parent.value.nom = lastName.text.trim();

      AppFullScrenLoader.stopLoading();
      AppLoaders.successSnackbar(title: "Congratulations",message: "Your Name has been updates");

      Get.off(()=>ProfileScreen());
    }catch(e){
      AppFullScrenLoader.stopLoading();
      AppLoaders.errorSnackbar(title: "Oops",message: e.toString());
    }

  }

}