import 'package:flutter_english_course/controllers/AdminController.dart';
import 'package:flutter_english_course/models/Stats/ProfStatsModel.dart';
import 'package:flutter_english_course/models/class/classModel.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';


import '../../../utils/Loaders/AppLoaders.dart';
import '../banner/ClassesRepository.dart';
import '../menus/classes_view.dart';
import '../models/banner/BannerModel.dart';
import 'controllers/StatsRepo.dart';





class Profstatscontroller extends GetxController{
  static Profstatscontroller get instance => Get.find();

  final isLoading = false.obs;

  @override
  void onInit(){
    fetchProfStats();
  }

  Future<void> fetchProfStats() async{
    try{
      isLoading.value = true;
      final StatsRepo = Get.put(StatProfsrepo());
      final stats = await StatsRepo.fetchStats();
      AdminController.instance.ProfStats.assignAll(stats);
    }catch(e){
      AppLoaders.errorSnackbar(title: "Oops",message: "تحميل الإحصائيات لم يتم بنجاح !");
    }finally{
      isLoading.value = false;
      isLoading.refresh();
    }
  }
  Future<void> addNewProfStatRecord(ProfStatsModel model) async {
    try {
      final docRef = await StatProfsrepo.instance.addNewStatRecord(model);

      AppLoaders.successSnackbar(title: "مبروك", message: "تمت إضافة جدول إحصائيات بنجاح!");
    } catch (e) {
      AppLoaders.warningSnackbar(title: "Oops", message: "$e");
      return null;
    }
  }

  deleteStatRecord (String id) async {
    try {
      await StatProfsrepo.instance.removeProfStatsRecord(id);
      await fetchProfStats();
      AppLoaders.successSnackbar(title: "مبروك", message: "تم حذف الإحصائيات بنجاح !");
    } catch (e) {
      AppLoaders.warningSnackbar(title: "Oops", message: e.toString());
    }
  }

  updateStats (ProfStatsModel model) async{
    try{
      await ClassesRepository.instance.updateSingleField(model.id, model.toJson());
      fetchProfStats();
      AdminController.instance.ProfStats.refresh();
      AppLoaders.successSnackbar(title: "مبروك",message: "تم تعديل الحصة بنجاح !");
    }catch(e){
      AppLoaders.warningSnackbar(title: "Oops",message: e.toString());
    }
  }
}