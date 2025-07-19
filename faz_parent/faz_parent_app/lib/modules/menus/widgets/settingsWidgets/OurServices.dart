import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_english_course/cores/cores.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../components/common/AppCircularContainer.dart';
import '../../../../components/common/RoundedImage.dart';
import '../../../../components/common/appshimmereffect.dart';
import '../../../../controllers/controllers/ServiceController.dart';
import '../../../../models/prof/profModel.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/device/device_utils.dart';

class OurServices extends StatelessWidget {
  const OurServices({super.key, this.title, this.sub});

  final title;
  final sub;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ServiceController());
    return Obx(() {
      if (controller.isLoading.value)
        return AppShimmerEffect(
          width: double.infinity,
          height: 190,
          radius: 30,
        );
      if (controller.serices.isEmpty) {
        return Container(
            height: 300, child: Center(child: Text("لا توجد خدمات للعرض")));
      } else {
        return Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SizedBox(
                height: 300,
                child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: ServiceController.instance.serices.length,
                    itemBuilder: (context, index) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Container(
                            height: 200,
                            width: 200,
                            decoration: BoxDecoration(
                                color: Color(0xFFCF687D),
                                borderRadius: BorderRadius.circular(30)),
                            child: Column(
                              children: [
                                RoundedImage(
                                    imageUrl: "assets/images/png/Rectangle 18dz.png",
                                    padding: EdgeInsets.only(right: 10, left: 10),
                                    width: AppDeviceUtils.getScreenWidth() * 0.99,
                                    borderRadius: 20,
                                    fit: BoxFit.cover,
                                    isNetworkImage: false,
                                    onpressed:
                                        () {} //=> Get.toNamed(banner.targetScreen),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: Row(
                              mainAxisAlignment : MainAxisAlignment.start,
                              children: [
                                Column(
                                  mainAxisSize : MainAxisSize.min,
                                  children: [
                                    Text(
                                      ServiceController.instance.serices[index].nom,
                                      maxLines: 2,
                                      style: GoogleFonts.cairo(
                                          color: Appcolors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 30),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    Text(
                                      ServiceController.instance.serices[index].niveau,
                                      maxLines: 3,
                                      style: GoogleFonts.cairo(
                                        color: Appcolors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    }),
              ),

            ],
          ),
        );
      }
    });
  }
}
