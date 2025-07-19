import 'package:flutter/material.dart';
import 'package:flutter_english_course/controllers/AdminController.dart';
import 'package:get/get.dart';
import '../../authentication/screens/Profile/profileScreen.dart';
import '../../banner/adminrepo.dart';
import '../../utils/Loaders/AppLoaders.dart';
import '../../../utils/Network/networkmanager.dart';
import '../../../utils/constants/imageStrings.dart';
import '../../../utils/helpers/full_screen_loader.dart';


class UpdateNameController extends GetxController{
  static UpdateNameController get instance => Get.find();

  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final profController = AdminController.instance;
  final profRespository = Get.put(adminrepository());
  GlobalKey<FormState> updateNameForm = GlobalKey<FormState>();

  @override
  void onInit(){
    initializeNames();
    super.onInit();
  }
  Future<void> initializeNames() async{
    firstName.text = profController.Admin.value.prenom;
    lastName.text = profController.Admin.value.nom;
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

      await profRespository.updateSingleField(name);

      profController.Admin.value.prenom = firstName.text.trim();
      profController.Admin.value.nom = lastName.text.trim();

      AppFullScrenLoader.stopLoading();
      AppLoaders.successSnackbar(title: "Congratulations",message: "Your Name has been updates");

      Get.off(()=>ProfileScreen());
    }catch(e){
      AppFullScrenLoader.stopLoading();
      AppLoaders.errorSnackbar(title: "Oops",message: e.toString());
    }

  }

}