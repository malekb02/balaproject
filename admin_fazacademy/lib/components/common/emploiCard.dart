import 'package:flutter/material.dart';
import 'package:flutter_english_course/components/common/emploisCardsList.dart';
import 'package:flutter_english_course/cores/cores.dart';
import 'package:flutter_english_course/models/class/classModel.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';




class Emploicard extends StatelessWidget {
  const Emploicard({super.key,required this.AllClasses});

  final RxList<ClassModel> AllClasses;
  @override
  Widget build(BuildContext context) {
    return Obx(
      ()=> SizedBox(
        height: 100,
        width: context.screenWidth,
        child: ListView.separated(
            reverse: true,
            scrollDirection: Axis.horizontal,
            itemCount: AllClasses.length,
            itemBuilder: (_, index) => EmploisCardsList(classes: AllClasses[index]),
          separatorBuilder: (BuildContext context, int index) => SizedBox(width: 10,),),
      ),
    );
  }
}
