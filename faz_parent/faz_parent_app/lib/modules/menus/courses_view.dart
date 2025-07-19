import 'package:flutter/material.dart';
import 'package:flutter_english_course/components/common/appBar.dart';
import 'package:flutter_english_course/components/components.dart';
import 'package:flutter_english_course/controllers/ParentController.dart';
import 'package:flutter_english_course/cores/cores.dart';
import 'package:flutter_english_course/dummies/categories_dummy.dart';
import 'package:flutter_english_course/dummies/video_courses_dummy.dart';
import 'package:flutter_english_course/modules/menus/Screens/StudentScreen.dart';
import 'package:flutter_english_course/modules/menus/programmensuel.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';

import 'widgets/SearchContainer.dart';

class CoursesView extends StatefulWidget {
  static const String routeName = '/courses';

  const CoursesView({super.key});

  @override
  State<CoursesView> createState() => _CoursesViewState();
}

class _CoursesViewState extends State<CoursesView> {


  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: Text("البرنامج",style: GoogleFonts.readexPro(
            textStyle: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 21)),),
      ),
        body: Column(
          children: [

          ],
        ),
    );
  }
}

