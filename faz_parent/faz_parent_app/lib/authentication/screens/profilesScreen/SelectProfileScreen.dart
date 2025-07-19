import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_english_course/components/common/appBar.dart';
import 'package:flutter_english_course/controllers/EleveController.dart';
import 'package:flutter_english_course/controllers/controllers/ServiceController.dart';
import 'package:flutter_english_course/models/class/classModel.dart';
import 'package:flutter_english_course/models/eleve/eleveModel.dart';
import 'package:flutter_english_course/models/parent/parentModel.dart';
import 'package:flutter_english_course/modules/menus/home_view.dart';
import 'package:flutter_english_course/modules/menus/widgets/ClassRemarqueCalendarController.dart';
import 'package:flutter_english_course/navigation_menu.dart';
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


class Selectprofilescreen extends StatelessWidget {
  const Selectprofilescreen({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    Rx<RxList<EleveModel>> listEleve = ParentController.instance.myeleves.obs;
    ever(ParentController.instance.myeleves, (val){
      listEleve(ParentController.instance.myeleves);
      listEleve.refresh();
    });
    return Scaffold(
      body: SafeArea(
        child: Obx(
          ()=> Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(height: 40),
              Text(
                "اختر التلميذ",
                style: GoogleFonts.readexPro(
                    textStyle: TextStyle(
                        color: Colors.purple,
                        fontWeight: FontWeight.bold,
                        fontSize: 25)),
              ),
              const SizedBox(height: 100),
              Expanded(
                child: GridView.count(
                  crossAxisCount: 2,
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 30,
                  children: listEleve.value.map((profile) {
                    return GestureDetector(
                      onTap: () {
                        ParentController.instance.selectedStudent(profile);
                        EleveController.instance.fetchEleveProfileData();
                        EleveController.instance.selectedStudent(profile);
                        EleveController.instance.eleveSelected(true);
                        Get.off(()=> NavigationMenu());
                      },
                      child: Column(
                        children: [
                          CircleAvatar(
                            radius: 50,
                            backgroundColor: Colors.white,
                            child: Container(
                                child: Padding(
                                  padding: const EdgeInsets.all(25.0),
                                  child: Icon(Icons.person, size: 50, color: Colors.purple),
                                ),
                              decoration: BoxDecoration(
                                boxShadow: [BoxShadow(color: Colors.purple,blurRadius: 100,),],
                                borderRadius: BorderRadius.all(Radius.circular(30)),
                                border: Border.all(color: Colors.purple)
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            "${profile.nom} ${profile.prenom}",
                            style: const TextStyle(
                              color: Colors.purple,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
