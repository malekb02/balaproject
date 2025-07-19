import 'package:flutter/material.dart';
import 'package:flutter_english_course/controllers/controllers/ServiceController.dart';
import 'package:flutter_english_course/controllers/AdminController.dart';
import 'package:flutter_english_course/cores/cores.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../authentication/screens/Profile/widgets/SectionHeader.dart';
import '../../authentication/screens/login/login.dart';
import '../../components/common/appBar.dart';
import '../../components/common/emploiCard.dart';
import '../../components/common/emploisCardsList.dart';
import '../../controllers/ClassController.dart';
import '../../models/class/classModel.dart';
import '../../utils/Loaders/AppLoaders.dart';
import '../../utils/constants/colors.dart';
import '../../utils/constants/sizes.dart';
import '../../utils/validators/validators.dart';
import 'home_view.dart';

class ProgramMens extends StatelessWidget {
  static const String routeName = '/profile';

  const ProgramMens({super.key});

  @override
  Widget build(BuildContext context) {
    final CalendarController controller = Get.put(CalendarController());

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
    /*
    Future<void> _selectDate(BuildContext context) async {
      final DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: controller.selectedDate.value ?? DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2100),
        helpText: "اختر التاريخ",
        builder: (BuildContext context, Widget? child) {
          return Theme(
            data: ThemeData.light().copyWith(
              colorScheme: ColorScheme.light(
                primary: Colors.purple, // Header background color
                onPrimary: Colors.white, // Header text color
                onSurface: Colors.black, // Body text color
              ),
              textButtonTheme: TextButtonThemeData(
                style: TextButton.styleFrom(
                  foregroundColor: Colors.purple, // Button text color
                ),
              ),
            ),
            child: child!,
          );
        },
      );
      if (pickedDate != null) {
        controller.updateDate(pickedDate); // Update the date in the controller
      }
    }*/
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
           /* Obx(
              ()=> TextButton(
                  onPressed: () =>_selectDate(context),
                  onLongPress: ()=>_selectDate(context),
                  child: TextButton(
                    onPressed: () {},
                    child: Text(
                      "${controller.selectedDate.value.day}/${controller.selectedDate.value.month}/${controller.selectedDate.value.year}",
                      style: GoogleFonts.readexPro(
                          textStyle: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 21)),
                    ),
                  )),
            ),*/
            Obx(() => TableCalendar(
              locale: 'ar',
              firstDay: DateTime.utc(2020, 1, 1),
              lastDay: DateTime.utc(2030, 12, 31),
              focusedDay: controller.focusedDay.value,
              selectedDayPredicate: (day) => isSameDay(controller.selectedDay.value, day),
              onDaySelected: (selectedDay, focusedDay) {
                controller.selectDay(selectedDay);
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
              itemCount: controller.weekDays.length,
              itemBuilder: (context, index) {
                DateTime day = controller.weekDays[index];
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

                List<ClassModel> classes = controller.classes[DateTime(day.year, day.month, day.day)] ?? [];

                return Card(
                  margin: EdgeInsets.all(8),
                  child: ExpansionTile(
                    title: Text(formattedDate),
                    children: classes.isNotEmpty
                        ? classes.map((classInfo) => ListTile(title: Text(" 📚 المادة: ${ServiceController.instance.serices.where((srv)=> srv.id == classInfo.service).first.nom}       ⏰  ${classInfo.dateTime.hour}:${classInfo.dateTime.minute.toString().padLeft(2, '0')}"),onLongPress: () {
                      if(!classInfo.pointed){
                        _showDialog(classInfo);
                      }else{
                        AppLoaders.successSnackbar(title: "غير ممكن",message:"لا يمكنكم تغيير حالة هذه الحصة من فضلكم تواصلوا مع الإدارة" );
                      }
                    },)).toList()
                        : [ListTile(title: Text("No classes"))],
                  ),
                );
              },
            )),
          /*ListView.separated(
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            itemCount:listmonths.length,
            itemBuilder: (_, index) => Column(
              children: [
                Text(
                  listmonths[index],
                  style: GoogleFonts.readexPro(
                      textStyle: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 21
                      )
                  ),
                  maxLines: 1,
                  textAlign: TextAlign.end,
                  overflow: TextOverflow.ellipsis,
                ),
                //Obx(()=> Emploicard(AllClasses: ProfController.instance.MyClasses.where((classe) =>   classe.dateTime.day == (controller.selectedDate.value.day + index) && classe.dateTime.day == controller.selectedDate.value.day && classe.dateTime.month == controller.selectedDate.value.month && classe.dateTime.year == controller.selectedDate.value.year ).toList().obs,)),
              ],
            ),
            separatorBuilder: (BuildContext context, int index) => SizedBox(width: 10,),),*/
          ],
        ),
      ),
    );
  }
}
class CalendarController extends GetxController {
  var focusedDay = DateTime.now().obs;
  var selectedDay = DateTime.now().obs;
  var weekDays = <DateTime>[].obs;
  var classes = <DateTime, List<ClassModel>>{}.obs;
  List<ClassModel> allClasses = []; // Store all classes here

  @override
  void onInit() {
    super.onInit();
    _loadSampleClasses(AdminController.instance.MyClasses); // Replace this with real data loading later
    updateWeekDays();
  }

  void _loadSampleClasses(classes) {
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