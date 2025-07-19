import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../components/common/appBar.dart';
import '../../../controllers/controllers/UpdateEmailController.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/validators/validators.dart';


class ChangeEmailScreen extends StatelessWidget {
  const ChangeEmailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UpdateEmailController());
    return Scaffold(
      appBar: CustomAppBar(
        showBackArrow: true,
        title: Text("Change Email",
            style: Theme.of(context).textTheme.headlineSmall),
      ),
      body: Padding(
        padding: EdgeInsets.all(AppSizes.defaultspace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Please enter a valid email , you'll be asked to confirm your email after.",
              style: Theme.of(context).textTheme.labelMedium,
            ),
            SizedBox(height: AppSizes.spaceBtwSections,),

            Form(
                key: controller.updateEmailForm,
                child: Column(
                  children: [
                    TextFormField(
                      controller: controller.email,
                      validator: (value)=> AppValidator.validateEmail(value),
                      expands: false,
                      decoration: InputDecoration(labelText: "Email",prefixIcon: Icon(Iconsax.send)),
                    ),

                    SizedBox(height: AppSizes.spaceBtwSections,),

                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(onPressed: ()=> controller.updateAndConfirmEmail(),child: Text("Confirm"),),
                    )
                  ],
                )
            )
          ],
        ),
      ),
    );
  }
}
