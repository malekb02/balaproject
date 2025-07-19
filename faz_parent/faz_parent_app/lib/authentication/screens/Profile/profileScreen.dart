import 'package:flutter/material.dart';
import 'package:flutter_english_course/authentication/screens/Profile/widgets/SectionHeader.dart';
import 'package:flutter_english_course/authentication/screens/Profile/widgets/profileMenu.dart';
import 'package:flutter_english_course/controllers/ParentController.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../utils/constants/imageStrings.dart';
import '../../../components/common/RoundedImage.dart';
import '../../../components/common/appBar.dart';
import '../../../components/common/appshimmereffect.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';
import 'changeNameScreen.dart';


class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = ParentController.instance;
    return  Scaffold(
      appBar: CustomAppBar(
        showBackArrow: true,
        title: Text("Profile"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(AppSizes.defaultspace),
          child: Column(
            children: [
              SizedBox(
                width: double.infinity,
                child: Column(
                  children: [
                    Obx((){
                      final image =  ImageStings.lightAppLogo;

                      return controller.imageUploading.value
                          ? AppShimmerEffect(width: 90, height: 90,radius: 90,)
                          : RoundedImage(imageUrl:"assets/images/jpg/student.jpg" ,width: 100,height: 100,borderRadius: 90,padding: EdgeInsets.all(AppSizes.spaceBtwItems/10),isNetworkImage: false,);

                    }),
                  ],
                ),
              ),

              SizedBox(height: AppSizes.spaceBtwItems,),

              SizedBox(height: AppSizes.spaceBtwItems,),
              
              SectionHeading(title: "معلومات التلميذ",textcolor: Appcolors.black,),
              Divider(endIndent: 300,),
              SizedBox(height: AppSizes.spaceBtwItems,),

              ProfileMenu(title: "الاسم",value: controller.selectedStudent.value.nom, onPressed: (){},),
              ProfileMenu(title: "اللقب",value: controller.selectedStudent.value.prenom, onPressed: () {},),
              ProfileMenu(title: "المستوى الدراسي",value: controller.selectedStudent.value.niveauSco, onPressed: () {},),
              ProfileMenu(title: "الجنس",value: "Male", onPressed: () {},),
              ProfileMenu(title: "تاريخ الميلاد",value: "${controller.selectedStudent.value.dateNes.day}/${controller.selectedStudent.value.dateNes.month}/${controller.selectedStudent.value.dateNes.year}", onPressed: () {},),

              SizedBox(height: AppSizes.spaceBtwItems,),

              SizedBox(height: AppSizes.spaceBtwItems,),

              SectionHeading(title: "معلومات التسجيل",textcolor: Appcolors.black,),
              Divider(endIndent: 300),
              SizedBox(height: AppSizes.spaceBtwItems,),

              ProfileMenu(title: "الإيميل",value: controller.selectedStudent.value.email, onPressed: () {},),

              SizedBox(height: AppSizes.spaceBtwItems,),



            ],
          ),
        ),

      ),
    );
  }
}


