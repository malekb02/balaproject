import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../authentication/controllers/Login/loginController.dart';
import '../../utils/constants/colors.dart';
import '../../utils/constants/imageStrings.dart';
import '../../utils/constants/sizes.dart';



class LoginSocialButtons extends StatelessWidget {
  const LoginSocialButtons({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller=Get.put(LoginController());
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
              border: Border.all(color: Appcolors.grey),
              borderRadius: BorderRadius.circular(100)),
          child: IconButton(
            onPressed: () => controller.googlSignIn(),
            icon: const Image(
                height: AppSizes.iconmd,
                width: AppSizes.iconmd,
                image: AssetImage(ImageStings.Google)
            ),
          ),
        ),
        const SizedBox(width: AppSizes.spaceBtwItems,),
        Container(
          decoration: BoxDecoration(
              border: Border.all(color: Appcolors.grey),
              borderRadius: BorderRadius.circular(100)),
          child: IconButton(
            onPressed: () {},
            icon: const Image(
                height: AppSizes.iconmd,
                width: AppSizes.iconmd,
                image: AssetImage(ImageStings.facebook)
            ),
          ),
        )
      ],
    );
  }
}