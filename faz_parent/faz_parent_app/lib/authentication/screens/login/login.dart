import 'package:flutter/material.dart';
import '../../../components/common/LoginPageDevider.dart';
import '../../../components/common/SocialButtons.dart';
import '../../../utils/constants/sizes.dart';
import 'Widgets/LoginForm.dart';
import 'Widgets/LoginHeader.dart';
class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return const Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.only(
          top: AppSizes.appBarHeight,
          left: AppSizes.defaultspace,
          bottom: AppSizes.defaultspace,
          right: AppSizes.defaultspace,
        ),
        child: Column(
          children: [
            LoginHeader(),
            SizedBox(height: AppSizes.xl),
            LoginForm(),
            // Devider
            SizedBox(
              height: AppSizes.spaceBtwItems,
            ),



          ],
        ),
      ),
    );
  }
}




