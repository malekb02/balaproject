import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_english_course/controllers/EleveController.dart';
import 'package:flutter_english_course/models/eleve/eleveModel.dart';
import 'package:flutter_english_course/models/remarqueProf/remarqueIdara.dart';
import 'package:flutter_english_course/models/remarqueProf/remarqueProf.dart';
import 'package:get/get.dart';

import '../../../controllers/ParentController.dart';
import '../../../models/class/classModel.dart';


class Classremarquecalendarcontroller extends GetxController {
  static Classremarquecalendarcontroller get instance => Get.find();

  var focusedDay = DateTime.now().obs;
  var selectedDay = DateTime.now().obs;
  var weekDays = <DateTime>[].obs;
  var classes = <DateTime, List<ClassModel>>{}.obs;
  var remarques = <ClassModel,RemarqueProfModel>{}.obs;
  var idararemarques = <ClassModel,RemarqueIdaraModel>{}.obs;
  RxList allClasses = [].obs; // Store all classes here
  RxList profremarques = [].obs; // Store all classes here
  RxList Idararemarques = [].obs; // Store all classes here
  EleveModel student = EleveModel.empty();

  @override
  void onInit() {
    super.onInit();

    _loadSampleClasses(EleveController.instance.Classes,EleveController.instance.profremarques,EleveController.instance.Idararemarques,EleveController.instance.selectedStudent); // Replace this with real data loading later
    updateWeekDays();
  }

  void _loadSampleClasses(classes,idararemarques,profremarques,student) {
    allClasses.value = classes;
    profremarques.value = profremarques;
    Idararemarques.value = idararemarques;
    student  = student.value;

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
      for(var remarque in profremarques){
        if(remarque.eleve == student.id && classItem.id == remarque.classe){
          remarques[classItem] = remarque;
        }
      }
      for(var remarque in Idararemarques){
        if(remarque.eleve == student.id && classItem.id == remarque.classe){
          idararemarques[classItem] = remarque;
        }
      }
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