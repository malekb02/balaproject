import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/device/device_utils.dart';
import '../../../controllers/onboarding/onboarding_controller.dart';

class OnboardingSmoothPage extends StatelessWidget {
  const OnboardingSmoothPage({
    super.key,
    required this.dark,
  });

  final bool dark;

  @override
  Widget build(BuildContext context) {
    final controller = OnboardingController.instace;
    return Positioned(
        bottom: AppDeviceUtils.getButtomNavigationBarHeight() + 25,
        left: AppSizes.defaultspace,
        child:
        SmoothPageIndicator(
          controller: controller.pageContoller,
          count: 3,
          onDotClicked: controller.dotNavigationClick,
          effect: ExpandingDotsEffect(activeDotColor: dark ?  Appcolors.light:Appcolors.dark,dotHeight: 6),
        ));
  }
}
