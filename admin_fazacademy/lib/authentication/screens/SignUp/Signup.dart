import 'package:flutter/material.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/helpers/helper_functions.dart';
import '../../../components/common/LoginPageDevider.dart';
import 'Widgets/SignUpForm.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dark = AppHelperFunctions.isDarkMode(context);
    return Scaffold(
        appBar: AppBar(),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(AppSizes.defaultspace),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              //Title
              Text(
                "Let's Create your account",
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(
                height: AppSizes.spaceBtwSections,
              ),

              //Form
              SignUpForm(dark: dark),
              //Sign up button

              const SizedBox(
                height: AppSizes.spaceBtwItems,
              ),
            ]),
          ),
        ));
  }
}

