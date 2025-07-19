import 'package:flutter_english_course/controllers/ClassController.dart';
import 'package:flutter_english_course/controllers/AdminController.dart';
import 'package:flutter_english_course/menus/classes_view.dart';
import 'package:flutter_english_course/models/class/classModel.dart';
import 'package:flutter_english_course/models/remarqueProf/remarqueIdara.dart';
import 'package:flutter_english_course/models/remarqueProf/remarqueProf.dart';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../utils/Loaders/AppLoaders.dart';
import '../banner/RemarqueRepo.dart';
import '../menus/widgets/ClassRemarqueCalendarController.dart';
import '../models/banner/BannerModel.dart';

class RemarqueController extends GetxController {
  static RemarqueController get instance => Get.find();

  final isLoading = false.obs;

  @override
  void onInit() async {
    super.onInit();

    isLoading.value = true;

    // Fetch both remarks before initializing calendar controller
    await fetchProfRemarqueClasses();
    await fetchIdaraRemarqueClasses();


    isLoading.value = false;
  }

  Future<void> fetchProfRemarqueClasses() async {
    try {
      isLoading.value = true;
      final repo = Get.put(RemarqueRepository());
      final profRemarques = await repo.fetchProfRemarques();
      AdminController.instance.profRemarques.assignAll(profRemarques);
      AdminController.instance.profRemarques.refresh();
    } catch (e) {
      AppLoaders.errorSnackbar(title: "خطأ", message: "تحميل ملاحظاتكم لم يتم بنجاح !");
    } finally {
      isLoading.value = false;
      isLoading.refresh();
    }
  }

  Future<void> fetchIdaraRemarqueClasses() async {
    try {
      isLoading.value = true;
      final repo = Get.put(RemarqueRepository());
      final idaraRemarques = await repo.fetchIdaraRemarques();
      AdminController.instance.IdaraRemarques.assignAll(idaraRemarques);
      AdminController.instance.IdaraRemarques.refresh();
    } catch (e) {
      AppLoaders.errorSnackbar(title: "خطأ", message: "تحميل ملاحظات الإدارة لم يتم بنجاح !");
    } finally {
      isLoading.value = false;
      isLoading.refresh();
    }
  }

  Future<void> addNewRemarqueIdara(RemarqueIdaraModel model) async {
    try {
      await RemarqueRepository.instance.addNewRemarqueIdara(model);
      await fetchIdaraRemarqueClasses();
      AdminController.instance.IdaraRemarques.refresh();
      AppLoaders.successSnackbar(title: "تم", message: "تمت إضافة ملاحظاتكم بنجاح");
    } catch (e) {
      AppLoaders.errorSnackbar(title: "خطأ", message: "إضافة ملاحظاتكم لم يتم بنجاح !");
    }
  }

  Future<void> updateRemarque(String id, Map<String, dynamic> json) async {
    try {
      await RemarqueRepository.instance.updateRemarqueIfara(id, json);
      await fetchIdaraRemarqueClasses();
      AdminController.instance.IdaraRemarques.refresh();
      AppLoaders.successSnackbar(title: "تم", message: "تمت التعديل على ملاحظاتكم بنجاح");
    } catch (e) {
      AppLoaders.errorSnackbar(title: "خطأ", message: "التعديل على ملاحظاتكم لم يتم بنجاح !");
    }
  }

  Future<void> deleteRemarque(RemarqueIdaraModel model) async {
    try {
      await RemarqueRepository.instance.removeIdaraRemarqueRecord(model.id);
      await fetchIdaraRemarqueClasses();
      AdminController.instance.IdaraRemarques.refresh();
      AppLoaders.successSnackbar(title: "تم", message: "تم حذف الملاحظة بنجاح !");
    } catch (e) {
      AppLoaders.warningSnackbar(title: "خطأ", message: e.toString());
    }
  }
}
