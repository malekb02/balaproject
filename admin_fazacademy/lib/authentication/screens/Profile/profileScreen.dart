import 'package:flutter/material.dart';
import 'package:flutter_english_course/authentication/screens/Profile/widgets/SectionHeader.dart';
import 'package:flutter_english_course/authentication/screens/Profile/widgets/profileMenu.dart';
import 'package:flutter_english_course/controllers/AdminController.dart';
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
    final controller = AdminController.instance;
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
                          : RoundedImage(imageUrl:image ,width: 90,height: 90,borderRadius: 100,padding: EdgeInsets.all(AppSizes.spaceBtwItems/2),isNetworkImage:  false,);

                    }),
                  ],
                ),
              ),

              SizedBox(height: AppSizes.spaceBtwItems/2,),
              Divider(),
              SizedBox(height: AppSizes.spaceBtwItems,),
              
              SectionHeading(title: "Profile information",textcolor: Appcolors.black,),

              SizedBox(height: AppSizes.spaceBtwItems,),

              ProfileMenu(title: "Name",value: controller.Admin.value.fullname, onPressed: () => Get.off(ChangeName()),),
              ProfileMenu(title: "Username",value: controller.Admin.value.username, onPressed: () {},),

              SizedBox(height: AppSizes.spaceBtwItems,),
              Divider(),
              SizedBox(height: AppSizes.spaceBtwItems,),

              SectionHeading(title: "Profile information",textcolor: Appcolors.black,),

              SizedBox(height: AppSizes.spaceBtwItems,),

              ProfileMenu(title: "User ID",value: controller.Admin.value.id,icon: Iconsax.copy, onPressed: () {},),
              ProfileMenu(title: "E-mail",value: controller.Admin.value.email, onPressed: () {},),
              ProfileMenu(title: "Phone number",value: controller.Admin.value.numero, onPressed: () {},),
              ProfileMenu(title: "Gender",value: "Male", onPressed: () {},),
              ProfileMenu(title: "Date of Birth",value: "24/10/2000", onPressed: () {},),

              Divider(),
              SizedBox(height: AppSizes.spaceBtwItems,),

              Center(
                child: TextButton(
                  onPressed: ()=> controller.deletAccountWarningPopUp(),
                  child: Text("Delete Account", style: TextStyle(color: Colors.red), ),
                ),
              )

            ],
          ),
        ),

      ),
    );
  }
}


