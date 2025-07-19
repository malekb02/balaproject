import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/validators/validators.dart';
import '../../controllers/resetpassword/resetPasswordcontroller.dart';

class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ResetPasswordController());
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(AppSizes.defaultspace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Forget Password", style: Theme
                .of(context)
                .textTheme
                .headlineMedium,),
            const SizedBox(height: AppSizes.spaceBtwItems,),
            Text(
              "Don't worry sometimes people can forget too,enter your email and we well send you a password reset link",
              style: Theme
                  .of(context)
                  .textTheme
                  .labelMedium,),
            const SizedBox(height: AppSizes.spaceBtwItems * 2,),
            Form(
              key: controller.ResetPaswordKey,
              child: TextFormField(
                controller: controller.email,
                validator: (value) => AppValidator.validateEmail(value),
                decoration: const InputDecoration(
                  labelText: "email",
                  prefixIcon: Icon(Icons.mail_outline),
                ),
              ),
            ),


            const SizedBox(height: AppSizes.spaceBtwItems,),

            SizedBox(width: double.infinity,
                child: ElevatedButton(
                    onPressed: () => controller.resetPassword(),
                    child: const Text("Submit"))),


          ],
        ),
      ),
    );
  }
}
