import 'package:flutter_english_course/controllers/AdminController.dart';
import 'package:flutter_english_course/models/class/classModel.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';


import '../../../utils/Loaders/AppLoaders.dart';
import '../banner/ClassesRepository.dart';
import '../menus/classes_view.dart';
import '../models/banner/BannerModel.dart';





class CLassController extends GetxController{
  static CLassController get instance => Get.find();

  final isLoading = false.obs;

  @override
  void onInit(){
    fetchProfClasses();
  }

  Future<void> fetchProfClasses() async{
    try{
      //show loader
      isLoading.value = true;

      //fetch banners
      final classesRepo = Get.put(ClassesRepository());
      final classes = await classesRepo.fetchProfClasses();

      AdminController.instance.MyClasses.assignAll(classes);
      Get.put(CalendarController());
    }catch(e){
      AppLoaders.errorSnackbar(title: "Oops",message: "تحميل الحصص لم يتم بنجاح !");
    }finally{
      //remove loader
      isLoading.value = false;
      isLoading.refresh();
    }
  }
  Future<ClassModel?> addNewClass(ClassModel model) async {
    try {
      final docRef = await ClassesRepository.instance.addNewClass(model);
      final addedClass = model.copyWith(id: docRef.id);

      // Optional: You can fetch all classes again here if needed
      // await fetchProfClasses();

      AppLoaders.successSnackbar(title: "مبروك", message: "تمت جدولة الحصة بنجاح!");
      return addedClass;
    } catch (e) {
      AppLoaders.warningSnackbar(title: "Oops", message: "$e");
      return null;
    }
  }

  deleteClass (ClassModel classmodel) async {
    try {
      // Delete from Firestore
      await ClassesRepository.instance.removeClassRecord(classmodel.id);

      // Re-fetch the professor's classes from Firestore
      await fetchProfClasses();

      // Reload calendar data with updated class list
      CalendarController.instance.loadSampleClasses(AdminController.instance.MyClasses);
      CalendarController.instance.updateWeekDays();

      // Optional: show success feedback
      AppLoaders.successSnackbar(title: "مبروك", message: "تم حذف الحصة بنجاح !");
    } catch (e) {
      AppLoaders.warningSnackbar(title: "Oops", message: e.toString());
    }
  }

  editClass(ClassModel model) async{
    try{
      await ClassesRepository.instance.updateSingleField(model.id, model.toJson());
      fetchProfClasses();
      AdminController.instance.MyClasses.refresh();
      AppLoaders.successSnackbar(title: "مبروك",message: "تم تعديل الحصة بنجاح !");
    }catch(e){
      AppLoaders.warningSnackbar(title: "Oops",message: e.toString());
    }
  }
}