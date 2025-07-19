import 'package:flutter/material.dart';
import 'package:flutter_english_course/authentication/screens/Profile/widgets/SectionHeader.dart';
import 'package:flutter_english_course/authentication/screens/Profile/widgets/profileMenu.dart';
import 'package:flutter_english_course/controllers/AdminController.dart';
import 'package:flutter_english_course/controllers/ClassController.dart';
import 'package:flutter_english_course/models/class/classModel.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../utils/constants/imageStrings.dart';
import '../../../components/common/RoundedImage.dart';
import '../../../components/common/appBar.dart';
import '../../../components/common/appshimmereffect.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';
import '../../controllers/controllers/ServiceController.dart';


class Editclassscreen extends StatelessWidget {
  const Editclassscreen({Key? key,required this.classe}) : super(key: key);

  final ClassModel classe;
  @override
  Widget build(BuildContext context) {
    final controller = AdminController.instance;
    return  Scaffold(
        appBar: CustomAppBar(
          showBackArrow: true,
          title: Text(" تعديل${ServiceController.instance.serices.where((sv)=> sv.id == classe.service).first.nom} - ${classe.dateTime.hour}:${classe.dateTime.minute.toString().padLeft(2, '0')}"),
        ),
        body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(AppSizes.defaultspace),
              child: Column(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: Column(
                        children: [],
                      ),
                    ),
                  ]
              ),
            )
        )
    );
  }
}


