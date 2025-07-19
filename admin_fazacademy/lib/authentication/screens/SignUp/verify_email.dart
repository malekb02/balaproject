import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/constants/imageStrings.dart';
import '../../../banner/AuthenticationRepository.dart';
import '../../../utils/helpers/helper_functions.dart';
import '../../controllers/SignUp/verify_email_contoller.dart';



class VerifyEmailScreen extends StatelessWidget {
  const VerifyEmailScreen({Key? key, this.email}) : super(key: key);
  final String? email;
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(VerifyEmailController());
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(onPressed: () => AuthenticationRepository.instance.logout(), icon:const Icon(CupertinoIcons.clear))
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(AppSizes.defaultspace),
          child: Column(
            children: [
              Image(image: const AssetImage(ImageStings.VerifyEmail),width: AppHelperFunctions.screenWidth()*0.6,),
              const SizedBox(height: AppSizes.spaceBtwSections,),

              Text("Verify Your email address!", style: Theme.of(context).textTheme.headlineMedium,textAlign: TextAlign.center,),
              const SizedBox(height: AppSizes.spaceBtwItems,),
              Text(email ?? '',style: Theme.of(context).textTheme.labelLarge, textAlign: TextAlign.center,),
              const SizedBox(height: AppSizes.spaceBtwItems,),
              Text("We have sent an email to your email account to confirm your email",style: Theme.of(context).textTheme.labelMedium, textAlign: TextAlign.center,),
              const SizedBox(height: AppSizes.spaceBtwSections,),

              //Buttons

              SizedBox(width: double.infinity, child: ElevatedButton(onPressed: () => controller.checkEmailVerificationStatus(),child: const Text("Continue"),),),
              const SizedBox(height: AppSizes.spaceBtwItems,),
              SizedBox(width: double.infinity, child: TextButton(onPressed: () => controller.sendEmailVerification(),child: const Text("Resend Email"),),),



            ],
          ),
        ),
      ),
    );
  }
}
