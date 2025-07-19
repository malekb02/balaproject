import 'package:flutter/material.dart';
import 'package:flutter_english_course/components/common/appBar.dart';
import 'package:flutter_english_course/controllers/AdminController.dart';
import 'package:flutter_english_course/cores/cores.dart';
import 'package:flutter_english_course/utils/constants/colors.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';

import '../utils/helpers/helper_functions.dart';
import 'Screens/AddNewStudent.dart';
import 'Screens/StudentScreen.dart';

class StudentsView extends StatelessWidget {
  static const String routeName = '/courses';

  const StudentsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: Text(
          "التلاميذ",
          style: GoogleFonts.readexPro(
            textStyle: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 21,
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniStartFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.to(AddStudentScreen()),
        backgroundColor: Appcolors.primaryColor,
        child: Icon(Iconsax.add),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 30.0, left: 30, right: 30),
        child: Column(
          children: [
            Expanded(
              child: LayoutBuilder(
                builder: (context, constraints) => GridView.builder(
                  padding: const EdgeInsets.all(20),
                  itemCount: AdminController.instance.AllStudents.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 0.7, // More height per card
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                  ),
                  itemBuilder: (context, index) {
                    final student = AdminController.instance.AllStudents[index];
                    return GestureDetector(
                      onTap: () => Get.to(
                        Studentscreen(
                          student: student,
                          selectedDay: ValueNotifier(DateTime.now()).obs,
                          focusedDay: DateTime.now().obs,
                        ),
                      ),
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                          side: const BorderSide(
                            color: Colors.grey,
                            width: 2,
                          ),
                        ),
                        elevation: 4,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              const CircleAvatar(
                                radius: 30,
                                child: Icon(Iconsax.profile_2user, size: 25, color: Colors.black),
                              ),
                              Expanded(
                                child: Center(
                                  child: Text(
                                    student.fullname,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(fontSize: 14),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
