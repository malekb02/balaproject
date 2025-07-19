import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_english_course/controllers/ClassController.dart';
import 'package:flutter_english_course/controllers/StudentController.dart';
import 'package:flutter_english_course/controllers/controllers/ServiceController.dart';
import 'package:flutter_english_course/cores/cores.dart';
import 'package:flutter_english_course/models/class/classModel.dart';
import 'package:flutter_english_course/models/eleve/eleveModel.dart';
import 'package:flutter_english_course/utils/Loaders/AppLoaders.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';

import '../../../utils/constants/sizes.dart';



class SelectedDateCard extends StatelessWidget {
  const SelectedDateCard({super.key, required this.classes, required this.student});

  final ClassModel classes;
  final EleveModel student;

  @override
  Widget build(BuildContext context) {
    final houresController = TextEditingController().obs;
    GlobalKey<FormState> houresglobal = GlobalKey<FormState>();
    final StudentController controller = StudentController.instance;
    final classlist = classes.obs;
    return GestureDetector(
      onTap: () {
        StudentController.instance.selectedClass(classes);
        StudentController.instance.selectedClass.refresh();
        controller.updateRemarques(student);
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
                      "${classlist.value.dateTime.hour.toString()} : ${classlist.value.dateTime.minute.toString().padLeft(2, '0')}",
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
