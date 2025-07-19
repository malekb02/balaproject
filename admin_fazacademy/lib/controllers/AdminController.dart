import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_english_course/controllers/StudentController.dart';
import 'package:flutter_english_course/controllers/controllers/ProfRepo.dart';
import 'package:flutter_english_course/controllers/controllers/ServiceController.dart';
import 'package:flutter_english_course/controllers/remarqueController.dart';
import 'package:flutter_english_course/models/Stats/ProfStatsModel.dart';
import 'package:flutter_english_course/models/class/classModel.dart';
import 'package:flutter_english_course/models/eleve/eleveModel.dart';
import 'package:flutter_english_course/models/eleve/parentmodel.dart';
import 'package:flutter_english_course/models/prof/adminModel.dart';
import 'package:flutter_english_course/models/remarqueProf/remarqueProf.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_english_course/controllers/ClassController.dart';


import '../../../utils/Network/networkmanager.dart';
import '../../../utils/constants/imageStrings.dart';
import '../authentication/screens/Profile/widgets/reAuthLoginForm.dart';
import '../authentication/screens/login/login.dart';
import '../banner/AuthenticationRepository.dart';
import '../banner/adminrepo.dart';
import '../menus/widgets/ClassRemarqueCalendarController.dart';
import '../models/remarqueProf/remarqueIdara.dart';
import '../utils/Loaders/AppLoaders.dart';
import '../utils/constants/sizes.dart';
import '../utils/helpers/full_screen_loader.dart';
import 'controllers/profmodel.dart';


class AdminController extends GetxController {


  static AdminController get instance => Get.find();

  final profileLoading = false.obs;
  final imageUploading = false.obs;
  Rx<AdminModel> Admin = AdminModel.empty().obs;
  RxList<ClassModel> MyClasses = <ClassModel>[].obs;
  RxList<AdminModel> AllAdmins = <AdminModel>[].obs;
  RxList<ProfModel> AllProfs = <ProfModel>[].obs;
  RxList<EleveModel> AllStudents = <EleveModel>[].obs;
  RxList<ProfStatsModel> ProfStats = <ProfStatsModel>[].obs;
  RxList<Parentmodel> AllParents = <Parentmodel>[].obs;
  Rx<EleveModel> selectedStudent = EleveModel.empty().obs;
  Rx<Parentmodel> selectedParent = Parentmodel.empty().obs;
  RxList<RemarqueProfModel> profRemarques = <RemarqueProfModel>[].obs ;
  RxList<RemarqueIdaraModel> IdaraRemarques = <RemarqueIdaraModel>[].obs ;
  final verifyEmail = TextEditingController();
  final verifyPassword = TextEditingController();

  final hidepassword = false.obs;
  final AdminRepo = Get.put(adminrepository());
  final profRepo = Get.put(Profrepository());
  final proRepo = Get.put(());
  GlobalKey<FormState> reAuthForm = GlobalKey<FormState>();



  void onInit() async {
    super.onInit();
    await fetchAdminRecord();
    await fetchAllAdmins();
    await fetchAllProfs();
  }

  Future<void> fetchAdminRecord() async {
    try {
      profileLoading.value = true;
      final admin = await AdminRepo.fetchAdminDetails();
      this.Admin(admin);
    } catch (e) {
      Admin(AdminModel(id: "id",
          nom: "nom",
          prenom: "prenom",
          numero: "numero",
          email: "email",
          username: "username",
          position: ''));
    } finally {
      profileLoading.value = false;
      Get.put(Classremarquecalendarcontroller());
      Get.put(StudentController());
      Get.put(ServiceController());
      Get.put(RemarqueController());
      Classremarquecalendarcontroller.instance.loadSampleClasses(
          AdminController.instance.MyClasses,
          AdminController.instance.profRemarques,
          AdminController.instance.selectedStudent,
          AdminController.instance.IdaraRemarques);
      Classremarquecalendarcontroller.instance.updateWeekDays();
    }
  }

  Future<void> fetchAllAdmins() async{
    try{
      if(AdminModel.isAdmin == true){
        profileLoading.value = true;
        final user = await AdminRepo.fetchAllAdmins();
        this.AllAdmins.assignAll(user);
      }
    }catch(e){
      AllAdmins([]);
    }finally{
      profileLoading.value = false;
      AllAdmins.refresh();
    }
  }
  Future<void> AjouteNewProfRecord(ProfModel prof,String pass) async {
    try {
      profileLoading.value = true;
      UserCredential user = await AuthenticationRepository.instance.registerWithEmailAndPassword(prof.email,pass);
      await Profrepository.instance.saveProfModel(ProfModel(id: user.user!.uid,CoupParClass: 0, nom: prof.nom, prenom: prof.prenom, numero: prof.numero, email: prof.email, username: prof.username));
      AdminController.instance.fetchAllProfs();
      AllProfs.refresh();
    } catch (e) {
      AppLoaders.errorSnackbar(title: "خطأ في تحميل الأستاذ");
    } finally {
      profileLoading.value = false;
    }
  }

  Future<void> fetchAllProfs() async{
    try{
        profileLoading.value = true;
        final user = await Profrepository.instance.fetchAllProfs();
        this.AllProfs.assignAll(user);
    }catch(e){
      AllProfs([]);
    }finally{
      profileLoading.value = false;
      AllProfs.refresh();
    }
  }


  Future<void> saveProfRecord(UserCredential? userCredential) async {
    try {
      await fetchAdminRecord();
      if(Admin.value.id == "id"){
        if (userCredential != null) {
          final nameParts = AdminModel.nameParts(userCredential.user!.displayName ?? '');
          final username = AdminModel.generateUserName(userCredential.user!.displayName ?? '');

          final prof = AdminModel(
              id: userCredential.user!.uid,
              prenom: nameParts[0],
              nom: nameParts.length > 1 ? nameParts.sublist(1).join(' ') : '',
              username: username,
              email: userCredential.user!.email ?? '',
              numero: userCredential.user!.phoneNumber ?? '',
              position: ""
              );
          await AdminRepo.saveAdminModel(prof);
        }
      }
    } catch (e) {
      AppLoaders.warningSnackbar(title: "Data not saved", message: "Something went wrong while saving your information, You can re-save your data in your profile");
    }
  }

  void deletAccountWarningPopUp(){
    Get.defaultDialog(
        contentPadding: EdgeInsets.all(AppSizes.md),
        title: "Delete Account",
        middleText: "Are you sure you want to delete Prof account permanently ?,this action is not reversable the data will be permanently deleted. ",
        confirm: ElevatedButton(
          onPressed: () async => deleteUserAcoount(),
          style: ElevatedButton.styleFrom(backgroundColor: Colors.red,side: BorderSide(color: Colors.red)),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: AppSizes.lg),
            child: Text("Delete"),
          ),
        ),
        cancel: OutlinedButton(onPressed: ()=>Navigator.of(Get.overlayContext!).pop(), child: Text("Cancel"))
    );
  }

  void deleteUserAcoount() async{
    try{
      AppFullScrenLoader.openLoadingDialog("We are processing your information...", ImageStings.SuccessScreen);

      final auth = AuthenticationRepository.instance;
      final provider = auth.authUser!.providerData.map((e) => e.providerId).first;
      if(provider.isNotEmpty){
        if(provider == 'google.com'){
          await auth.deleteAccount();

          AppFullScrenLoader.stopLoading();
          Get.offAll(()=> LoginScreen());
        } else if(provider == "password"){
          AppFullScrenLoader.stopLoading();
          Get.to(()=> ReAuthLoginForm());
        }
      }
    }catch(e){
      AppFullScrenLoader.stopLoading();
      AppLoaders.warningSnackbar(title: "Oops",message: e.toString());
    }
  }

  void reAuthenticateUserEmailAndPassword() async{
    try{
      AppFullScrenLoader.openLoadingDialog("Loggin you in...", ImageStings.SuccessScreen);

      //Check internet connetivity
      final isConnected = await NetworkManager.instance.isConnected();

      if(!isConnected){
        AppFullScrenLoader.stopLoading();
        return;
      }
      if(!reAuthForm.currentState!.validate()){
        AppFullScrenLoader.stopLoading();
        return;
      }
      await AuthenticationRepository.instance.reAuthenticateWithEmailAndPassword(verifyEmail.text.trim(),verifyPassword.text.trim(),);
      await AuthenticationRepository.instance.deleteAccount();
      AppFullScrenLoader.stopLoading();
      Get.offAll(()=>LoginScreen());

    }catch(e){
      AppFullScrenLoader.stopLoading();
      AppLoaders.warningSnackbar(title: "Oops",message: e.toString());
    }
  }


}
