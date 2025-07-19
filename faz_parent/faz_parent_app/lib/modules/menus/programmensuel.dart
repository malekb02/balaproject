import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_english_course/controllers/EleveController.dart';
import 'package:flutter_english_course/controllers/controllers/ServiceController.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../components/common/appBar.dart';
import '../../controllers/ClassController.dart';
import '../../models/class/classModel.dart';
import '../../models/eleve/eleveModel.dart';
import '../../models/remarqueProf/remarqueIdara.dart';
import '../../models/remarqueProf/remarqueProf.dart';
import '../../utils/Loaders/AppLoaders.dart';
import '../../utils/constants/colors.dart';
import '../../utils/constants/sizes.dart';
import '../../utils/validators/validators.dart';
import 'Screens/StudentScreen.dart';
import 'home_view.dart';

class ProgramMens extends StatelessWidget {
  static const String routeName = '/profile';

  const ProgramMens({super.key});

  @override
  Widget build(BuildContext context) {

    List<String> listmonths = [
      "الأحد",
      "الإثنين",
      "الثلاثاء",
      "الأربعاء",
      "الخميس",
    ];
    bool _dayofweek (DateTime day){
      switch(day){
        case 6 : return true;
        default : return false;
      }
    }
    final houresController = TextEditingController().obs;
    GlobalKey<FormState> houresglobal = GlobalKey<FormState>();
    void _showDialog(ClassModel classes) {
      Get.defaultDialog(
        contentPadding: EdgeInsets.all(AppSizes.md),
        title: "هل تأكد تدريسك لهذه الحصة؟",
        titleStyle: GoogleFonts.readexPro(
            textStyle: TextStyle(
                color:  Colors.purple,
                fontWeight: FontWeight.bold,
                fontSize: 21)),
        titlePadding: EdgeInsets.all(AppSizes.md),
        middleText: "تأكيد حصة ",
        content: Obx(
              ()=> Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Form(
                    key: houresglobal,
                    child: Column(
                        children: [
                          TextFormField(
                            controller: houresController.value,
                            validator:  (value) => AppValidator.validateHoures(value),
                            decoration:  InputDecoration(
                              prefixIcon: Icon(Iconsax.clock,color: Colors.purple,), labelText: 'عدد الساعات',
                              labelStyle: TextStyle(color: Colors.purple,fontWeight: FontWeight.bold),
                              focusedBorder:  OutlineInputBorder().copyWith(
                                borderRadius: BorderRadius.circular(14),
                                borderSide:  BorderSide(width: 2,color: Colors.purple),
                              ),
                              enabledBorder: OutlineInputBorder().copyWith(
                                borderRadius: BorderRadius.circular(14),
                                borderSide:  BorderSide(width: 2,color: Colors.purple),
                              ),
                            ),
                          ),
                        ]
                    )

                )
              ]),
        ),
        confirm: ElevatedButton(

          onPressed: () async {
            if(houresglobal.currentState!.validate()){
              classes.pointed = true;
              classes.heure = double.parse(houresController.value.text.toString());
              CLassController.instance.editClass(classes);
            }
          },
          style: ElevatedButton.styleFrom(
              backgroundColor:Colors.purple, side: BorderSide(color: Appcolors.primaryColor)),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: AppSizes.lg),
            child: Text(
              "تأكيد",
              style: GoogleFonts.readexPro(
                  textStyle: TextStyle(
                      color:  Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 21)),
            ),
          ),
        ),
      );
    }
    Map<int, String> arabicMonths = {
      1: "جانفي",
      2: "فيفري",
      3: "مارس",
      4: "أفريل",
      5: "ماي",
      6: "جوان",
      7: "جويلية",
      8: "أوت",
      9: "سبتمبر",
      10: "أكتوبر",
      11: "نوفمبر",
      12: "ديسمبر",
    };

    String getArabicMonth(DateTime date) {
      return arabicMonths[date.month] ?? "";
    }
    return Scaffold(
      appBar: CustomAppBar(
        title: Text("البرنامج الأسبوعي",),
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Obx(() => TableCalendar(
              locale: 'ar',
              firstDay: DateTime.utc(2020, 1, 1),
              lastDay: DateTime.utc(2030, 12, 31),
              focusedDay: CalendarController.instance.focusedDay.value,
              selectedDayPredicate: (day) => isSameDay(CalendarController.instance.selectedDay.value, day),
              onDaySelected: (selectedDay, focusedDay) {
                CalendarController.instance.selectDay(selectedDay);
              },
              calendarFormat: CalendarFormat.week,
              headerVisible: true, // Keep the header visible
              calendarBuilders: CalendarBuilders(
                headerTitleBuilder: (context, day) {
                  String monthName = getArabicMonth(day);
                  return Center(
                    child: Text(
                      "$monthName ${day.year}", // Custom month name
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  );
                },
              ),
            )),
            SizedBox(height: 30,),
            Obx(() => ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: CalendarController.instance.weekDays.length,
              itemBuilder: (context, index) {
                DateTime day = CalendarController.instance.weekDays[index];
                String formattedDate = DateFormat('EEEE, MMM d','ar').format(day);
                formattedDate = formattedDate
                    .replaceAll('٠', '0')
                    .replaceAll('١', '1')
                    .replaceAll('٢', '2')
                    .replaceAll('٣', '3')
                    .replaceAll('٤', '4')
                    .replaceAll('٥', '5')
                    .replaceAll('٦', '6')
                    .replaceAll('٧', '7')
                    .replaceAll('٨', '8')
                    .replaceAll('٩', '9');
                Map<String, String> arabicMonthReplacements = {
                  "يناير": "جانفي",
                  "فبراير": "فيفري",
                  "مارس": "مارس",
                  "أبريل": "أفريل",
                  "مايو": "ماي",
                  "يونيو": "جوان",
                  "يوليو": "جويلية",
                  "أغسطس": "أوت",
                  "سبتمبر": "سبتمبر",
                  "أكتوبر": "أكتوبر",
                  "نوفمبر": "نوفمبر",
                  "ديسمبر": "ديسمبر",
                };
                arabicMonthReplacements.forEach((arabic, algerian) {
                  formattedDate = formattedDate.replaceAll(arabic, algerian);
                });

                List<ClassModel> classes = CalendarController.instance.classes[DateTime(day.year, day.month, day.day)] ?? [];

                return Card(
                  margin: EdgeInsets.all(8),
                  child: ExpansionTile(
                    title: Text(formattedDate),
                    children: classes.isNotEmpty
                        ? classes.map((classInfo) => ExpansionTile(title: Text(" 📚 المادة: ${ServiceController.instance.serices.where((srv)=> srv.id == classInfo.service).first.nom}       ⏰  ${classInfo.dateTime.hour}:${classInfo.dateTime.minute.toString().padLeft(2, '0')}"),

                        children: [
                          if(CalendarController.instance.remarques[classInfo] != null )
                            RemarquePCard(remarque: CalendarController.instance.remarques[classInfo]!),
                          if(CalendarController.instance.idararemarques[classInfo] != null )
                            RemarqueICard(remrqueIdara: CalendarController.instance.idararemarques[classInfo]!),
                          if(CalendarController.instance.idararemarques[classInfo] == null && CalendarController.instance.remarques[classInfo] == null)
                            Text("لا توجد ملاحظات")

                        ],)).toList()
                        : [ListTile(title: Text("لا توجد حصص هذا اليوم"))],
                  ),
                );
              },
            )),
          ],
        ),
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
  var remarques = <ClassModel, RemarqueProfModel>{}.obs;
  var idararemarques = <ClassModel, RemarqueIdaraModel>{}.obs;
  RxList allClasses = [].obs; // Store all classes here
  RxList profremarques = [].obs; // Store all classes here
  RxList Idararemarques = [].obs; // Store all classes here
  EleveModel student = EleveModel.empty();

  @override
  void onInit() {

  }

  // Load sample data for classes, remarks, and student.
  void loadSampleClasses(classes, idararemarques, profremarques, student) {
    allClasses.value = classes;
    this.profremarques.value = profremarques;
    Idararemarques.value = idararemarques;
    this.student = student.value;

    try {
      _groupClassesByDate();
    } catch (e, stack) {
      print("Error in _groupClassesByDate: $e");
      print(stack);
    }
  }

  // Group classes by date and link them to remarks
  void _groupClassesByDate() {
    try{
        Map<DateTime, List<ClassModel>> groupedClasses = {};

      for (var classItem in allClasses) {
        DateTime classDate = DateTime(classItem.dateTime.year, classItem.dateTime.month, classItem.dateTime.day);

        // Group classes by date
        if (!groupedClasses.containsKey(classDate)) {
          groupedClasses[classDate] = [];
        }
        groupedClasses[classDate]!.add(classItem);

        // Attach remarks for each class
        for (var remarque in profremarques) {
          if (remarque.eleve == student.id && classItem.id == remarque.classe) {
            remarques[classItem] = remarque;
          }
        }

        for (var remarque in Idararemarques) {
          if (remarque.eleve == student.id && classItem.id == remarque.classe) {
            idararemarques[classItem] = remarque;
          }
        }
      }

      // Only update the classes once the grouping is complete
      classes.assignAll(groupedClasses);
      classes.refresh();
      updateWeekDays();
    }catch (e, stack) {
      print("Error in _groupClassesByDate: $e");
      print(stack);
    }

  }

  // Update the weekdays based on the selected day
  void updateWeekDays() {
    int weekday = selectedDay.value.weekday; // 1 = Monday, 7 = Sunday
    DateTime startOfWeek = selectedDay.value.subtract(Duration(days: weekday - 1));
    weekDays.value = List.generate(7, (index) => startOfWeek.add(Duration(days: index)));
  }

  // Change selected day and update week days
  void selectDay(DateTime day) {
    selectedDay.value = day;
    focusedDay.value = day;
    updateWeekDays();
  }
}