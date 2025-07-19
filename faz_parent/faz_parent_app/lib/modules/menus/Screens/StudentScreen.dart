import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_english_course/components/common/appBar.dart';
import 'package:flutter_english_course/controllers/EleveController.dart';
import 'package:flutter_english_course/controllers/controllers/ServiceController.dart';
import 'package:flutter_english_course/models/class/classModel.dart';
import 'package:flutter_english_course/models/eleve/eleveModel.dart';
import 'package:flutter_english_course/models/remarqueProf/remarqueIdara.dart';
import 'package:flutter_english_course/modules/menus/widgets/ClassRemarqueCalendarController.dart';
import 'package:flutter_english_course/utils/constants/imageStrings.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../../controllers/ParentController.dart';
import '../../../controllers/remarqueController.dart';
import '../../../models/remarqueProf/remarqueProf.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';


class Studentscreen extends StatelessWidget {
  const Studentscreen({Key? key, required this.student}) : super(key: key);

  final EleveModel student;

  @override
  Widget build(BuildContext context) {
    final EleveController controller = Get.put(EleveController());
    final remarqueProf = TextEditingController();
    final remarqueProfsoulouk = TextEditingController();
    final Classremarquecalendarcontroller controllerCal = Get.put(Classremarquecalendarcontroller());
    RxString remarqueText = "".obs;



    final hissaRem = TextEditingController().obs;
    final souloukRem = TextEditingController().obs;
    GlobalKey<FormState> houresglobal = GlobalKey<FormState>();

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
          showBackArrow: true,
          title: Text("${student.nom} ${student.prenom}"),
          leadinOnPressed:(){
            ParentController.instance.selectedStudent = EleveModel.empty().obs;
          },
        ),
        body: SingleChildScrollView(

              child: Column(children: [
                SizedBox(
                  height: 300,
                  child: Obx(() => TableCalendar(
                    locale: 'ar',
                    firstDay: DateTime.utc(2020, 1, 1),
                    lastDay: DateTime.utc(2030, 12, 31),
                    focusedDay: controllerCal.focusedDay.value,
                    selectedDayPredicate: (day) => isSameDay(controllerCal.selectedDay.value, day),
                    onDaySelected: (selectedDay, focusedDay) {
                      controllerCal.selectDay(selectedDay);
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
                ),
                SizedBox(height: 30,),
                Obx(() => ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: controllerCal.weekDays.length,
                  itemBuilder: (context, index) {
                    DateTime day = controllerCal.weekDays[index];
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

                    List<ClassModel> classes = controllerCal.classes[DateTime(day.year, day.month, day.day)] ?? [];

                    return Card(
                      margin: EdgeInsets.all(8),
                      child: ExpansionTile(
                        title: Text(formattedDate),
                        children: classes.isNotEmpty
                            ? classes.map((classInfo) => ExpansionTile(title: Text("  ${classInfo.dateTime.hour}:${classInfo.dateTime.minute.toString().padLeft(2, '0')} ⏰ 📚 المادة: ${ServiceController.instance.serices.where((srv)=> srv.id == classInfo.service).first.nom}        "),
                          children: [
                            if(controllerCal.remarques[classInfo] != null)
                             // RemarqueCard(remarque: controllerCal.remarques[classInfo]!,remrqueIdara: ,),
                            if(DateTime.now().day == classInfo.dateTime.day && DateTime.now().month == classInfo.dateTime.month && DateTime.now().year == classInfo.dateTime.year &&  controllerCal.remarques[classInfo] != null)
                              ElevatedButton(
                                  onPressed: () {

                                  },
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.purple,
                                      foregroundColor: Colors.white
                                  ),
                                  child: const Text( "تعديل الملاحظات")
                              )
                            else if (DateTime.now().day == classInfo.dateTime.day && DateTime.now().month == classInfo.dateTime.month && DateTime.now().year == classInfo.dateTime.year)
                              ElevatedButton(
                                  onPressed: () {

                                  },
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.purple,
                                      foregroundColor: Colors.white
                                  ),
                                  child: const Text( "إبداء ملاحظات")
                              )
                          ],
                        )).toList()
                            : [ListTile(title: Text("No classes"))],
                      ),
                    );
                  },
                )),
              ]),
            ));
  }
}
class RemarquePCard extends StatelessWidget {
  const RemarquePCard({super.key, required this.remarque});

  final RemarqueProfModel remarque;
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: AssetImage(ImageStings.men),
        ),
        title: Text(
          ParentController.instance.selectedStudent.value.nom + " " + ParentController.instance.selectedStudent.value.prenom,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("ملاحظة الدرس",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
            Text(remarque.remarque ?? ""),
            SizedBox(height: 5),
            Text("ملاحظة السلوك",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16)),
            Text(remarque.remarqueSoulouk ?? ""),
            SizedBox(height: 5),
            Text(
              remarque != null ?"${timeAgo(remarque.timestamp)}" : "",
              style: TextStyle(color: Colors.grey, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}
class RemarqueICard extends StatelessWidget {
  const RemarqueICard({super.key,required this.remrqueIdara});

  final RemarqueIdaraModel remrqueIdara;
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        title: Text("ملاحظة الإدارة",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16,color: Colors.purple)),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 5),
            Text(remrqueIdara.remarque),
            SizedBox(height: 5),
          ],
        ),
      ),
    );
  }
}
String timeAgo(DateTime timestamp) {
  Duration difference = DateTime.now().difference(timestamp);

  if (difference.inMinutes < 60) {
    return "${difference.inMinutes} دقيقة مضت";
  } else if (difference.inHours < 24) {
    return "${difference.inHours} ساعة مضت";
  } else {
    return "${difference.inDays} يوم مضى";
  }
}