import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_english_course/cores/cores.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';

import '../../controllers/TravauSupController.dart';
import '../../models/prof/profModel.dart';
import '../../utils/constants/colors.dart';
import '../../utils/constants/sizes.dart';
import '../../utils/device/device_utils.dart';
import '../common/AppCircularContainer.dart';
import '../common/RoundedImage.dart';
import '../common/appshimmereffect.dart';
import '../common/circularIcon.dart';




class TraveauSupCard extends StatelessWidget {
  const TraveauSupCard({super.key, this.title, this.sub});

  final title;
  final sub;
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(TravauSupController());
    return Obx(() {
      if (controller.isLoading.value)
        return AppShimmerEffect(
          width: double.infinity,
          height: 190,
          radius: 30,
        );
      if (controller.travaux.isEmpty) {
        return Container(
            height: 300,
            child: Center(child: Text("Aucune Traville trouvée"))
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
              items: controller.travaux
                  .map((trav) => Stack(children: [
                RoundedImage(
                    imageUrl: "assets/images/board.png",
                    padding: EdgeInsets.only(right: 10,left: 10),
                    width: AppDeviceUtils.getScreenWidth()*0.99,
                    borderRadius: 20,
                    height: 300,
                    fit: BoxFit.fill,
                    isNetworkImage: false,
                    onpressed: () {}//=> Get.toNamed(banner.targetScreen),
                ),

                Positioned(
                  top: 20,
                  right: 30,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        SizedBox(width :AppDeviceUtils.getScreenWidth()*0.7, child: Text(trav.titre,maxLines: 2,textAlign: TextAlign.right,style: GoogleFonts.cairo(color: Appcolors.white,fontWeight:FontWeight.bold,fontSize: 25 ),overflow: TextOverflow.ellipsis,)),
                        SizedBox(height: 10,),
                        SizedBox(width :AppDeviceUtils.getScreenWidth()*0.7,child: Text(trav.desc,maxLines: 3,textAlign: TextAlign.right,style: GoogleFonts.cairo(color: Appcolors.white,fontWeight:FontWeight.bold,fontSize: 15,),overflow: TextOverflow.ellipsis,)),
                      ],
                    ),
                  ),
                ),
                if(ProfModel.isEditeMode.isTrue)
                  Positioned(
                    top: 30,
                    right: 30,
                    child: Column(
                      children: [

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
                    for (int i = 0; i < controller.travaux.length; i++)
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
