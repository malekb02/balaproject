import 'package:flutter/material.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/device/device_utils.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/helpers/helper_functions.dart';
import '../../../controllers/onboarding/onboarding_controller.dart';

class OnboardingButton extends StatelessWidget {
  const OnboardingButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final dark = AppHelperFunctions.isDarkMode(context);
    return Positioned(
      right: AppSizes.defaultspace,
      bottom: AppDeviceUtils.getButtomNavigationBarHeight(),
      child: ElevatedButton(
        onPressed: () => OnboardingController.instace.nextPage(),
        style: ElevatedButton.styleFrom(
            shape: const CircleBorder(),
            backgroundColor: dark ? Appcolors.primaryColor : Appcolors.black,
            side: const BorderSide(
              color: Colors.black
            )



        ),
        child: const Icon(Icons.arrow_forward_ios, size: 20,),
      ),
    );
  }
}
