import 'package:flutter/material.dart';
import 'package:flutter_english_course/authentication/screens/Profile/widgets/SectionHeader.dart';
import 'package:flutter_english_course/authentication/screens/Profile/widgets/profileMenu.dart';
import 'package:flutter_english_course/controllers/AdminController.dart';
import 'package:flutter_english_course/controllers/ClassController.dart';
import 'package:flutter_english_course/menus/Screens/StudentScreen.dart';
import 'package:flutter_english_course/models/class/classModel.dart';
import 'package:flutter_english_course/utils/helpers/helper_functions.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../utils/constants/imageStrings.dart';
import '../../../components/common/RoundedImage.dart';
import '../../../components/common/appBar.dart';
import '../../../components/common/appshimmereffect.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';
import '../../controllers/controllers/ServiceController.dart';
import '../classes_view.dart';
import 'EditClassScreen.dart';


class Oneclassscreen extends StatelessWidget {
  const Oneclassscreen({Key? key,required this.classe}) : super(key: key);

  final ClassModel classe;
  @override
  Widget build(BuildContext context) {
    final controller = AdminController.instance;
    return  Scaffold(
      appBar: CustomAppBar(
        showBackArrow: true,
        actions: [
          IconButton(onPressed: (){
            Get.to(Editclassscreen(classe: classe,));
          }, icon: Icon(Iconsax.edit)),
          IconButton(onPressed: (){
            CLassController.instance.deleteClass(classe);
            CalendarController.instance.loadSampleClasses(AdminController.instance.MyClasses);
            CalendarController.instance.updateWeekDays();
            CalendarController.instance.selectDay(CalendarController.instance.selectedDay.value);
            Get.back();
          }, icon: Icon(Icons.delete_forever_outlined)),
        ],
        title: Text("${ServiceController.instance.serices.where((sv)=> sv.id == classe.service).first.nom} - ${classe.dateTime.hour}:${classe.dateTime.minute.toString().padLeft(2, '0')}"),
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
                    Text(
                      "${classe.dateTime.year}/${classe.dateTime.month}/${classe.dateTime.day} : التاريخ ",
                      style: GoogleFonts.readexPro(
                          textStyle: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 21)),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: AppSizes.spaceBtwSections,),
                    Container(
                      width: 300,
                      height: 160,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(
                            color: Colors.black,
                            width: 1,
                            style: BorderStyle.solid),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(30.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "الأستاذ",
                                  style: GoogleFonts.readexPro(
                                      textStyle: TextStyle(
                                          color: Colors.purple,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15)),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text(
                                  "${AdminController.instance.AllProfs.where((pr)=> pr.id == classe.profID).first.nom ?? ""}",
                                  style: GoogleFonts.readexPro(
                                      textStyle: TextStyle(
                                          color: Colors.black54,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20)),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),

                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "عدد التلاميذ",
                                  style: GoogleFonts.readexPro(
                                      textStyle: TextStyle(
                                          color: Colors.purple,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15)),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text(
                                  "${classe.listeleve.length}",
                                  style: GoogleFonts.readexPro(
                                      textStyle: TextStyle(
                                          color: Colors.black54,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20)),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),

                              ],
                            ),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "عدد الساعات",
                                  style: GoogleFonts.readexPro(
                                      textStyle: TextStyle(
                                          color: Colors.purple,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15)),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text(
                                  "${classe.heure.ceil()}",
                                  style: GoogleFonts.readexPro(
                                      textStyle: TextStyle(
                                          color: Colors.black54,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20)),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),

                              ],
                            ),

                          ],
                        ),
                      ),
                    ),
                  ],
          ),
        ),
            SizedBox(height: AppSizes.spaceBtwItems,),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "التلاميذ",
                      style: GoogleFonts.readexPro(
                          textStyle: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 25)),
                      maxLines: 1,
                      textAlign: TextAlign.right,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            SizedBox(height: AppSizes.spaceBtwItems,),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                border: Border.all(
                    color: Colors.black,
                    width: 0.5,
                    style: BorderStyle.solid),
              ),
              child: SizedBox(
                height: AppHelperFunctions.screenHeight()*0.5,
                child: GridView.builder(
                  padding: const EdgeInsets.all(20),
                  itemCount: classe.listeleve.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 1,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                  ),
                  itemBuilder: (context, index) {
                    final student = AdminController.instance.AllStudents.where((ele)=> ele.id == classe.listeleve[index]).first;
                    return GestureDetector(
                      onTap: ()=> Get.to(Studentscreen(student: student,selectedDay: ValueNotifier(DateTime.now()).obs,focusedDay: DateTime.now().obs,)),
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                          side: BorderSide(
                            color: Colors.grey ,
                            width: 2,
                          ),
                        ),
                        elevation: 4,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              radius: 30,
                              child: Icon(Iconsax.profile_2user,size: 25,color: Colors.black,),
                            ),
                            SizedBox(height: 5),
                            Text(student.fullname),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),

        ]
      ),
        )
      )
    );
  }
}


