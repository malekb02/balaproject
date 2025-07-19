import 'package:flutter_english_course/controllers/controllers/ServiceController.dart';
import 'package:flutter_english_course/controllers/remarqueController.dart';
import 'package:flutter_english_course/models/class/classModel.dart';
import 'package:flutter_english_course/models/eleve/eleveModel.dart';
import 'package:flutter_english_course/models/remarqueProf/remarqueProf.dart';
import 'package:flutter_english_course/repositories/banner/ParentRepository.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:flutter_english_course/controllers/ClassController.dart';
import '../models/remarqueProf/remarqueIdara.dart';
import '../modules/menus/programmensuel.dart';


class EleveController extends GetxController {


  static EleveController get instance => Get.find();

  final ParentLoading = false.obs;
  final imageUploading = false.obs;
  RxList<ClassModel> Classes = <ClassModel>[].obs;
  Rx<EleveModel> selectedStudent = EleveModel.empty().obs;
  Rx<ClassModel> selectedClass = ClassModel.empty().obs;
  RxList<RemarqueProfModel> profremarques = <RemarqueProfModel>[].obs;
  RxList<RemarqueIdaraModel> Idararemarques = <RemarqueIdaraModel>[].obs;

  final ParentRepositoty = Get.put(ParentRepository());
  RxBool eleveSelected = false.obs;
  RxBool isLoading = false.obs;
  final contr = Get.put(CalendarController());
  final contC = Get.put(CLassController());
  final contS = Get.put(ServiceController());
  final contR = Get.put(RemarqueController());

  void onInit() async {
    super.onInit();

  }

    Future<void> fetchEleveProfileData() async{
      try{
        ParentLoading.value = true;

        final classlist = CLassController.instance.fetchProfClasses();
        Classes.assignAll(await classlist);

        final profRlist = await RemarqueController.instance.fetchProfRemarqueClasses();
        profremarques.assignAll(profRlist);
        final contR = Get.put(RemarqueController());
        final IdaraRlist = await contR.fetchIdaraRemarqueClasses();
        Idararemarques.assignAll(IdaraRlist);
        contr.loadSampleClasses(Classes,Idararemarques,profremarques,selectedStudent);
      }catch(e){
        print("❌ Error caught in fetchEleveProfileData: $e");
      }finally{
        ParentLoading.value = false;
      }
    }





}
