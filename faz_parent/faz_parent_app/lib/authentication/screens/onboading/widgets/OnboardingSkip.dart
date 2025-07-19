import 'package:flutter/material.dart';

import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/device/device_utils.dart';
import '../../../controllers/onboarding/onboarding_controller.dart';

class OnboardingSkip extends StatelessWidget {
  const OnboardingSkip({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
        top: AppDeviceUtils.getAppBarHeight(),
        right: AppSizes.defaultspace-20,
        child: TextButton(
          onPressed: () => OnboardingController.instace.skipPage(),
          child: const Text(
            'Skip',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: Appcolors.black
            ),
          ),
        ));
  }
}
