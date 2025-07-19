import 'package:flutter_english_course/models/service/ServiceModel.dart';
import 'package:flutter_english_course/repositories/banner/ServiceRepository.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';


import '../../../utils/Loaders/AppLoaders.dart';






class ServiceController extends GetxController{
  static ServiceController get instance => Get.find();

  final imageSelected = false.obs;
  final imageUploading = false.obs;
  final carouselCurrentIndex = 0.obs;
  final isLoading = false.obs;
  final RxList<ServiceModel> serices = <ServiceModel>[].obs;


  @override
  void onInit(){
    fetchServices();
    super.onInit();
  }
  void updatePageIndicator(index){

    carouselCurrentIndex.value = index;
  }

  /// fetch banners
  Future<void> fetchServices() async{
    try{
      //show loader
      isLoading.value = true;

      //fetch banners
      final serviceRep = Get.put(ServiceRepository());
      final services = await serviceRep.fetchServices();

      this.serices.assignAll(services);
    }catch(e){
      AppLoaders.errorSnackbar(title: "Oops",message: "${e.toString()} fetch services ");
    }finally{
      //remove loader
      isLoading.value = false;
      isLoading.refresh();
    }
  }
}