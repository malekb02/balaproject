import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';


import '../../../utils/Loaders/AppLoaders.dart';
import '../banner/BannerRepositoty.dart';
import '../models/banner/BannerModel.dart';





class BannerController extends GetxController{
  static BannerController get instance => Get.find();

  final imageSelected = false.obs;
  final imageUploading = false.obs;
  final carouselCurrentIndex = 0.obs;
  final isLoading = false.obs;
  final RxList<BannerModel> banners = <BannerModel>[].obs;


  @override
  void onInit(){
    banners.value = [
      BannerModel(title: "الدخول المدرسي", desc: "تم تحديد الدخول المدرسي ليكون يوم 19/09/2024", id: "", imageURL: "assets/images/jpg/news2.jpg", active: true),
      BannerModel(title: "تم تأخير كل الحصص", desc: "يوجد تأخير في الحصص لمدة أسبوع سيتم إعلامكم بالمستجدات", id: "", imageURL: "assets/images/jpg/news1.jpg", active: true),
    ];
    //fetchBanners();
    super.onInit();
  }
  void updatePageIndicator(index){

    carouselCurrentIndex.value = index;
  }

  /// fetch banners
  Future<void> fetchBanners() async{
    try{
      //show loader
      isLoading.value = true;

      //fetch banners
      final bannerRepo = Get.put(BannerRepository());
      final banners = await bannerRepo.fetchBanners();

      this.banners.assignAll(banners);
    }catch(e){
      AppLoaders.errorSnackbar(title: "Oops",message: "${e.toString()} fetchBanners ");
    }finally{
      //remove loader
      isLoading.value = false;
      isLoading.refresh();
    }
  }

  addNewBanner(String targetScreen,bool active)async{
    try{
      final image = await ImagePicker().pickImage(source: ImageSource.gallery,imageQuality:70,maxHeight: 1080,maxWidth:1920);

      if(image != null){
        imageUploading.value = true;
        final imageUrl = await BannerRepository.instance.uploadImage("News/Images/", image);
        final  banner = BannerModel(id: "",title: "",desc: "" ,imageURL: imageUrl, active: active);
        await BannerRepository.instance.addNewBanner(banner);
        fetchBanners();
        banners.refresh();
        AppLoaders.successSnackbar(title: "Congratulations",message: "You have added a new Banner!");
      }
    }catch(e){
      AppLoaders.warningSnackbar(title: "Oops",message: "${e.toString()} addNewBanner ");
    }finally{
      imageUploading.value = false;
    }
  }
  deleteBanner(BannerModel banner)async{
    try{

      await BannerRepository.instance.deleteBannerImage("Users/Images/Profile/",banner.imageURL);
      await BannerRepository.instance.removeBannerRecord(banner.id);
      fetchBanners();
      banners.refresh();
      AppLoaders.successSnackbar(title: "Congratulations",message: "You have deleted the banner!");

    }catch(e){
      AppLoaders.warningSnackbar(title: "Oops",message: e.toString());
    }
  }
  editBanner(String bannerID,String desc,String title, bool active) async{
    try{
      Map<String,dynamic> json={
        'desc': desc,
        'title' : title,
        'Active' : active,
      };
      await BannerRepository.instance.updateSingleField(bannerID, json);
      fetchBanners();
      banners.refresh();
      AppLoaders.successSnackbar(title: "Congratulations",message: "You have edited the Banner!");
    }catch(e){
      AppLoaders.warningSnackbar(title: "Oops",message: e.toString());
    }
  }
}