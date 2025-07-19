import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_english_course/components/common/emploiCard.dart';
import 'package:flutter_english_course/components/components.dart';
import 'package:flutter_english_course/cores/cores.dart';
import 'package:flutter_english_course/dummies/learnings_dummy.dart';
import 'package:flutter_english_course/models/learning/learning.dart';
import 'package:flutter_english_course/models/prof/profModel.dart';
import 'package:flutter_english_course/modules/menus/widgets/settingsWidgets/OurServices.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:ionicons/ionicons.dart';
import 'package:transparent_image/transparent_image.dart';

import '../../components/cards/TraveauSup.dart';
import '../../components/common/PromoSlider.dart';
import '../../components/common/appBar.dart';
import '../../controllers/EleveController.dart';
import '../../controllers/ParentController.dart';
import '../../utils/constants/colors.dart';

class HomeView extends StatefulWidget {
  static const String routeName = '/home';

  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final tabItems = <String>[
    'البرنامج',
    'خدماتنا',
  ];
  late final selectedTabNotifier = ValueNotifier<String>(tabItems.first);
  final learningsNotifier = ValueNotifier<List<Learning>>([]);

  @override
  void initState() {
    super.initState();

    loadData();

    selectedTabNotifier.addListener(() {
      loadData(
        category: selectedTabNotifier.value,
      );
    });
  }
  final DatePickerController controller = Get.put(DatePickerController());

  @override
  void dispose() {
    selectedTabNotifier.dispose();
    learningsNotifier.dispose();
    super.dispose();
  }

  Future<void> loadData({String? category}) async {
    final learnings = List<Learning>.from(
      learningsJSON.map((e) => Learning.fromJson(e)),
    );

    if (category != null) {
      learnings.removeWhere(
        (it) => !it.categories.contains(category),
      );
    } else {
      selectedTabNotifier.value = tabItems.first;
    }

    learningsNotifier.value = learnings;
  }
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: controller.selectedDate.value,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      helpText: "اختر التاريخ",
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.light(
              primary: Colors.purple,
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: Colors.purple,
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    if (pickedDate != null) {
      controller.updateDate(pickedDate);
    }
  }
  @override
  Widget build(BuildContext context) {

    final DateTime date = DateTime.now();
    return Scaffold(
      appBar: CustomAppBar(
        title: Text("اليومية"),
        showBackArrow: false,
      ),
      body: AppPullRefresh(
        onRefresh: loadData,
        child: Padding(
          padding: EdgeInsets.all(10),
          child: SingleChildScrollView(
            child: Column(
              children: [
                //news slider
                PromoSlider(),

                ///emploi du temps
                //devider
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                          onPressed:  () {
                            Future.microtask(() => _selectDate(context)); // Ensure it's deferred
                          },
                          onLongPress:  () {
                            Future.microtask(() => _selectDate(context)); // Ensure it's deferred
                          },

                          child: Obx(
                                  ()=> Text(
                            "${controller.selectedDate.value.day}/${controller.selectedDate.value.month}/${controller.selectedDate.value.year}",
                            style: GoogleFonts.readexPro(
                                textStyle: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 21)) ),
                          )),
                      Text(
                        "البرنامج اليومي",
                        style: GoogleFonts.readexPro(
                            textStyle: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 21)),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),

                Obx(()=> Emploicard(AllClasses: EleveController.instance.Classes.where((classe)=> classe.dateTime.day == controller.selectedDate.value.day && classe.dateTime.month == controller.selectedDate.value.month && classe.dateTime.year == controller.selectedDate.value.year).toList().obs,)),

               SizedBox(height: 20,),
                ///traveaux sup
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "خدمات أخرى",
                      style: GoogleFonts.readexPro(
                          textStyle: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 21)),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),

                  ],
                ),
                SizedBox(height: 20,),
                OurServices()

              ],
            ),
          ),
        ),
      ),
    );
  }
}
class DatePickerController extends GetxController {

  var selectedDate =  DateTime.now().obs; // Reactive nullable DateTime
  void updateDate(DateTime date) {
    selectedDate.value = date; // Update the selected date
  }
}