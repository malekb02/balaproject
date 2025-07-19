import 'package:flutter/material.dart';
import 'package:flutter_english_course/cores/cores.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../../navigation_menu.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/validators/validators.dart';
import '../../../controllers/Login/loginController.dart';
import '../../SignUp/Signup.dart';
import '../../paswword_configuration/forgetPassword.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final contoller = Get.put(LoginController());
    return Form(
      key: contoller.loginFormKey,
      child: Column(
        children: [
          TextFormField(
            controller: contoller.email,
            validator: (value) => AppValidator.validateEmail(value),
            decoration:  InputDecoration(
              prefixIcon: Icon(Icons.mail_outline), labelText: 'Email',
              labelStyle: TextStyle(color: Colors.purple,fontWeight: FontWeight.bold),
              focusedBorder:  OutlineInputBorder().copyWith(
                borderRadius: BorderRadius.circular(14),
                borderSide:  BorderSide(width: 2,color: Colors.black12),
              ),
            ),
          ),
          const SizedBox(height: AppSizes.spaceBtwinputFields),
          Obx(
            () => TextFormField(
              validator: (value) => AppValidator.validatePassword(value),
              controller: contoller.password,
              obscureText: contoller.hidepassword.value,
              decoration: InputDecoration(
                focusedBorder: const OutlineInputBorder().copyWith(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: const BorderSide(width: 2,color: Colors.black12),
                ),
                labelStyle: TextStyle(color: Colors.purple,fontWeight: FontWeight.bold),
                labelText: "Password",
                prefixIcon: Icon(Icons.password),
                suffixIcon: IconButton(
                    onPressed: () => contoller.hidepassword.value =
                        !contoller.hidepassword.value,
                    icon: Icon(contoller.hidepassword.value
                        ? Iconsax.eye_slash
                        : Iconsax.eye)),
              ),
            ),
          ),
          const SizedBox(height: AppSizes.spaceBtwinputFields / 2),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Obx(
                    ()=> Checkbox(
                        value: contoller.remeberMe.value, onChanged: (value) => contoller.remeberMe.value = !contoller.remeberMe.value),
                  ),
                  const Text("Remember Me"),
                ],
              ),
              TextButton(
                  onPressed: () => Get.to(() => const ForgetPasswordScreen()),
                  child: const Text("Forget Password",style: TextStyle(color: Colors.purple),)),
            ],
          ),
          const SizedBox(height: AppSizes.spaceBtwSections),
          SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                  onPressed: () => contoller.emailAndPasswordSignIn(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purple,
                    foregroundColor: Colors.white
                  ),
                  child: const Text("Sign In"))),

        ],
      ),
    );
  }
}

