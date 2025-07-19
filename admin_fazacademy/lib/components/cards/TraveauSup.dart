import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_english_course/cores/cores.dart';
import 'package:flutter_english_course/utils/helpers/helper_functions.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';

import '../../controllers/TravauSupController.dart';
import '../../models/prof/adminModel.dart';
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
          height: 30,
          radius: 30,
        );
      if (controller.travaux.isEmpty) {
        return Container(
            child: Center(child: Text("Aucune Traville trouvée"))
        );
      } else {
        return SizedBox(
          height: 220, // Set an appropriate height for your card
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: controller.travaux.length,
            itemBuilder: (_, index) => SizedBox(
              width: MediaQuery.of(context).size.width, // Full screen width
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(
                        width: 2,
                        color: Colors.black,
                      ),
                    ),
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          controller.travaux[index].titre,
                          maxLines: 2,
                          textAlign: TextAlign.right,
                          style: GoogleFonts.cairo(
                            color: Appcolors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 10),
                        Text(
                          controller.travaux[index].desc,
                          maxLines: 3,
                          textAlign: TextAlign.right,
                          style: GoogleFonts.cairo(
                            color: Appcolors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),

                ],
              ),
            ),
          ),
        );

      }
    });
  }
}
