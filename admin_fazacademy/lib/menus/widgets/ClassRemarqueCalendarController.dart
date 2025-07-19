import 'package:get/get.dart';

import '../../controllers/AdminController.dart';
import '../../models/class/classModel.dart';
import '../../models/eleve/eleveModel.dart';
import '../../models/remarqueProf/remarqueIdara.dart';
import '../../models/remarqueProf/remarqueProf.dart';

class Classremarquecalendarcontroller extends GetxController {
  static Classremarquecalendarcontroller get instance => Get.find();

  var focusedDay = DateTime.now().obs;
  var selectedDay = DateTime.now().obs;
  var weekDays = <DateTime>[].obs;

  var classes = <DateTime, List<ClassModel>>{}.obs;
  var remarques = <ClassModel, RemarqueProfModel>{}.obs;
  var remarquesIdara = <ClassModel, RemarqueIdaraModel>{}.obs;

  var remarquesByStudent = <String, Map<ClassModel, RemarqueProfModel>>{}.obs;
  var remarquesIdaraByStudent = <String, Map<ClassModel, RemarqueIdaraModel>>{}.obs;

  RxList allClasses = [].obs;
  RxList allremarques = [].obs;
  RxList allIdaraRemarques = [].obs;
  EleveModel student = EleveModel.empty();

  @override
  void onInit() {
    super.onInit();

    everAll([
      AdminController.instance.MyClasses,
      AdminController.instance.profRemarques,
      AdminController.instance.IdaraRemarques
    ], (_) {
      final classes = AdminController.instance.MyClasses;
      final remarques = AdminController.instance.profRemarques;
      final idaraRemarques = AdminController.instance.IdaraRemarques;

      if (classes.isNotEmpty && remarques.isNotEmpty && idaraRemarques.isNotEmpty) {
        loadSampleClasses(classes, remarques, AdminController.instance.selectedStudent, idaraRemarques);
        updateWeekDays();
      }
    });
  }

  void loadSampleClasses(classes, remarques, students, idaraRemarques) async {
    allClasses.clear();
    allremarques.clear();
    allIdaraRemarques.clear();

    allClasses.addAll(classes);
    allremarques.addAll(remarques);
    allIdaraRemarques.addAll(idaraRemarques);

    student = students.value;

    _groupClassesByDate();
  }

  void _groupClassesByDate() {
    classes.clear();
    remarques.clear();
    remarquesIdara.clear();

    remarquesByStudent.clear();
    remarquesIdaraByStudent.clear();

    for (var classItem in allClasses) {
      DateTime classDate = DateTime(classItem.dateTime.year, classItem.dateTime.month, classItem.dateTime.day);

      // Group classes by date
      if (!classes.containsKey(classDate)) {
        classes[classDate] = [];
      }
      classes[classDate]!.add(classItem);
    }

    for (var remarque in allremarques) {
      // By student
      remarquesByStudent.putIfAbsent(remarque.eleve, () => {});
      // Find the class object
      final classMatch = allClasses.firstWhereOrNull((cls) => cls.id == remarque.classe);
      if (classMatch != null) {
        remarquesByStudent[remarque.eleve]![classMatch] = remarque;
        if (remarque.eleve == student.id) {
          remarques[classMatch] = remarque;
        }
      }
    }

    for (var remarque in allIdaraRemarques) {
      // By student
      remarquesIdaraByStudent.putIfAbsent(remarque.eleve, () => {});
      // Find the class object
      final classMatch = allClasses.firstWhereOrNull((cls) => cls.id == remarque.classe);
      if (classMatch != null) {
        remarquesIdaraByStudent[remarque.eleve]![classMatch] = remarque;
        if (remarque.eleve == student.id) {
          remarquesIdara[classMatch] = remarque;
        }
      }
    }

    // Refresh for reactive UI updates
    classes.refresh();
    remarques.refresh();
    remarquesIdara.refresh();
    remarquesByStudent.refresh();
    remarquesIdaraByStudent.refresh();
  }

  void updateWeekDays() {
    int weekday = selectedDay.value.weekday;
    DateTime startOfWeek = selectedDay.value.subtract(Duration(days: weekday - 1));
    weekDays.value = List.generate(7, (index) => startOfWeek.add(Duration(days: index)));
  }

  void selectDay(DateTime day) {
    selectedDay.value = day;
    focusedDay.value = day;
    updateWeekDays();
  }
}
