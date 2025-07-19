import 'package:flutter_english_course/models/service/ServiceModel.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';


import '../../../utils/Loaders/AppLoaders.dart';
import '../../banner/ServiceRepository.dart';






class Profstatscontroller extends GetxController{
  static Profstatscontroller get instance => Get.find();



  @override
  void onInit(){
    super.onInit();
  }

  Future<void> StatReload() async{
    try{


    }catch(e){
      AppLoaders.errorSnackbar(title: "Oops",message: "${e.toString()} fetch services ");
    }finally{

    }
  }
}