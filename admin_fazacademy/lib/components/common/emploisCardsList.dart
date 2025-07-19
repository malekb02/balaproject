import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_english_course/controllers/ClassController.dart';
import 'package:flutter_english_course/controllers/controllers/ServiceController.dart';
import 'package:flutter_english_course/cores/cores.dart';
import 'package:flutter_english_course/models/class/classModel.dart';
import 'package:flutter_english_course/utils/Loaders/AppLoaders.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';

import '../../utils/constants/colors.dart';
import '../../utils/constants/sizes.dart';
import '../../utils/helpers/full_screen_loader.dart';
import '../../utils/validators/validators.dart';

class EmploisCardsList extends StatelessWidget {
  const EmploisCardsList({super.key, required this.classes});

  final ClassModel classes;

  @override
  Widget build(BuildContext context) {
    final houresController = TextEditingController().obs;
    GlobalKey<FormState> houresglobal = GlobalKey<FormState>();
    void _showDialog() {
      Get.defaultDialog(
        contentPadding: EdgeInsets.all(AppSizes.md),
        title: "هل تأكد تدريسك لهذه الحصة؟",
        titleStyle: GoogleFonts.readexPro(
            textStyle: TextStyle(
                color:  Colors.purple,
                fontWeight: FontWeight.bold,
                fontSize: 21)),
        titlePadding: EdgeInsets.all(AppSizes.md),
        middleText: "تأكيد حصة ",
        content: Obx(
          ()=> Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Form(
                    key: houresglobal,
                    child: Column(
                        children: [
                          TextFormField(
                            controller: houresController.value,
                            validator:  (value) => AppValidator.validateHoures(value),
                            decoration:  InputDecoration(
                              prefixIcon: Icon(Iconsax.clock,color: Colors.purple,), labelText: 'عدد الساعات',
                              labelStyle: TextStyle(color: Colors.purple,fontWeight: FontWeight.bold),
                              focusedBorder:  OutlineInputBorder().copyWith(
                                borderRadius: BorderRadius.circular(14),
                                borderSide:  BorderSide(width: 2,color: Colors.purple),
                              ),
                              enabledBorder: OutlineInputBorder().copyWith(
                                borderRadius: BorderRadius.circular(14),
                                borderSide:  BorderSide(width: 2,color: Colors.purple),
                              ),
                            ),
                          ),
                        ]
                      )

                )
              ]),
        ),
        confirm: ElevatedButton(

          onPressed: () async {
            if(houresglobal.currentState!.validate()){
              classes.pointed = true;
              classes.heure = double.parse(houresController.value.text.toString());
              CLassController.instance.editClass(classes);
            }
          },
          style: ElevatedButton.styleFrom(
              backgroundColor:Colors.purple, side: BorderSide(color: Appcolors.primaryColor)),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: AppSizes.lg),
            child: Text(
              "تأكيد",
              style: GoogleFonts.readexPro(
                  textStyle: TextStyle(
                      color:  Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 21)),
            ),
          ),
        ),
      );
    }

    final classlist = classes.obs;
    return GestureDetector(
      onLongPress: () {
        if(!classes.pointed){
          _showDialog();
        }else{
          AppLoaders.successSnackbar(title: "غير ممكن",message:"لا يمكنكم تغيير حالة هذه الحصة من فضلكم تواصلوا مع الإدارة" );
        }
      },
      child: Obx(
        () => Padding(
          padding: EdgeInsets.symmetric(horizontal: 8),
          child: SizedBox(
              height: 200,
              width: 150,
              child: Container(
                decoration: BoxDecoration(
                    color: classlist.value.pointed
                        ? Colors.purple
                        : AppColors.white,
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(color: AppColors.black)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                    "${ServiceController.instance.serices.where((service)=> service.id == classes.service).first.nom}",
                    style: GoogleFonts.readexPro(
                        textStyle: TextStyle(
                            color: classlist.value.pointed
                                ? Colors.white
                                : Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 21)),
                  ),

                    Text(
                      "${classlist.value.dateTime.minute.toString().padLeft(2, '0')} : ${classlist.value.dateTime.hour.toString()}",
                      style: GoogleFonts.readexPro(
                          textStyle: TextStyle(
                              color: classlist.value.pointed
                                  ? Colors.white
                                  : Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 21)),
                    ),
                  ],
                ),
              )),
        ),
      ),
    );
  }
}
