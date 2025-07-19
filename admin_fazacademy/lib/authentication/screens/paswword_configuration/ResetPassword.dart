import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_english_course/authentication/screens/login/login.dart';
import 'package:get/get.dart';
import '../../../../utils/constants/imageStrings.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/helpers/helper_functions.dart';
import '../../controllers/resetpassword/resetPasswordcontroller.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ResetPasswordController());
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
                onPressed: () => Get.back(),
                icon: const Icon(CupertinoIcons.clear))
          ],
        ),
        body:  SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(AppSizes.defaultspace),
            child: Column(
              children: [
                Image(
                  image: const AssetImage(ImageStings.SuccessScreen),
                  width: AppHelperFunctions.screenWidth() * 0.6,
                ),
                const SizedBox(
                  height: AppSizes.spaceBtwSections,
                ),
                Text(
                  "Reset Link Sent",
                  style: Theme.of(context).textTheme.headlineMedium,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: AppSizes.spaceBtwItems,
                ),
                Text(
                  "We have sent a Reset passwod link to your email addresse check your inbox",
                  style: Theme.of(context).textTheme.labelMedium,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: AppSizes.spaceBtwSections * 2,
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => Get.offAll(LoginScreen()),
                    child: const Text("Done"),
                  ),
                ),
                const SizedBox(
                  height: AppSizes.spaceBtwItems,
                ),
                SizedBox(
                  width: double.infinity,
                  child: TextButton(
                    onPressed: () => controller.resetPassword(),
                    child: const Text("Resend email"),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
