import 'package:flutter/material.dart';
import 'package:flutter_english_course/components/common/appBar.dart';
import 'package:flutter_english_course/controllers/AdminController.dart';
import 'package:flutter_english_course/menus/Screens/AddNewProf.dart';
import 'package:flutter_english_course/menus/Screens/OneProfScreen.dart';
import 'package:flutter_english_course/utils/constants/colors.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';

class ProfsScreen extends StatefulWidget {
  static const String routeName = '/profs';

  const ProfsScreen({super.key});

  @override
  State<ProfsScreen> createState() => _CoursesViewState();
}

class _CoursesViewState extends State<ProfsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: Text(
          "الأساتذة",
          style: GoogleFonts.readexPro(
            textStyle: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 21,
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniStartFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.to( AddProfScreen()),
        backgroundColor: Appcolors.primaryColor,
        child: const Icon(Iconsax.add),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 30.0, left: 30, right: 30),
        child: GridView.builder(
          itemCount: AdminController.instance.AllProfs.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 0.75, // Slightly taller card
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
          ),
          itemBuilder: (context, index) {
            final prof = AdminController.instance.AllProfs[index];
            return GestureDetector(
              onTap: () => Get.to(OneProfScreen(prof: prof)),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                  side: const BorderSide(
                    color: Colors.grey,
                    width: 2,
                  ),
                ),
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                       CircleAvatar(
                        backgroundColor: Colors.purple.shade200,
                        radius: 30,
                        child: Text(prof.nom[0]),
                      ),
                      Expanded(
                        child: Center(
                          child: Text(
                            prof.fullname,
                            textAlign: TextAlign.center,
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(fontSize: 14),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
