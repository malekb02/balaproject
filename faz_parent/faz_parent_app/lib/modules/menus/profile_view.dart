import 'package:flutter/material.dart';
import 'package:flutter_english_course/controllers/EleveController.dart';
import 'package:flutter_english_course/controllers/ParentController.dart';
import 'package:flutter_english_course/cores/cores.dart';
import 'package:flutter_english_course/models/eleve/eleveModel.dart';
import 'package:flutter_english_course/models/parent/parentModel.dart';
import 'package:flutter_english_course/modules/menus/programmensuel.dart';
import 'package:flutter_english_course/modules/menus/widgets/settingsWidgets/AppPrimaryHeaderContainer.dart';
import 'package:flutter_english_course/modules/menus/widgets/settingsWidgets/AppUserProfileTile.dart';
import 'package:flutter_english_course/modules/menus/widgets/settingsWidgets/SettingsMenuTile.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';

import '../../authentication/screens/Profile/profileScreen.dart';
import '../../authentication/screens/Profile/widgets/SectionHeader.dart';
import '../../authentication/screens/login/login.dart';
import '../../authentication/screens/profilesScreen/SelectProfileScreen.dart';
import '../../components/common/appBar.dart';
import '../../models/class/classModel.dart';
import '../../models/remarqueProf/remarqueIdara.dart';
import '../../models/remarqueProf/remarqueProf.dart';
import '../../repositories/banner/AuthenticationRepository.dart';
import '../../utils/constants/colors.dart';
import '../../utils/constants/sizes.dart';
import 'Screens/inscriptionscreen.dart';

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
                  AppUserProfileTile(OnPressed: (){}),

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
                    subtitle: "الحصص الأسبوعية و اليومية...",
                    onTap: () => Get.to(() => ProgramMens()),
                  ),
                  SettingsMenuTile(
                      icon: Iconsax.info_circle,
                      title: "معلومات التلميذ",
                      subtitle: "الاسم و اللقب , المستوى الدراسي ...",
                      onTap: () => Get.to(() => ProfileScreen()),
                      ),
                  SettingsMenuTile(
                    icon: Iconsax.chart,
                    title: "التسجيلات",
                    subtitle: "الخدمات المسجلة, تاريخ التسجيل ...",
                    onTap: () => Get.to(() => Inscriptionscreen()),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomSheet: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SizedBox(
          width: double.infinity,
          height: 50,
          child: ElevatedButton(
            onPressed: () {
              EleveController.instance.selectedStudent(EleveModel.empty());
              EleveController.instance.Classes = <ClassModel>[].obs;
              EleveController.instance.selectedClass = ClassModel.empty().obs;
              EleveController.instance.profremarques = <RemarqueProfModel>[].obs;
              EleveController.instance.Idararemarques = <RemarqueIdaraModel>[].obs;
              EleveController.instance.eleveSelected = false.obs;
              ParentController.instance.selectedStudent(EleveModel.empty());
              Get.offAll(Selectprofilescreen());
            },
            style: OutlinedButton.styleFrom(
              backgroundColor: Colors.purple,
            ),
            child: Text(
              "إعادة اختيار التلميذ",
              style: GoogleFonts.readexPro(
                  textStyle: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16
                  )
              ),
            ),
          ),
        ),
      ),
    );
  }
}
