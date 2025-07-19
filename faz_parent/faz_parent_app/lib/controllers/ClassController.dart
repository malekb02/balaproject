import 'package:flutter_english_course/controllers/EleveController.dart';
import 'package:flutter_english_course/controllers/ParentController.dart';
import 'package:flutter_english_course/models/class/classModel.dart';
import 'package:flutter_english_course/repositories/banner/ClassesRepository.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';


import '../../../utils/Loaders/AppLoaders.dart';
import '../models/banner/BannerModel.dart';
import '../repositories/banner/BannerRepositoty.dart';





class CLassController extends GetxController{
  static CLassController get instance => Get.find();

  final isLoading = false.obs;

  @override
  void onInit(){

  }

  Future<List<ClassModel>> fetchProfClasses() async{
    try{
      //show loader
      isLoading.value = true;

      //fetch banners
      final classesRepo = Get.put(ClassesRepository());
      final classes = await classesRepo.fetchProfClasses();

      return classes;
    }catch(e){
      AppLoaders.errorSnackbar(title: "Oops",message: "تحميل الحصص لم يتم بنجاح !");
      return [];
    }finally{
      //remove loader
      isLoading.value = false;
      isLoading.refresh();
    }
  }
  addNewClass(ClassModel model)async{
    try{
      await ClassesRepository.instance.addNewClass(model);
      fetchProfClasses();
      EleveController.instance.Classes.refresh();
      AppLoaders.successSnackbar(title: "مبروك",message: "تمت جدولة الحصة بنجاح!");

    }catch(e){
      AppLoaders.warningSnackbar(title: "Oops",message: "${e.toString()} addNewBanner ");
    }finally{

    }
  }
  deleteClass (ClassModel classmodel)async{
    try{
      await ClassesRepository.instance.removeClassRecord(classmodel.id);
      fetchProfClasses();
      EleveController.instance.Classes.refresh();
      AppLoaders.successSnackbar(title: "مبروك",message: "تم حذف الحصة بنجاح !");

    }catch(e){
      AppLoaders.warningSnackbar(title: "Oops",message: e.toString());
    }
  }
  editClass(ClassModel model) async{
    try{
      await ClassesRepository.instance.updateSingleField(model.id, model.toJson());
      fetchProfClasses();
      EleveController.instance.Classes.refresh();
      AppLoaders.successSnackbar(title: "مبروك",message: "تم تعديل الحصة بنجاح !");
    }catch(e){
      AppLoaders.warningSnackbar(title: "Oops",message: e.toString());
    }
  }
}