import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/constants/textStrings.dart';
import '../../../../../utils/validators/validators.dart';
import '../../../controllers/SignUp/signUPController.dart';


class SignUpForm extends StatelessWidget {
   SignUpForm({
    super.key,
    required this.dark,
  });

  final bool dark;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignupController());
    return Form(
      key: controller.signUpForm,
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: controller.firstName,
                  validator: (value) => AppValidator.validateEmptyText("Nom", value)  ,
                  expands: false,
                  decoration: const InputDecoration(
                    labelText: "Nom",
                    prefixIcon: Icon(Icons.person_outline_outlined),
                  ),
                ),
              ),
              const SizedBox(
                width: AppSizes.spaceBtwinputFields,
              ),
              Expanded(
                child: TextFormField(
                  validator: (value) => AppValidator.validateEmptyText("Prénom", value),
                  controller: controller.lastName,
                  expands: false,
                  decoration: const InputDecoration(
                    labelText: "Prénom",
                    prefixIcon: Icon(Icons.person_outline_outlined),
                  ),
                ),
              ),
              const SizedBox(
                height: AppSizes.spaceBtwinputFields,
              ),
            ],
          ),
          const SizedBox(
            height: AppSizes.spaceBtwinputFields,
          ),
          TextFormField(
            validator: (value) => AppValidator.validateEmptyText("Nom D'utilisateur", value),
            controller: controller.username,
            expands: false,
            decoration: const InputDecoration(
              labelText: "Nom D'utilisateur",
              prefixIcon: Icon(Icons.person_search_outlined),
            ),
          ),
          const SizedBox(
            height: AppSizes.spaceBtwinputFields,
          ),
          //Email
          TextFormField(
            validator: (value) => AppValidator.validateEmail(value),
            controller: controller.email,
            decoration: const InputDecoration(
              labelText: "Email",
              prefixIcon: Icon(Icons.mail_outline),
            ),
          ),
          const SizedBox(
            height: AppSizes.spaceBtwinputFields,
          ),
          //Phone number
          TextFormField(
            validator: (value) => AppValidator.validatePhoneNumber(value),
            controller: controller.phonenumber,
            decoration: const InputDecoration(
              labelText: "Numéro de télépohone",
              prefixIcon: Icon(Icons.phone_outlined),
            ),
          ),
          const SizedBox(
            height: AppSizes.spaceBtwinputFields,
          ),
          //Password
          Obx(
           ()=> TextFormField(
              validator: (value) => AppValidator.validatePassword(value),
              controller: controller.password,
              obscureText: controller.hidePassword.value,
              decoration:  InputDecoration(
                labelText: "Password",
                prefixIcon: Icon(Icons.password),
                suffixIcon: IconButton(
                    onPressed: ()=>controller.hidePassword.value = !controller.hidePassword.value,
                    icon: Icon(controller.hidePassword.value ? Iconsax.eye_slash:Iconsax.eye)
                ),
              ),
            ),
          ),
          const SizedBox(
            height: AppSizes.spaceBtwSections,
          ),
          //terms and conditions text box
          Row(
            children: [
              SizedBox(
                  height: 24,
                  width: 24,
                  child:
                  Obx(()=> Checkbox(value: controller.checked.value, onChanged: (value)=> controller.checked.value = !controller.checked.value))),
              const SizedBox(
                width: AppSizes.spaceBtwItems,
              ),
              Text.rich(
                TextSpan(children: [
                  TextSpan(
                    text: '${AppTextStrings.iAgreeTo} ',
                    style: const TextStyle().copyWith(
                        fontSize: 10.0,
                        fontWeight: FontWeight.w600,
                        color: Colors.black),
                  ),
                  TextSpan(
                    text: '${AppTextStrings.privacy_policy} ',
                    style: const TextStyle()
                        .copyWith(
                        fontSize: 12.0,
                        fontWeight: FontWeight.w600)
                        .apply(
                      color: dark
                          ? Appcolors.white
                          : Appcolors.primaryColor,
                      decoration: TextDecoration.underline,
                      decorationColor: dark
                          ? Appcolors.white
                          : Appcolors.primaryColor,
                    ),
                  ),
                  TextSpan(
                    text: '${AppTextStrings.and} ',
                    style: const TextStyle().copyWith(
                        fontSize: 10.0,
                        fontWeight: FontWeight.w600,
                        color: Colors.black),
                  ),
                  TextSpan(
                    text: AppTextStrings.terms_of_use,
                    style: const TextStyle()
                        .copyWith(
                        fontSize: 12.0,
                        fontWeight: FontWeight.w600)
                        .apply(
                      color: dark
                          ? Appcolors.white
                          : Appcolors.primaryColor,
                      decoration: TextDecoration.underline,
                      decorationColor: dark
                          ? Appcolors.white
                          : Appcolors.primaryColor,
                    ),
                  ),
                ]),
              ),

            ],
          ),
          const SizedBox(
            height: AppSizes.spaceBtwSections,
          ),

          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => controller.signup(),
              child: const Text("Create Account"),
            ),
          ),
        ],
      ),
    );
  }
}
