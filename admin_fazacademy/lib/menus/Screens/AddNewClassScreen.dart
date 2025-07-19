import 'package:flutter/material.dart';
import 'package:flutter_english_course/components/common/appBar.dart';
import 'package:flutter_english_course/controllers/AdminController.dart';
import 'package:flutter_english_course/controllers/ClassController.dart';
import 'package:flutter_english_course/controllers/controllers/profmodel.dart';
import 'package:flutter_english_course/models/class/classModel.dart';
import 'package:flutter_english_course/models/service/ServiceModel.dart';
import 'package:flutter_english_course/utils/constants/sizes.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:numberpicker/numberpicker.dart';

import '../../controllers/controllers/ServiceController.dart';
import '../classes_view.dart';

class AddNewClassScreen extends StatelessWidget {
  const AddNewClassScreen({super.key, required this.date});

  final DateTime date;

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    final _classNameController = TextEditingController();
    final _notesController = TextEditingController();
    ClassModel classe = ClassModel.empty();
    final PickerController classController = Get.put(PickerController());
    final TeacherController teacherController = Get.put(TeacherController());
    final ServiceInputController serviceController = Get.put(ServiceInputController());
    final StudentInputController studentController = Get.put(StudentInputController());
    RxBool isRecurring = false.obs;
    RxInt recurrenceWeeks = 1.obs;
    return Scaffold(
      appBar: CustomAppBar(
        title: Text("أضافة حصة جديدة"),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          children: [
            Expanded(
                child: ElevatedButton(
                    onPressed: () async {
                      if (teacherController.selectedTeacher.value.id.isEmpty ||
                          serviceController.selectedService.value.id.isEmpty) {
                        Get.snackbar(
                          "خطأ",
                          "من فضلك اختيار كل المعلومات المطلوبة.", 
                          backgroundColor: Colors.redAccent,
                          colorText: Colors.white,
                          snackPosition: SnackPosition.BOTTOM,
                          duration: const Duration(seconds: 3),
                        );
                        return;
                      }
                      Get.back();
                      // Add recurring classes
                      for (int i = 0; i < recurrenceWeeks.value; i++) {
                        final classDate = date.add(Duration(days: i * 7));

                        ClassModel model = ClassModel(
                          id: "",
                          listeleve: studentController.selectedStudents,
                          profID: teacherController.selectedTeacher.value.id,
                          dateTime: DateTime(
                            classDate.year,
                            classDate.month,
                            classDate.day,
                            classController.selectedTime.value.hour,
                            classController.selectedTime.value.minute,
                          ),
                          pointed: false,
                          heure: 0,
                          service: serviceController.selectedService.value.id,
                        );

                        ClassModel? newClass = await CLassController.instance.addNewClass(model);

                        if (newClass != null) {
                          AdminController.instance.MyClasses.add(newClass);
                        }
                      }

                      // Refresh calendar
                      CalendarController.instance.loadSampleClasses(AdminController.instance.MyClasses);
                      CalendarController.instance.updateWeekDays();
                      CalendarController.instance.selectDay(CalendarController.instance.selectedDay.value);


                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.purple),
                    child: Text(
                      "أضافة",
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ))),
            SizedBox(
              width: 15,
            ),
            Expanded(
                child: ElevatedButton(
                    onPressed: () {
                      Get.back();
                    },
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.black),
                    child: Text(
                      "إلغاء",
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ))),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: Form(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "${date.year}/${date.month}/${date.day}",
                    style: GoogleFonts.readexPro(
                        textStyle: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 21)),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 10,),
                  Text(
                    "اختر الساعة",
                    style: GoogleFonts.readexPro(
                        textStyle: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 15)),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Obx(() => ElevatedButton.icon(
                        onPressed: () => classController.pickTime(context),
                        icon: Icon(
                          Icons.access_time,
                          size: 25,
                          color: Colors.purple,
                        ),
                        label: Text(
                          classController.selectedTime.value.format(context),
                          style: TextStyle(fontSize: 20, color: Colors.purple),
                        ),
                      )
                  ),
                  SizedBox(height: 20,),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: Obx(() => DropdownButtonFormField<String>(
                      decoration: InputDecoration(labelText: 'اختر الأستاذ',
                        labelStyle: TextStyle(color: Colors.deepPurple), // Label color
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.deepPurple),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.deepPurple, width: 2),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        filled: true,
                        fillColor: Colors.purple.shade50, // Background color
                      ),
                      dropdownColor: Colors.white, // Dropdown menu background
                      iconEnabledColor: Colors.deepPurple,
                      value: teacherController.selectedTeacher.value.id == ""
                          ? null
                          : teacherController.selectedTeacher.value.id,
                      items: teacherController.teachers
                          .map((teacher) => DropdownMenuItem(
                        value: teacher.id,
                        child: Text(teacher.nom),
                      ))
                          .toList(),
                      onChanged: (value) {
                        if (value != null) teacherController.setTeacher(value);
                      },
                      validator: (value) => value == null || value.isEmpty
                          ? 'اختر الاستاذ'
                          : null,
                    )),
                  ),
                  SizedBox(height: AppSizes.spaceBtwinputFields,),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: Obx(() => DropdownButtonFormField<String>(
                      decoration: InputDecoration(labelText: 'اختر المادة',
                        labelStyle: TextStyle(color: Colors.deepPurple), // Label color
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.deepPurple),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.deepPurple, width: 2),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        filled: true,
                        fillColor: Colors.purple.shade50, // Background color
                      ),
                      dropdownColor: Colors.white, // Dropdown menu background
                      iconEnabledColor: Colors.deepPurple,
                      value: serviceController.selectedService.value.id == ""
                          ? null
                          : serviceController.selectedService.value.id,
                      items: serviceController.services
                          .map((teacher) => DropdownMenuItem(
                        value: teacher.id,
                        child: Text(teacher.nom),
                      ))
                          .toList(),
                      onChanged: (value) {
                        if (value != null) serviceController.setService(value);
                      },
                      validator: (value) => value == null || value.isEmpty
                          ? 'اختر الاستاذ'
                          : null,
                    )),
                  ),
                  SizedBox(height: AppSizes.spaceBtwinputFields,),
                  Text(
                    "اختر التلاميذ",
                    style: GoogleFonts.readexPro(
                        textStyle: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 20)),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: AppSizes.spaceBtwinputFields,),

                  Obx(() => Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    children: studentController.allStudents.map((student) {
                      final isSelected = studentController.selectedStudents.contains(student.id);
                      return GestureDetector(
                        onTap: () => studentController.toggleStudent(student.id),
                        child: Card(
                          color: isSelected ? Colors.purple.shade100 : Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                            side: BorderSide(
                              color: isSelected ? Colors.purple : Colors.grey.shade300,
                              width: 2,
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(12),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                CircleAvatar(
                                  backgroundColor: Colors.purple.shade200,
                                  child: Text(student.nom[0]), // Or student.avatar if you have image
                                ),
                                SizedBox(height: 8),
                                Text(student.nom, style: TextStyle(fontSize: 14)),
                              ],
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  )),

                  SizedBox(height: AppSizes.spaceBtwSections),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Text(
                          "عدد الأسابيع تتكر فيها الحصة؟",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.purple,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Center(
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          elevation: 4,
                          color: Colors.purple.shade50,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8),
                            child: Obx(() => NumberPicker(
                              value: recurrenceWeeks.value,
                              minValue: 1,
                              maxValue: 52,
                              itemWidth: 60,
                              itemHeight: 50,
                              axis: Axis.horizontal,
                              textStyle: TextStyle(fontSize: 18, color: Colors.grey),
                              selectedTextStyle: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Colors.purple,
                              ),
                              decoration: BoxDecoration(
                                border: Border(
                                  top: BorderSide(color: Colors.purple, width: 2),
                                  bottom: BorderSide(color: Colors.purple, width: 2),
                                ),
                              ),
                              onChanged: (value) => recurrenceWeeks.value = value,
                            )),
                          ),
                        ),
                      ),
                    ],
                  )


                ],
                )
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PickerController extends GetxController {
  static PickerController get instance => Get.find();
  var selectedTime = TimeOfDay.now().obs;

  void pickTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime.value,
    );
    if (picked != null && picked != selectedTime.value) {
      selectedTime.value = picked;
      selectedTime.refresh();
    }
  }
}
class TeacherController extends GetxController {
  var selectedTeacher = ProfModel.empty().obs;

  List<ProfModel> teachers = AdminController.instance.AllProfs;

  void setTeacher(String id) {
    selectedTeacher.value = teachers.where((tea) => tea.id == id).first;
  }
}
class ServiceInputController extends GetxController {
  var selectedService = ServiceModel.empty().obs;

  List<ServiceModel> services = ServiceController.instance.serices;

  void setService(String id) {
    selectedService.value = services.where((tea) => tea.id == id).first;
  }
}
class StudentInputController extends GetxController {
  var allStudents = AdminController.instance.AllStudents;

  var selectedStudents = <String>[].obs;

  void toggleStudent(String id) {
    if (selectedStudents.contains(id)) {
      selectedStudents.remove(id);
    } else {
      selectedStudents.add(id);
    }
  }
}