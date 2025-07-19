import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_english_course/controllers/controllers/ServiceController.dart';
import 'package:flutter_english_course/controllers/remarqueController.dart';
import 'package:flutter_english_course/models/class/classModel.dart';
import 'package:flutter_english_course/models/eleve/eleveModel.dart';
import 'package:flutter_english_course/models/parent/parentModel.dart';
import 'package:flutter_english_course/models/prof/profModel.dart';
import 'package:flutter_english_course/models/remarqueProf/remarqueProf.dart';
import 'package:flutter_english_course/repositories/banner/ParentRepository.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_english_course/controllers/ClassController.dart';


import '../../../utils/Network/networkmanager.dart';
import '../../../utils/constants/imageStrings.dart';
import '../authentication/screens/Profile/widgets/reAuthLoginForm.dart';
import '../authentication/screens/login/login.dart';
import '../models/remarqueProf/remarqueIdara.dart';
import '../repositories/banner/AuthenticationRepository.dart';
import '../utils/Loaders/AppLoaders.dart';
import '../utils/constants/sizes.dart';
import '../utils/helpers/full_screen_loader.dart';


class ParentController extends GetxController {


  static ParentController get instance => Get.find();

  final ParentLoading = false.obs;
  final imageUploading = false.obs;
  Rx<ParentModel> Parent = ParentModel.empty().obs;
  RxList<EleveModel> myeleves = <EleveModel>[].obs;
  Rx<EleveModel> selectedStudent = EleveModel.empty().obs;
  Rx<RemoteMessage> Notification = RemoteMessage().obs;
  final verifyEmail = TextEditingController();
  final verifyPassword = TextEditingController();

  final hidepassword = false.obs;
  final ParentRepositoty = Get.put(ParentRepository());
  GlobalKey<FormState> reAuthForm = GlobalKey<FormState>();
  RxBool eleveSelected = false.obs;


  void onInit() async {
    super.onInit();
    await fetchParentRecord();
  }

  Future<void> fetchParentRecord() async{
    try{
      ParentLoading.value = true;
      final Parent = await ParentRepositoty.fetchParentDetails();
      this.Parent(Parent);
      fetchEleveRecord();
    }catch(e){
      Parent(ParentModel.empty());
    }finally{
      ParentLoading.value = false;
    }
  }
  Future<void> fetchEleveRecord() async{
    try{
      ParentLoading.value = true;
      for(int i = 0 ; i< Parent.value.ListEleve.length;i++){
        final Eleve = await ParentRepositoty.fetchEleve(Parent.value.ListEleve[i]);
        myeleves.add(Eleve);
      }
    }catch(e){
      AppLoaders.warningSnackbar(title: "خلل في تحميل التلاميذ");
    }finally{
      ParentLoading.value = false;
    }
  }

  Future<void> saveParentRecord(UserCredential? userCredential) async {
    try {
      await fetchParentRecord();
      if(Parent.value.id == "id"){
        if (userCredential != null) {
          final nameParts = ProfModel.nameParts(userCredential.user!.displayName ?? '');
          final username = ProfModel.generateUserName(userCredential.user!.displayName ?? '');
          final prof = ParentModel(
              id: userCredential.user!.uid,
              prenom: nameParts[0],
              nom: nameParts.length > 1 ? nameParts.sublist(1).join(' ') : '',
              email: userCredential.user!.email ?? '',
              numero: userCredential.user!.phoneNumber ?? '',
              ListEleve: [],
              );
          await ParentRepository.instance.saveParentModel(prof);
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
          await auth.signInWithGoogle();
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
