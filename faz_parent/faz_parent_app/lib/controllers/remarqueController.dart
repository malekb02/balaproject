import 'package:flutter_english_course/controllers/ClassController.dart';
import 'package:flutter_english_course/controllers/EleveController.dart';
import 'package:flutter_english_course/controllers/ParentController.dart';
import 'package:flutter_english_course/models/class/classModel.dart';
import 'package:flutter_english_course/models/remarqueProf/remarqueProf.dart';
import 'package:flutter_english_course/repositories/banner/ClassesRepository.dart';
import 'package:flutter_english_course/repositories/banner/RemarqueRepo.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';


import '../../../utils/Loaders/AppLoaders.dart';
import '../models/banner/BannerModel.dart';
import '../models/remarqueProf/remarqueIdara.dart';
import '../modules/menus/widgets/ClassRemarqueCalendarController.dart';
import '../repositories/banner/BannerRepositoty.dart';





class RemarqueController extends GetxController{
  static RemarqueController get instance => Get.find();

  final isLoading = false.obs;


  @override
  void onInit(){

  }

  Future<List<RemarqueProfModel>> fetchProfRemarqueClasses() async{
    try{
      //show loader
      isLoading.value = true;

      //fetch banners
      final ProfRemarqueRepo = Get.put(RemarqueRepository());
      final profremarques = await ProfRemarqueRepo.fetchProfRemarques();

      return profremarques;
    }catch(e){
      AppLoaders.errorSnackbar(title: "Oops",message: "تحميل ملاحظاتكم لم يتم بنجاح !");
      return [];
    }finally{
      //remove loader
      isLoading.value = false;
      isLoading.refresh();
    }
  }
  Future<List<RemarqueIdaraModel>> fetchIdaraRemarqueClasses() async{
    try{
      //show loader
      isLoading.value = true;

      //fetch banners
      final IdaraRemarqueRepo = Get.put(RemarqueRepository());
      final Idararemarques = await IdaraRemarqueRepo.fetchIdaraRemarques();

      return Idararemarques;
    }catch(e){
      AppLoaders.errorSnackbar(title: "Oops",message: "تحميل ملاحظات الإدارة لم يتم بنجاح !");
      return [];
    }finally{
      //remove loader
      isLoading.value = false;
      isLoading.refresh();
    }
  }


}