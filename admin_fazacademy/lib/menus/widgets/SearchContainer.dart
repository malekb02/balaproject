import 'package:flutter/material.dart';
import 'package:flutter_english_course/components/common/studentcard.dart';
import 'package:flutter_english_course/models/eleve/eleveModel.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';



import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/device/device_utils.dart';
import '../../../components/common/gridLayout.dart';
import '../../../utils/helpers/helper_functions.dart';

class SearchContainer extends StatelessWidget {
   SearchContainer({
    super.key,
    required this.text,
    this.icon = Iconsax.search_normal,
    this.showBackground = true,
    this.showBorder = true,

    this.padding = const EdgeInsets.symmetric(horizontal: AppSizes.defaultspace),
    required this.dataList,
  });

  final String text;
  final IconData? icon;
  final bool showBackground, showBorder;
  final EdgeInsetsGeometry padding;
  List<EleveModel> dataList;

  @override
  Widget build(BuildContext context) {
    final dark = AppHelperFunctions.isDarkMode(context);
    return GestureDetector(
      onTap: () {
        showSearch(context: context, delegate: CustumSearchDelegate(students: dataList));
      },
      child: Padding(
        padding: padding,
        child: Container(
          width: AppDeviceUtils.getScreenWidth(),
          padding: const EdgeInsets.all(AppSizes.md),
          decoration: BoxDecoration(
            color: showBackground
                ? dark
                    ? Appcolors.dark
                    : Appcolors.light
                : Colors.transparent,
            borderRadius: BorderRadius.circular(AppSizes.cardRadiusLg),
            border: showBorder ? Border.all(color: Appcolors.grey) : null,
          ),
          child: Row(
            children: [
              Icon(
                icon,
                color: Appcolors.darkergrey,
              ),
              const SizedBox(
                width: AppSizes.spaceBtwItems,
              ),
              Text(
                text,
                style: GoogleFonts.readexPro(
                    textStyle: TextStyle(
                        color: Colors.black54,
                        fontWeight: FontWeight.normal,
                        fontSize: 15)),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class CustumSearchDelegate extends SearchDelegate {
  CustumSearchDelegate({required this.students});

  List filteredTotal =[].obs;

  List<EleveModel> students = [];

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = '';
          },
          icon: Icon(Icons.clear)),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(onPressed: (){
      close(context, null);
    }, icon: Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    List<String> matchQuery = [

    ];
    return GridLayout(
      itemcount: filteredTotal.length,
      itembuilder: (_, index) =>  StudentCardVertical(student: filteredTotal[index]),
      mainAxisExtent: AppHelperFunctions.screenHeight() * 0.286,
    );
  }
  @override
  Widget buildSuggestions(BuildContext context) {
    List filtered = students.where((student) {
      return (student.nom.contains(query) || student.prenom.contains(query)) && query != "";
    }).toList().obs;
    filteredTotal = filtered;
    return Padding(
      padding: const EdgeInsets.only(top:50),
      child: Obx(
        ()=> GridLayout(
          itemcount: filtered.length,
          itembuilder: (_, index) =>  StudentCardVertical(student: filtered[index]),
          mainAxisExtent: AppHelperFunctions.screenHeight() * 0.286,
        ),
      ),
    );;
  }
}
