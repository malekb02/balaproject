import 'package:flutter_english_course/controllers/AdminController.dart';
import 'package:flutter_english_course/models/eleve/parentmodel.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';


import '../../../utils/Loaders/AppLoaders.dart';
import '../banner/studentrepo.dart';
import '../models/banner/BannerModel.dart';
import '../models/class/classModel.dart';
import '../models/eleve/eleveModel.dart';
import '../models/remarqueProf/remarqueProf.dart';





class StudentController extends GetxController{
  static StudentController get instance => Get.find();

  var selectedDate = DateTime.now().obs; // Reactive null// able DateTime
  RxBool isEditable = true.obs;
  RxList<ClassModel> selectedClasses = <ClassModel>[].obs;
  Rx<ClassModel> selectedClass = ClassModel.empty().obs;
  Rx<RemarqueProfModel> selectedMyRemarques = RemarqueProfModel.empty().obs;

  final isLoading = false.obs;

  @override
  void onInit(){
    fetchStudents();
    fetchParents();
  }
  Future<void> fetchStudents() async{
    try{
      //show loader
      isLoading.value = true;

      //fetch banners
      final studentController = Get.put(StudentRepository());
      final AllStudents = await studentController.fetchAllStudents();

      AdminController.instance.AllStudents.assignAll(AllStudents);
    }catch(e){
      AppLoaders.errorSnackbar(title: "Oops",message: "تحميل التلاميذ لم يتم بنجاح !");
    }finally{
      //remove loader
      isLoading.value = false;
      isLoading.refresh();
    }
  }
  Future<void> fetchParents() async{
    try{
      //show loader
      isLoading.value = true;

      //fetch banners
      final studentController = Get.put(StudentRepository());
      final AllParents = await studentController.fetchAllParents();

      AdminController.instance.AllParents.assignAll(AllParents);
    }catch(e){
      AppLoaders.errorSnackbar(title: "خطأ",message: "تحميل الأولياء لم يتم بنجاح !");
    }finally{
      //remove loader
      isLoading.value = false;
      isLoading.refresh();
    }
  }
  void updateClasses(EleveModel student) {
    isLoading.value = true;
    isLoading.refresh();
    selectedClasses.clear();
    var classes = AdminController.instance.MyClasses.where((classes) =>
    classes.dateTime.day == selectedDate.value.day && classes.dateTime.month == selectedDate.value.month && classes.dateTime.year == selectedDate.value.year).toList().obs;
    for (int i = 0; i < classes.length; i++) {
      for (int y = 0; y < classes[i].listeleve.length; y++) {
        if (classes[i].listeleve[y] == student.id) {
          selectedClasses.add(classes[i]);
        }
      }
    }
    isLoading.value = false;
    isLoading.refresh();

  }
  Future<void> AddNewStudent(EleveModel student,Parentmodel parent) async {

    await StudentRepository.instance.addNewStudent(student,parent);
    fetchParents();
    fetchStudents();

  }
  void updateRemarques(EleveModel student) {
    isLoading.value = true;
    isLoading.refresh();
    var lis1 = AdminController.instance.profRemarques.where((rem) => rem.classe == selectedClass.value.id).toList();
    selectedMyRemarques.value = lis1.isNotEmpty ? lis1.last : RemarqueProfModel.empty();
    selectedMyRemarques.refresh();
    selectedClass.refresh();
    isLoading.value = false;
    if(DateTime.now().day == selectedClass.value.dateTime.day && DateTime.now().month == selectedClass.value.dateTime.month && DateTime.now().year == selectedClass.value.dateTime.year){
      isEditable(true);
      isEditable.refresh();
    }else{
      isEditable(false);
      isEditable.refresh();
    }
    isLoading.refresh();
  }

  void updateDate(DateTime date, EleveModel student) {
    selectedDate.value = date;
    updateClasses(student);
    updateRemarques(student);
  }
}