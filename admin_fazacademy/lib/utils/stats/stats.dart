/*import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_picker/image_picker.dart';
import 'package:infinitybu/data/repositories/Authentication/authentication_repository.dart';
import 'package:infinitybu/data/repositories/user/userReposit.dart';
import 'package:infinitybu/features/authentication/screens/login/login.dart';
import 'package:infinitybu/features/personalisation/screens/Profile/widgets/reAuthLoginForm.dart';
import 'package:infinitybu/features/shop/controllers/Categories_controller.dart';
import 'package:infinitybu/features/shop/controllers/ProfuctController.dart';
import 'package:infinitybu/features/shop/models/brandModel.dart';
import 'package:infinitybu/features/shop/models/productModel.dart';
import 'package:infinitybu/utils/Loaders/AppLoaders.dart';
import 'package:infinitybu/utils/constants/sizes.dart';
import 'package:infinitybu/utils/helpers/full_screen_loader.dart';

import '../../../data/repositories/brands/bandRepository.dart';
import '../../../data/repositories/user/userModel.dart';
import '../../../utils/Network/networkmanager.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/imageStrings.dart';
import '../../../utils/helpers/AppFirebaseStorageServices.dart';
import '../../../utils/validators/validators.dart';
import '../../features/personalisation/controllers/BrandController.dart';





class AppStats extends GetxController{
  final categoryController = CategoryController.instance;
  final productController = ProductController.instance;
  final brandController = BrandController.instance;

  void onInit() async {
    await calculNumberOfProductsForBrand_featured();
    await calculNumberOfProductsForBrand_all();
    await calculNumberProductsPerCategory_featured();
    await calculNumberProductsPerCategory_all();
    await topBrandByCategoryfunction();
    super.onInit();
  }


  calculNumberOfProductsForBrand_featured() async{
    brandController.featuredBrands.forEach((brand) {

      int number = 0;
      number = productController.allProducts.where((product) => brand.name == product.brand ).length;
      brandController.brandWithNumber_featured.add([brand,number]);
    });
  }
  calculNumberOfProductsForBrand_all() async{
    brandController.featuredBrands.forEach((brand) {
      int number = 0;
      number = productController.allProducts.where((product) => brand.name == product.brand ).length;
      brandController.brandWithNumber_all.add([brand,number]);
    });
  }
  topBrandByCategoryfunction() async{
    categoryController.allCategories.forEach((category) {
      List max = [brandController.allBrands.first,productController.allProducts.where((product) => product.category == category.name && product.brand == brandController.allBrands.first.name).length];
      brandController.featuredBrands.forEach((brand) {
        int number = productController.allProducts.where((product) => product.category == category.name && product.brand == brand.name).length;
        if(number > max[1] ){
          max[0] = brand;
          max[number];
        }
      }
    );
      if(max.isNotEmpty) brandController.topBrandByCategory.add([category,max[0]]);
    });
  }
  calculNumberProductsPerCategory_featured() async{
    categoryController.featuredCategories.forEach((category) {
      int number = 0;
      number = productController.allProducts.where((product) => category.name == product.category ).length;
      categoryController.numberProductsCategory_featured.add([category,number]);
    });
  }
  calculNumberProductsPerCategory_all() async{
    categoryController.allCategories.forEach((category) {
      int number = 0;
      number = productController.allProducts.where((product) => category.name == product.category ).length;
      categoryController.numberProductsCategory_all.add([category,number]);
    });
  }

}*/