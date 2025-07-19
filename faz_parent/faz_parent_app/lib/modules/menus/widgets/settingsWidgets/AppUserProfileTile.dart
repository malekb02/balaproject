import 'package:flutter/material.dart';
import 'package:flutter_english_course/controllers/ParentController.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../components/common/RoundedImage.dart';
import '../../../../components/common/appshimmereffect.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';


class AppUserProfileTile extends StatelessWidget {
  const AppUserProfileTile({
    super.key, required this.OnPressed,
  });

  final VoidCallback OnPressed;

  @override
  Widget build(BuildContext context) {
    final controller = ParentController.instance;
    return ListTile(
      leading: RoundedImage(imageUrl:"assets/images/jpg/student.jpg" ,width: 50,height: 50,borderRadius: 90,padding: EdgeInsets.all(AppSizes.spaceBtwItems/10),isNetworkImage: false,),
      title: Obx(() {
        if(controller.ParentLoading.value){
          return AppShimmerEffect(width: 80,height: 15);
        }else{
          return Text(controller.selectedStudent.value.fullname, style: Theme
              .of(context)
              .textTheme
              .headlineSmall!
              .apply(color: Appcolors.white, fontSizeFactor: 0.8),);
        }

      }),
      subtitle: Obx(() {
        if(controller.ParentLoading.value){
          return AppShimmerEffect(width: 80,height: 15);
        }else{
          return Text(controller.Parent.value.email, style: Theme
              .of(context)
              .textTheme
              .bodyMedium!
              .apply(color: Appcolors.white, fontSizeFactor: 0.8),);
        }

      }),

    );
  }
}
