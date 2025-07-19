import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_english_course/controllers/AdminController.dart';
import 'package:flutter_english_course/models/prof/adminModel.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/device/device_utils.dart';
import '../../controllers/BannerController.dart';
import '../../utils/constants/sizes.dart';
import 'AppCircularContainer.dart';
import 'RoundedImage.dart';
import 'appshimmereffect.dart';
import 'circularIcon.dart';

class PromoSlider extends StatelessWidget {
  const PromoSlider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(BannerController());
    return Obx(() {
      if (controller.isLoading.value)
        return AppShimmerEffect(
          width: double.infinity,
          height: 190,
          radius: 30,
        );
      if (controller.banners.isEmpty) {
        return Container(
            height: 300,
            child: Center(child: Text("Aucune donnée trouvée"))
        );
      } else {
        return Column(
          children: [
            CarouselSlider(
              options: CarouselOptions(
                height: 300,
                viewportFraction: 1,
                onPageChanged: (index, _) =>
                    controller.updatePageIndicator(index),
              ),
              items: controller.banners
                  .map((banner) => Stack(children: [
                  RoundedImage(
                      imageUrl: banner.imageURL,
                      padding: EdgeInsets.only(right: 10,left: 10),
                      width: AppDeviceUtils.getScreenWidth()*0.99,
                      borderRadius: 20,
                      height: 300,
                      isNetworkImage: false,
                      onpressed: () {}//=> Get.toNamed(banner.targetScreen),
                  ),
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 10,left: 10),
                        child: Container(
                          height: 150, // Adjust height as needed
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20),bottomRight: Radius.circular(20)),
                            gradient: LinearGradient(
                              colors: [
                                Colors.purple.withOpacity(0.8),
                                Colors.purple.withOpacity(0),
                              ],
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 30,
                      right: 30,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            SizedBox(width :AppDeviceUtils.getScreenWidth()*0.7, child: Text(banner.title,maxLines: 2,textAlign: TextAlign.right,style: GoogleFonts.cairo(color: Appcolors.white,fontWeight:FontWeight.bold,fontSize: 25 ),overflow: TextOverflow.ellipsis,)),
                            SizedBox(height: 10,),
                            SizedBox(width :AppDeviceUtils.getScreenWidth()*0.7,child: Text(banner.desc,maxLines: 3,textAlign: TextAlign.right,style: GoogleFonts.cairo(color: Appcolors.white,fontWeight:FontWeight.bold,fontSize: 15,),overflow: TextOverflow.ellipsis,)),
                          ],
                        ),
                      ),
                    ),
                if(AdminModel.isAdmin.isTrue)
                  Positioned(
                    top: 30,
                    right: 30,
                    child: Column(
                      children: [
                        CircularIcon(
                          icon: Iconsax.add,
                          backgroundcolor: Appcolors.primaryColor,
                          color: Appcolors.white,
                          height: 40,
                          width: 40,
                          size: AppSizes.md,
                          onPressed: ()=> controller.addNewBanner("/store", true),
                        ),
                        SizedBox(height: 10,),
                        CircularIcon(
                          icon: Iconsax.folder_cross,
                          backgroundcolor: Appcolors.primaryColor,
                          color: Appcolors.white,
                          height: 40,
                          width: 40,
                          size: AppSizes.md,
                          onPressed: ()=> controller.deleteBanner(banner),

                        ),

                      ],
                    ),
                  )
                else Container()
                ]),
              ).toList(),
            ),
            const SizedBox(height: AppSizes.spaceBtwItems,),

            Center(
              child: Obx(
                    () => Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    for (int i = 0; i < controller.banners.length; i++)
                      AppCircularContainer(
                        width: 20,
                        height: 4,
                        background: controller.carouselCurrentIndex.value == i
                            ? Appcolors.primaryColor
                            : Appcolors.grey,
                        margin: const EdgeInsets.only(right: 10),
                      ),
                  ],
                ),
              ),
            )
          ],
        );
      }
    });
  }
}
