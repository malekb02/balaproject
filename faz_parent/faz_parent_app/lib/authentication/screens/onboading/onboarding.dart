import 'package:flutter/material.dart';
import 'package:flutter_english_course/authentication/screens/onboading/widgets/OnboardingCirculerButton.dart';
import 'package:flutter_english_course/authentication/screens/onboading/widgets/OnboardingPage.dart';
import 'package:flutter_english_course/authentication/screens/onboading/widgets/OnboardingSkip.dart';
import 'package:flutter_english_course/authentication/screens/onboading/widgets/SmoothPage.dart';
import 'package:get/get.dart';
import '../../../utils/constants/imageStrings.dart';
import '../../../utils/constants/textStrings.dart';
import '../../../utils/helpers/helper_functions.dart';
import '../../controllers/onboarding/onboarding_controller.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dark= AppHelperFunctions.isDarkMode(context);
    final controller = Get.put(OnboardingController());
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: controller.pageContoller,
            onPageChanged: controller.updatePageIndicator,
            children: const [
              Onboarding(
                image: ImageStings.Onboarding1,
                title: AppTextStrings.onboardingTitle1,
                subTitle: AppTextStrings.onboardingSubTitle1,
              ),
              Onboarding(
                image: ImageStings.Onboarding2,
                title: AppTextStrings.onboardingTitle2,
                subTitle: AppTextStrings.onboardingSubTitle2,
              ),
              Onboarding(
                image: ImageStings.Onboarding3,
                title: AppTextStrings.onboardingTitle3,
                subTitle: AppTextStrings.onboardingSubTitle3,
              ),
            ],
          ),
          const OnboardingSkip(),
          OnboardingSmoothPage(dark: dark),
          const OnboardingButton(),
        ],
      ),
    );
  }
}



