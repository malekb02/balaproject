import 'package:flutter/material.dart';
import 'package:flutter_english_course/cores/cores.dart';
import 'package:flutter_english_course/menus/programmensuel.dart' show ProgramMens;
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';

import '../../authentication/screens/Profile/widgets/SectionHeader.dart';
import '../../authentication/screens/login/login.dart';
import '../../components/common/appBar.dart';
import '../../utils/constants/colors.dart';
import '../../utils/constants/sizes.dart';
import '../banner/AuthenticationRepository.dart';
import 'widgets/settingsWidgets/AppPrimaryHeaderContainer.dart';
import 'widgets/settingsWidgets/AppUserProfileTile.dart';
import 'widgets/settingsWidgets/SettingsMenuTile.dart';

class ProfileView extends StatelessWidget {
  static const String routeName = '/profile';

  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header
            AppPrimaryHeaderContainer(
              height: null,
              child: Column(
                children: [
                  CustomAppBar(
                    title: Text(
                      "معلوماتي",
                      style: TextStyle(fontSize: 25, color: Appcolors.white),
                    ),
                  ),

                  // User Profile Card
                 AppUserProfileTile(OnPressed: () {}/*=> Get.to(() => ProfileScreen()),*/),

                  const SizedBox(
                    height: AppSizes.spaceBtwSections,
                  )
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(AppSizes.defaultspace),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "الإعدادات",
                    style: GoogleFonts.readexPro(
                        textStyle: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 25)),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(
                    height: AppSizes.spaceBtwItems,
                  ),
                  SettingsMenuTile(
                    icon: Iconsax.calendar,
                    title: "الرنامج الأسبوعي",
                    subtitle: "الحصص الأسبوعية و اليومية",
                    onTap: ()=> Get.to(() => ProgramMens()),
                  ),
                  SettingsMenuTile(
                    icon: Iconsax.element_plus,
                    title: "الأعمال الإضافية",
                    subtitle: "الأعمال الإضافية و إعداداتها",
                    onTap: (){}// => Get.to(() => CartScreen()),
                  ),
                  SettingsMenuTile(
                    icon: Iconsax.chart,
                    title: "الإحصائيات",
                    subtitle: "إحصائيات العمل",
                    onTap: (){},
                  ),

                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(onPressed: ()
                    {
                      AuthenticationRepository.instance.logout();
                      Get.offAll(LoginScreen());
                    },

                      child: const Text("Logout",style: TextStyle(color: Colors.purple),),),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
