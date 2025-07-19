import 'package:flutter/material.dart';
import 'package:get/get.dart';


import '../../../repositories/banner/AuthenticationRepository.dart';
import '../../../utils/constants/imageStrings.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/helpers/helper_functions.dart';




class EmailSuccessScreen extends StatelessWidget {
  const EmailSuccessScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding:const EdgeInsets.only(
            top: AppSizes.appBarHeight*3,
            left: AppSizes.defaultspace,
            bottom: AppSizes.appBarHeight,
            right: AppSizes.defaultspace,
          ),
          child: Column(
            children: [
              Image(image: const AssetImage(ImageStings.SuccessScreen),width: AppHelperFunctions.screenWidth()*0.6,),
              const SizedBox(height: AppSizes.spaceBtwSections,),

              Text("Account Created", style: Theme.of(context).textTheme.headlineMedium,textAlign: TextAlign.center,),
              const SizedBox(height: AppSizes.spaceBtwItems,),

              Text("Congratulations your email as been verified and your account is set up",style: Theme.of(context).textTheme.labelMedium, textAlign: TextAlign.center,),
              const SizedBox(height: AppSizes.spaceBtwSections*2,),

              SizedBox(width: double.infinity, child: ElevatedButton(onPressed: ()=> AuthenticationRepository.instance.sreenRedirect(),child: const Text("Continue"),),),
              const SizedBox(height: AppSizes.spaceBtwItems,),

            ],
          ),
        ),
      ),
    );
  }
}
