import 'package:flutter/material.dart';
import 'package:flutter_english_course/controllers/ParentController.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/validators/validators.dart';
import '../../../../components/common/appBar.dart';


class ReAuthLoginForm extends StatelessWidget {
  const ReAuthLoginForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = ParentController.instance;
    return Scaffold(
      appBar: CustomAppBar(
        showBackArrow: true,
        title: Text("Re-Authenticate User",
            style: Theme.of(context).textTheme.headlineSmall),
      ),
      body: Padding(
        padding: EdgeInsets.all(AppSizes.defaultspace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Use real name for easy verification, This name will appear on several pages.",
              style: Theme.of(context).textTheme.labelMedium,
            ),
            SizedBox(height: AppSizes.spaceBtwSections,),

            Form(
                key: controller.reAuthForm,
                child: Column(
                  children: [
                    TextFormField(
                      controller: controller.verifyEmail,
                      validator: (value)=> AppValidator.validateEmail(value),
                      expands: false,
                      decoration: InputDecoration(labelText: "Email",prefixIcon: Icon(Iconsax.direct_right)),
                    ),
                    SizedBox(height: AppSizes.spaceBtwinputFields,),
                    Obx(
                          () => TextFormField(
                        validator: (value) => AppValidator.validatePassword(value),
                        controller: controller.verifyPassword,
                        obscureText: controller.hidepassword.value,
                        decoration: InputDecoration(
                          labelText: "Password",
                          prefixIcon: Icon(Icons.password),
                          suffixIcon: IconButton(
                              onPressed: () => controller.hidepassword.value =
                              !controller.hidepassword.value,
                              icon: Icon(controller.hidepassword.value
                                  ? Iconsax.eye_slash
                                  : Iconsax.eye)),
                        ),
                      ),
                    ),

                    SizedBox(height: AppSizes.spaceBtwSections,),

                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(onPressed: ()=> controller.reAuthenticateUserEmailAndPassword(),child: Text("Verify"),),
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
