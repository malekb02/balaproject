import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_english_course/components/common/appBar.dart';
import 'package:flutter_english_course/controllers/StudentController.dart';
import 'package:flutter_english_course/controllers/controllers/ServiceController.dart';
import 'package:flutter_english_course/models/class/classModel.dart';
import 'package:flutter_english_course/models/eleve/eleveModel.dart';
import 'package:flutter_english_course/models/eleve/parentmodel.dart';
import 'package:flutter_english_course/models/remarqueProf/remarqueIdara.dart';
import 'package:flutter_english_course/utils/constants/colors.dart';
import 'package:flutter_english_course/utils/constants/imageStrings.dart';
import 'package:flutter_english_course/utils/constants/sizes.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../controllers/AdminController.dart';
import '../../controllers/remarqueController.dart';
import '../../models/remarqueProf/remarqueProf.dart';
import '../classes_view.dart';
import '../widgets/ClassRemarqueCalendarController.dart';
import 'OneClassScreen.dart';

class Studentscreen extends StatelessWidget {
  const Studentscreen({Key? key, required this.student, required this.selectedDay, required this.focusedDay}) : super(key: key);

  final EleveModel student;
  final Rx<ValueNotifier<DateTime>> selectedDay;
  final Rx<DateTime> focusedDay;

  @override
  Widget build(BuildContext context) {
    AdminController.instance.selectedStudent(student);
    final StudentController controller = Get.put(StudentController());
    final controllerCal = Classremarquecalendarcontroller.instance;

    List<ClassModel> _getClassesForDay(DateTime day) {
      return CalendarController.instance.classes[DateTime(day.year, day.month, day.day)] ?? [];
    }

    void _showIdaraRemarkDialog(BuildContext context, ClassModel classe) {
      final TextEditingController remarkController = TextEditingController(
        text: controllerCal.remarquesIdara[classe]?.remarque ?? '',
      );

      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        builder: (BuildContext context) {
          return Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
              left: 20,
              right: 20,
              top: 20,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("ملاحظة الإدارة", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                SizedBox(height: 10),
                TextField(
                  controller: remarkController,
                  maxLines: 3,
                  decoration: InputDecoration(
                    hintText: "أدخل الملاحظة هنا",
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.purple),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.purple, width: 2),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: Text("إلغاء",style: GoogleFonts.readexPro(fontSize: 15, color: Colors.red)),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        final remark = remarkController.text.trim();
                        if (remark.isEmpty) return;

                        final model = RemarqueIdaraModel(
                          id: "",
                          eleve: student.id,
                          classe: classe.id,
                          remarque: remark,
                          timing: DateTime.now(),
                        );

                        await RemarqueController.instance.addNewRemarqueIdara(model);
                        controllerCal.onInit();
                        Navigator.of(context).pop();
                      },
                      child: Text("حفظ",style: GoogleFonts.readexPro(fontSize: 15, color: Colors.purple)),
                    ),
                  ],
                )
              ],
            ),
          );
        },
      );
    }

    void _showIdaraRemarkDialogEdite(BuildContext context, ClassModel classe, RemarqueIdaraModel? remarques) {
      final TextEditingController remarkController = TextEditingController(
        text: controllerCal.remarquesByStudent[student.id]?[classe]?.remarque ?? '',
      );

      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        builder: (BuildContext context) {
          return Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
              left: 20,
              right: 20,
              top: 20,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("تعديل ملاحظة الإدارة ", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                SizedBox(height: 10),
                TextField(
                  controller: remarkController,
                  maxLines: 3,
                  decoration: InputDecoration(
                    hintText: "أدخل الملاحظة هنا",
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.purple),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.purple, width: 2),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: Text("إلغاء",style: GoogleFonts.readexPro(fontSize: 15, color: Colors.red)),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        final remark = remarkController.text.trim();
                        if (remark.isEmpty) return;

                        // Show loading dialog
                        showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              content: Row(
                                children: [
                                  CircularProgressIndicator(color: Colors.purple),
                                  SizedBox(width: 20),
                                  Text("جاري التعديل..."),
                                ],
                              ),
                            );
                          },
                        );

                        final model = RemarqueIdaraModel(
                          id: remarques!.id,
                          eleve: remarques.eleve,
                          classe: remarques.classe,
                          remarque: remark,
                          timing: DateTime.now(),
                        );

                        await RemarqueController.instance.updateRemarque(remarques.id, model.toJson());

                        // Close loading and bottom sheet
                        Navigator.of(context).pop(); // Close loading
                        Navigator.of(context).pop(); // Close bottom sheet
                      },
                      child: Text("تعديل",style: GoogleFonts.readexPro(fontSize: 15, color: Colors.purple)),
                    ),
                  ],
                )
              ],
            ),
          );
        },
      );
    }


    String getServiceNames(List<Map<String, dynamic>> signups) {
      final allServices = ServiceController.instance.serices;
      final serviceNames = signups.map((entry) {
        final serviceId = entry["service"];
        final matchedService = allServices.firstWhereOrNull((s) => s.id == serviceId);
        return matchedService?.nom;
      }).where((name) => name != null).toList();

      return serviceNames.join("، ");
    }
    DateTime addOneMonth(DateTime date) {
      final int year = date.month == 12 ? date.year + 1 : date.year;
      final int month = date.month == 12 ? 1 : date.month + 1;
      final int day = date.day;

      // Clamp day if next month has fewer days
      final lastDayOfMonth = DateTime(year, month + 1, 0).day;
      final correctedDay = day > lastDayOfMonth ? lastDayOfMonth : day;

      return DateTime(year, month, correctedDay);
    }


    String getNextPaymentCountdown(DateTime signupDate) {
      final today = DateTime.now();
      final cleanNow = DateTime(today.year, today.month, today.day);
      final cleanSignup = DateTime(signupDate.year, signupDate.month, signupDate.day);

      final nextPaymentDate = addOneMonth(cleanSignup);
      final difference = nextPaymentDate.difference(cleanNow);

      if (difference.isNegative) {
        return "متأخر بـ ${-difference.inDays} يوم";
      } else {
        return "متبقي ${difference.inDays} يوم";
      }
    }



    String getServicePaymentStatus(List<Map<String, dynamic>> signups) {
       final allServices = ServiceController.instance.serices;


      return signups.map((entry) {
        final String? id = entry["service"];
        final dynamic rawTime = entry["dateInsc"];

        final String name = allServices.firstWhereOrNull((s) => s.id == id)?.nom ?? "غير معروف";

        if (rawTime == null) return "$name: لا يوجد تاريخ";

        DateTime? time;
        if (rawTime is Timestamp) {
          time = rawTime.toDate();
        } else if (rawTime is String) {
          try {
            time = DateTime.parse(rawTime);
          } catch (_) {}
        }

        if (time == null) return "$name: تاريخ غير صالح";

        final status = getNextPaymentCountdown(time);
        return "$name: $status";
      }).join("\n");
    }


    final Parentmodel parent  = AdminController.instance.AllParents.where((parent) => parent.hisstudents.contains(student.id)).isNotEmpty ? AdminController.instance.AllParents.where((parent) => parent.hisstudents.contains(student.id)).first : Parentmodel.empty();
    final profremarque = controllerCal.remarquesByStudent.obs;
    final idararemarque = controllerCal.remarquesIdaraByStudent.obs;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: CustomAppBar(
        showBackArrow: true,
        title: Text("${student.nom} ${student.prenom}"),
        leadinOnPressed: () {
          AdminController.instance.selectedStudent = EleveModel.empty().obs;
        },
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(AppSizes.defaultspace),
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                border: Border.all(color: Colors.white, width: 0),
              ),
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _infoRow(student.prenom, "الإسم"),
                  _infoRow(student.nom, "اللقب"),
                  _infoRow(student.niveauSco, "المستوى الدراسي"),
                  _infoRow("${getServicePaymentStatus(student.service)}", "الوقت المتبقي لإعادة التسجيل"),
                  _infoRow("${student.noteImp == ""? "لا يوجد":student.noteImp}", "ملاحظة مهمة"),
                  SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                          onPressed: (){
                            showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  content: SingleChildScrollView(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        _infoRow(parent.prenom, "الإسم"),
                                        _infoRow(parent.nom, "اللقب"),
                                        _infoRow(parent.numero, "رقم الهاتف"),
                                        _infoRow("${parent.email}", "أيميل"),
                                        const SizedBox(height: 20),
                                        ElevatedButton(
                                          onPressed: () => Get.back(),
                                          style: ElevatedButton.styleFrom(backgroundColor: Colors.purple),
                                          child: const Text("عودة", style: TextStyle(fontSize: 18, color: Colors.white)),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );

                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.purple),
                          child: Text("معلومات ولي الأمر",style: TextStyle(fontSize: 18, color: Colors.white),
                          )
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          ValueListenableBuilder<DateTime>(
            valueListenable: selectedDay.value,
            builder: (context, selected, _) {
              return TableCalendar(
                firstDay: DateTime.utc(2020, 1, 1),
                lastDay: DateTime.utc(2030, 12, 31),
                focusedDay: focusedDay.value,
                selectedDayPredicate: (day) => isSameDay(selected, day),
                onDaySelected: (selected, focused) {
                  selectedDay.value.value = selected;
                  focusedDay.value = focused;
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
          Expanded(
            child: Obx(() {


              return ValueListenableBuilder<DateTime>(
                valueListenable: selectedDay.value,
                builder: (context, selected, _) {
                  List<ClassModel> classes = _getClassesForDay(selected);
                  List<ClassModel> classesOfStudent = classes.where((cla)=> cla.listeleve.contains(student.id)).toList();
                  if (classesOfStudent.isEmpty) {
                    return Center(child: Text("لا توجد حصص في هذا اليوم."));
                  }

                  return ListView.builder(
                    itemCount: classesOfStudent.length,
                    itemBuilder: (context, index) {
                      final classItem = classesOfStudent[index];
                      final service = ServiceController.instance.serices.firstWhereOrNull((sv) => sv.id == classItem.service);
                      final serviceName = service?.nom ?? "";

                      return Obx(
                        ()=> Card(
                          margin: EdgeInsets.all(8),
                          child: ExpansionTile(
                            title: Text("  ${classItem.dateTime.hour}:${classItem.dateTime.minute.toString().padLeft(2, '0')} ⏰ 📚 المادة: $serviceName"),
                            children: [
                              if (profremarque.value[student.id]?[classItem] != null && idararemarque.value[student.id]?[classItem] != null)
                                RemarqueCard(
                                  remarque: profremarque.value[student.id]?[classItem] ?? RemarqueProfModel.empty(),
                                  remarqueIdara: idararemarque.value[student.id]?[classItem] ?? RemarqueIdaraModel.empty(),
                                ),
                              if (profremarque.value[student.id]?[classItem] != null && idararemarque.value[student.id]?[classItem] == null)
                                RemarqueCard(
                                  remarque: profremarque.value[student.id]?[classItem] ?? RemarqueProfModel.empty(),
                                  remarqueIdara:RemarqueIdaraModel.empty(),
                                ),
                              if (profremarque.value[student.id]?[classItem] == null && idararemarque.value[student.id]?[classItem] != null)
                                RemarqueCard(
                                  remarque: RemarqueProfModel.empty(),
                                  remarqueIdara: idararemarque.value[student.id]?[classItem] ?? RemarqueIdaraModel.empty(),
                                ),
                              if (DateTime.now().day == classItem.dateTime.day &&
                                  DateTime.now().month == classItem.dateTime.month &&
                                  DateTime.now().year == classItem.dateTime.year &&
                                  idararemarque.value[student.id]?[classItem] != null)
                                Row(
                                  mainAxisAlignment : MainAxisAlignment.spaceAround,
                                  children: [

                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.black,
                                        foregroundColor: Colors.white,
                                      ),
                                      onPressed: () async {
                                        // Show loading dialog
                                        showDialog(
                                          context: context,
                                          barrierDismissible: false,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              content: Row(
                                                children: [
                                                  CircularProgressIndicator(color: Colors.purple),
                                                  SizedBox(width: 20),
                                                  Text("جاري التعديل..."),
                                                ],
                                              ),
                                            );
                                          },
                                        );
                                        await RemarqueController.instance.deleteRemarque(idararemarque.value[student.id]![classItem]!);

                                        // Close loading and bottom sheet
                                        Navigator.of(context).pop(); // Close loading
                                        Navigator.of(context).pop(); // Close bottom sheet
                                      },
                                      child: Text("حذف",style: GoogleFonts.readexPro(fontSize: 15, color: Colors.white)),
                                    ),
                                    ElevatedButton(
                                      onPressed: () {
                                        _showIdaraRemarkDialogEdite(context, classItem,controllerCal.remarquesIdaraByStudent[student.id]?[classItem]);
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.purple,
                                        foregroundColor: Colors.white,
                                      ),
                                      child: const Text("تعديل الملاحظة"),
                                    ),
                                  ],
                                )
                              else if (DateTime.now().day == classItem.dateTime.day &&
                                  DateTime.now().month == classItem.dateTime.month &&
                                  DateTime.now().year == classItem.dateTime.year)
                                ElevatedButton(
                                  onPressed: () {
                                    _showIdaraRemarkDialog(context, classItem);
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.purple,
                                    foregroundColor: Colors.white,
                                  ),
                                  child: const Text("إبداء ملاحظة الإدارة"),
                                )
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _infoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Value on the left - ellipsed
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.left,
              style: GoogleFonts.readexPro(
                fontSize: 15,
                color: Colors.black54,
              ),
            ),
          ),
          SizedBox(width: 16), // consistent spacing
          // Label on the right - bold and fixed
          Expanded(
            child: Text(
              label,
              textAlign: TextAlign.right,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.readexPro(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Colors.purple,
              ),
            ),
          ),
        ],
      ),
    );
  }




}

class RemarqueCard extends StatelessWidget {
  const RemarqueCard({super.key, required this.remarque, required this.remarqueIdara});

  final RemarqueProfModel remarque;
  final RemarqueIdaraModel remarqueIdara;

  @override
  Widget build(BuildContext context) {
    var profLi = AdminController.instance.AllProfs.where((prof) => remarque.prof == prof.id);
    return Card(
      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Column(
        children: [
          profLi.isNotEmpty ? Text(
            "ملاحظات الأستاذ",
            style: TextStyle(fontWeight: FontWeight.bold),
          ) : Container(),

          profLi.isNotEmpty ? ListTile(
            leading: CircleAvatar(
              backgroundImage: AssetImage(ImageStings.men),
            ),
            title: Text(
               profLi.first.nom + " " + profLi.first.prenom,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Text("ملاحظة الدرس",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
                Text(remarque.remarque),
                SizedBox(height: 5),
                Text("ملاحظة السلوك",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16)),
                Text(remarque.remarqueSoulouk),
                SizedBox(height: 5),
                Text("${timeAgo(remarque.timestamp)}", style: TextStyle(color: Colors.grey, fontSize: 12)),
              ],
            ),
          ) :Container(),
          ListTile(
            leading: CircleAvatar(
              backgroundImage: AssetImage("assets/images/setting.png"),
            ),
            title: Text(
              "ملاحظة الإدارة",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(remarqueIdara.remarque),
                SizedBox(height: 5),
                Text("${timeAgo(remarqueIdara.timing)}", style: TextStyle(color: Colors.grey, fontSize: 12)),
              ],
            ),
          ),
        ],
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
