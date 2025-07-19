import 'package:flutter_english_course/repositories/banner/TraveauRepo.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';


import '../../../utils/Loaders/AppLoaders.dart';
import '../models/banner/BannerModel.dart';
import '../models/travaux.dart';
import '../repositories/banner/BannerRepositoty.dart';





class TravauSupController extends GetxController{
  static TravauSupController get instance => Get.find();

  final imageSelected = false.obs;
  final imageUploading = false.obs;
  final carouselCurrentIndex = 0.obs;
  final isLoading = false.obs;
  final RxList<TravauxModel> travaux = <TravauxModel>[].obs;


  @override
  void onInit(){
    fetchTraveux();
    super.onInit();
  }
  void updatePageIndicator(index){

    carouselCurrentIndex.value = index;
  }

  /// fetch banners
  Future<void> fetchTraveux() async{
    try{
      //show loader
      isLoading.value = true;

      //fetch banners
      final TravRepo = Get.put(TraveauxRepository());
      final travaux = await TravRepo.fetchTrav();

      this.travaux.assignAll(travaux);
    }catch(e){
      AppLoaders.errorSnackbar(title: "Oops",message: "${e.toString()}  ");
    }finally{
      //remove loader
      isLoading.value = false;
      isLoading.refresh();
    }
  }
  Future<void> workdone(TravauxModel trav) async{
    try{
      //show loader
      isLoading.value = true;
      trav.done = true;
      //fetch banners
      await TraveauxRepository.instance.workdone(trav.id, trav.toJson());
      fetchTraveux();
      this.travaux.refresh();
    }catch(e){
      AppLoaders.errorSnackbar(title: "Oops",message: "${e.toString()}  ");
    }finally{
      //remove loader
      isLoading.value = false;
      isLoading.refresh();
    }
  }

}