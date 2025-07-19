import 'package:flutter/material.dart';
import 'package:flutter_english_course/controllers/EleveController.dart';
import 'package:flutter_english_course/controllers/ParentController.dart';
import 'package:flutter_english_course/controllers/controllers/ServiceController.dart';
import 'package:flutter_english_course/modules/menus/Screens/Countdown.dart';
import 'package:get/get.dart';

import '../../../authentication/screens/Profile/widgets/profileMenu.dart';
import '../../../components/common/RoundedImage.dart';
import '../../../components/common/appBar.dart';
import '../../../components/common/appshimmereffect.dart';
import '../../../utils/constants/imageStrings.dart';
import '../../../utils/constants/sizes.dart';

class Inscriptionscreen extends StatelessWidget {
  Inscriptionscreen({Key? key}) : super(key: key);
  final EleveController controller = EleveController.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
      showBackArrow: true,
      title: Text("التسجيلات"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppSizes.defaultspace),
        child: Column(
          children: [
            SizedBox(
              width: double.infinity,
              child: Column(
                children: [
                  Obx((){
                    return controller.imageUploading.value
                        ? AppShimmerEffect(width: 90, height: 90,radius: 90,)
                        : RoundedImage(imageUrl:"assets/images/jpg/student.jpg" ,width: 100,height: 100,borderRadius: 90,padding: EdgeInsets.all(AppSizes.spaceBtwItems/10),isNetworkImage: false,);

                  }),
                ],
              ),
            ),
            SizedBox(height: AppSizes.spaceBtwItems,),

            SizedBox(height: AppSizes.spaceBtwItems,),
            Padding(
              padding: const EdgeInsets.all(AppSizes.spaceBtwItems/1.5),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("المادة", style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25,color: Colors.purple),overflow: TextOverflow.ellipsis,),
                    Text("تاريخ التسجيل", style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25,color: Colors.black),overflow: TextOverflow.ellipsis,),
                  ],
                ),
              ),
            ),

            ListView.builder(
              shrinkWrap: true,
              itemCount: controller.selectedStudent.value.service.length,
              itemBuilder: (context, index) {
                final service = controller.selectedStudent.value.service[index];
                final difference = service["dateInsc"].toDate().difference(DateTime.now());
                return Column(
                  children: [
                    ProfileMenu(title: ServiceController.instance.serices.where((sr) => sr.id == service["service"]).first.nom,value: "${service["dateInsc"].toDate().day}/${service["dateInsc"].toDate().month}/${service["dateInsc"].toDate().year}", onPressed: (){},),
                    difference.isNegative ? Text(" الوقت قد نفذ لتسديد المستحقات يرجى التواصل مع الإدارة ", style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15,color: Colors.red),overflow: TextOverflow.ellipsis,) :
                    Text(" الوقت المتبقي : ${difference.inDays} ", style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18,color: Colors.green),overflow: TextOverflow.ellipsis,),

                  ],
                );
              },
            )
          ],
        ),
      ),
    );
  }
}