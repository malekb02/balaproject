import 'package:flutter/material.dart';
import 'package:flutter_english_course/controllers/AdminController.dart';
import 'package:flutter_english_course/controllers/controllers/ServiceController.dart';
import 'package:flutter_english_course/menus/Screens/OneClassScreen.dart';
import 'package:flutter_english_course/utils/constants/colors.dart';
import 'package:iconsax/iconsax.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:get/get.dart';

import '../models/class/classModel.dart';
import 'Screens/AddNewClassScreen.dart';

class ClassesView extends StatelessWidget {
  final ValueNotifier<DateTime> _selectedDay = ValueNotifier(DateTime.now());
  late DateTime _focusedDay = DateTime.now();


  List<ClassModel> _getClassesForDay(DateTime day) {
    List<ClassModel>? cl = CalendarController.instance.classes[DateTime(day.year, day.month, day.day)];
    return  cl ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("الحصص")),
      floatingActionButton: FloatingActionButton(child: Icon(Iconsax.add),backgroundColor: Appcolors.primaryColor,onPressed: ()=>Get.to(AddNewClassScreen(date: _selectedDay.value,))),
      floatingActionButtonLocation: FloatingActionButtonLocation.startDocked,
      body: Column(
        children: [
          ValueListenableBuilder<DateTime>(
            valueListenable: _selectedDay,
            builder: (context, selectedDay, _) {
              return TableCalendar(
                firstDay: DateTime.utc(2020, 1, 1),
                lastDay: DateTime.utc(2030, 12, 31),
                focusedDay: _focusedDay,
                selectedDayPredicate: (day) => isSameDay(selectedDay, day),
                onDaySelected: (selected, focused) {
                  _selectedDay.value = selected;
                  _focusedDay = focused;
                },
                calendarStyle: CalendarStyle(
                  selectedDecoration: BoxDecoration(
                    color: Colors.deepPurple,
                    shape: BoxShape.circle,
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ValueListenableBuilder<DateTime>(
              valueListenable: _selectedDay,
              builder: (context, selectedDay, _) {
                List<ClassModel> classes = _getClassesForDay(selectedDay);

                if (classes.isEmpty) {
                  return Center(child: Text("No classes today."));
                }

                return ListView.builder(
                  itemCount: classes.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text("${ServiceController.instance.serices.where((sv)=> sv.id == classes[index].service).first.nom} - ${classes[index].dateTime.hour}:${classes[index].dateTime.minute.toString().padLeft(2, '0')}"),
                      leading: Icon(Icons.class_,color: Appcolors.primaryColor,),
                      onTap: ()=>Get.to(Oneclassscreen(classe:classes[index])),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
class CalendarController extends GetxController {
  static CalendarController get instance => Get.find();

  var focusedDay = DateTime.now().obs;
  var selectedDay = DateTime.now().obs;
  var weekDays = <DateTime>[].obs;
  var classes = <DateTime, List<ClassModel>>{}.obs;
  List<ClassModel> allClasses = []; // Store all classes here

  @override
  void onInit() {
    super.onInit();
    loadSampleClasses(AdminController.instance.MyClasses); // Replace this with real data loading later
    updateWeekDays();
  }

  void loadSampleClasses(classes) {
    allClasses = classes;

    _groupClassesByDate();
  }

  void _groupClassesByDate() {
    classes.clear();
    for (var classItem in allClasses) {
      DateTime classDate = DateTime(classItem.dateTime.year, classItem.dateTime.month, classItem.dateTime.day);

      if (!classes.containsKey(classDate)) {
        classes[classDate] = [];
      }
      classes[classDate]!.add(classItem);
    }
    classes.refresh(); // Ensure UI updates
  }

  void updateWeekDays() {
    int weekday = selectedDay.value.weekday; // 1 = Monday, 7 = Sunday
    DateTime startOfWeek = selectedDay.value.subtract(Duration(days: weekday - 1));
    weekDays.value = List.generate(7, (index) => startOfWeek.add(Duration(days: index)));
  }

  void selectDay(DateTime day) {
    selectedDay.value = day;
    focusedDay.value = day;
    updateWeekDays();
  }
}