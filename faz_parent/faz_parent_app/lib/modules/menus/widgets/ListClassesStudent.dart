import 'package:flutter/material.dart';
import 'package:flutter_english_course/components/common/emploisCardsList.dart';
import 'package:flutter_english_course/cores/cores.dart';
import 'package:flutter_english_course/models/class/classModel.dart';
import 'package:flutter_english_course/models/eleve/eleveModel.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'SelectedDateCard.dart';




class ListClassesStudent extends StatelessWidget {
  const ListClassesStudent({super.key,required this.classes, required this.student});

  final RxList<ClassModel> classes;
  final Rx<EleveModel> student;
  @override
  Widget build(BuildContext context) {
    return Obx(
          ()=> SizedBox(
        height: 100,
        width: context.screenWidth,
        child: ListView.separated(
          reverse: true,
          scrollDirection: Axis.horizontal,
          itemCount: classes.length,
          itemBuilder: (_, index) => SelectedDateCard(classes: classes[index],student: student.value,),
          separatorBuilder: (BuildContext context, int index) => SizedBox(width: 10,),),
      ),
    );
  }
}