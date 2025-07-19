import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_english_course/banner/studentrepo.dart';
import 'package:flutter_english_course/components/common/appBar.dart';
import 'package:flutter_english_course/controllers/AdminController.dart';
import 'package:flutter_english_course/controllers/StudentController.dart';
import 'package:flutter_english_course/controllers/controllers/ServiceController.dart';
import 'package:flutter_english_course/controllers/controllers/profmodel.dart';
import 'package:flutter_english_course/cores/cores.dart';
import 'package:flutter_english_course/menus/Screens/AddNewClassScreen.dart';
import 'package:flutter_english_course/models/eleve/eleveModel.dart';
import 'package:flutter_english_course/models/eleve/parentmodel.dart';
import 'package:flutter_english_course/models/service/ServiceModel.dart';
import 'package:flutter_english_course/utils/Loaders/AppLoaders.dart';
import 'package:flutter_english_course/utils/constants/colors.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';
// add_student_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class AddProfScreen extends StatelessWidget {
  final StudentAddController controller = Get.put(StudentAddController());
  final ParentSelectController parentSelectController = Get.put(ParentSelectController());
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  AddProfScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: Text("إضافة أستاذ"),showBackArrow: false,),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              _buildTextField(controller.nom, "الإسم", true),
              _buildTextField(controller.prenom, "اللقب", true),
              _buildTextField(controller.noteImp, "ملاحظات", false),
              _buildTextField(controller.num, "الهاتف", true),
              _buildTextField(controller.username, "اسم المستخدم", true),
              _buildTextField(controller.email, "الإيميل", true),
              _buildTextField(controller.password, "الرمز السري", true),

              const SizedBox(height: 10),


              const SizedBox(height: 10),
              Text("الخدمات", style: TextStyle(fontWeight: FontWeight.bold)),
              Obx(() => Wrap(
                spacing: 12,
                runSpacing: 12,
                children: controller.services.map((service) {
                  final isSelected = controller.selectedServiceIds.contains(service);
                  return GestureDetector(
                    onTap: () => controller.toggleService(service),
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
                            SizedBox(height: 8),
                            Text(service.nom, style: TextStyle(fontSize: 14)),
                            Text(service.niveau, style: TextStyle(fontSize: 14)),
                          ],
                        ),
                      ),
                    ),
                  );
                }).toList(),
              )),

              const SizedBox(height: 20),

            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          children: [
            Expanded(
                child: ElevatedButton(
                    onPressed: () {
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
                      controller.submitProf(_formKey);
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
    );
  }

  Widget _buildTextField(TextEditingController ctrl, String hint, bool required,
      {bool isNumber = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: TextFormField(
        controller: ctrl,
        keyboardType: isNumber ? TextInputType.number : TextInputType.text,
        decoration : InputDecoration(
          hintText: hint,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Appcolors.primaryColor, width: 1.5),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.grey.shade300, width: 1),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Appcolors.primaryColor, width: 2),
          ),
          hintStyle: const TextStyle(fontSize: 15, color: Colors.grey),
        ),
        validator: (val) =>
        required && (val == null || val.trim().isEmpty) ? "إجباري" : null,

      ),
    );
  }
}



class StudentAddController extends GetxController {
  final uuid = Uuid();

  // Controllers
  final nom = TextEditingController();
  final prenom = TextEditingController();
  final num = TextEditingController();
  final niveauSco = TextEditingController();
  final noteImp = TextEditingController();
  final adresse = TextEditingController();
  final email = TextEditingController();
  final username = TextEditingController();
  final age = TextEditingController();
  final password = TextEditingController();

  Rx<DateTime> dateNes = DateTime.now().obs;
  Rx<DateTime> dateInsc = DateTime.now().obs;

  RxList<ServiceModel> services = ServiceController.instance.serices;
  RxList<ServiceModel> selectedServiceIds = <ServiceModel>[].obs;

  void pickDate(Function(DateTime) onPicked) async {
    final date = await showDatePicker(
      context: Get.context!,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2035),
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.light(
              primary: Colors.purple,
              onPrimary: Colors.white,
              surface: Colors.white,
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
    if (date != null) onPicked(date);
  }

  void toggleService(ServiceModel serviceId) {
    if (selectedServiceIds.contains(serviceId)) {
      selectedServiceIds.remove(serviceId);
    } else {
      selectedServiceIds.add(serviceId);
    }
  }

  Future<void> submitProf(GlobalKey<FormState> formKey) async {
    if (!formKey.currentState!.validate()) return;

    final studentId = uuid.v4();
    final List<Map<String, dynamic>> selectedServices = selectedServiceIds
        .map((id) => {"service": id.id, "dateInsc": DateTime.now()})
        .toList();

    final EleveModel student = EleveModel(id: "", nom: nom.text.trim(), prenom: prenom.text.trim(), dateInsc: dateInsc.value, dateNes: dateNes.value, numParent: "", niveauSco: niveauSco.text.trim(), age: int.tryParse(age.text) ?? 0, noteImp: noteImp.text.trim(), adresse: adresse.text.trim(), service: selectedServices, email: "", username: username.text.trim());
    final ProfModel prof = ProfModel(id: "", nom: nom.text.trim(), prenom: prenom.text.trim(), numero: num.text.trim(), email: email.text.trim(), username: username.text.trim(),CoupParClass: 0);
    await AdminController.instance.AjouteNewProfRecord(prof,password.text.trim());
    Get.back();
    AppLoaders.successSnackbar(title: "نجاح",message: "تمت إضافة التلميذ بنجاح");
  }
}
class ParentSelectController extends GetxController {
  var selectedParent = Parentmodel.empty().obs;

  List<Parentmodel> Parents = AdminController.instance.AllParents;

  void setTeacher(String id) {
    selectedParent.value = Parents.where((tea) => tea.id == id).first;
  }
}