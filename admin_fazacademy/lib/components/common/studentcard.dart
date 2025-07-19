import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_english_course/components/common/AppCircularContainer.dart';
import 'package:flutter_english_course/components/common/RoundedImage.dart';
import 'package:flutter_english_course/controllers/StudentController.dart';
import 'package:flutter_english_course/controllers/AdminController.dart';
import 'package:flutter_english_course/models/eleve/eleveModel.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';

import '../../menus/Screens/StudentScreen.dart';
import '../../utils/constants/colors.dart';
import '../../utils/constants/sizes.dart';
import '../../utils/helpers/helper_functions.dart';
import '../../utils/theme/Customthemes/shadow.dart';
import 'circularIcon.dart';


class StudentCardVertical extends StatelessWidget {
  const StudentCardVertical({Key? key, required this.student})
      : super(key: key);

  final EleveModel student;

  @override
  Widget build(BuildContext context) {
    final controller = StudentController.instance;


    /*ever(UserController.instance.Wishlist, (value) => {isInWishlist.value = UserController.instance.Wishlist.value.ProductsIdList.contains(product.id)});
    ever(UserController.instance.Cart, (value) => {
      isInCart.value = UserController.instance.Cart.value.ProductsList.where((prod)=> prod.productId == product.id).toList().isNotEmpty
    });*/
    Offset position = Offset(100, 300);

    final dark = AppHelperFunctions.isDarkMode(context);
    return GestureDetector(
      onTap: ()=> {
        AdminController.instance.selectedStudent(student),
        Get.to(() => Studentscreen(student: student,focusedDay: DateTime.now().obs,selectedDay: ValueNotifier(DateTime.now()).obs,))
      },
      child: Container(
        width: AppHelperFunctions.screenWidth() * 0.3,
        height: null,
        padding: const EdgeInsets.all(1),
        decoration: BoxDecoration(
          boxShadow: [ShadowStyle.verticalProductShadow],
          borderRadius: BorderRadius.circular(AppSizes.ProductimageRadius),
          color: Appcolors.white,
        ),
        child: Column(
          children: [
            AppCircularContainer(
              height: AppHelperFunctions.screenHeight() * 0.17,
              //      padding: EdgeInsets.all(AppSizes.sm),
              background: Appcolors.light,
              child: Stack(
                children: [
                  RoundedImage(
                    imageUrl: "assets/images/jpg/student.jpg",
                    width: AppHelperFunctions.screenWidth() * 0.5,
                    fit: BoxFit.cover,
                    padding: EdgeInsets.all(0),
                    applyImageRaius: true,
                    isNetworkImage: false,
                  ),

                ],
              ),
            ),
            const SizedBox(
              height: AppSizes.spaceBtwItems / 2,
            ),
            Padding(
              padding: EdgeInsets.only(left: AppSizes.sm),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(student.nom,textAlign: TextAlign.end, style: GoogleFonts.readexPro(
                      textStyle: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 21)),),
                  SizedBox(
                    width: AppSizes.spaceBtwItems / 2,
                  ),
                  Text(student.prenom,textAlign: TextAlign.end,style: GoogleFonts.readexPro(
                      textStyle: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 21)),),
                ],
              ),
            ),
            SizedBox(height: 10,),
            Padding(
              padding:  EdgeInsets.only(left: AppSizes.sm),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Flexible(
                    child: Column(children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [

                            Text(
                              "${student.dateNes.day}/${student.dateNes.month}/${student.dateNes.year}",
                              style: GoogleFonts.readexPro(
                                  textStyle: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.normal,
                                      fontSize: 14)),
                            ),
                            SizedBox(width: 13,),
                            Text(
                              ":تاريخ الميلاد",
                              style: GoogleFonts.readexPro(
                                  textStyle: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.normal,
                                      fontSize: 13)),
                            ),
                          ],
                        ),

                    ]),
                  ),

                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
