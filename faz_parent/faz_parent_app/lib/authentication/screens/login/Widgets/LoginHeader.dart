import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../utils/constants/imageStrings.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/constants/textStrings.dart';



class LoginHeader extends StatelessWidget {
  const LoginHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: 100,),
        const Image(
          height: 130,
          image: AssetImage("assets/images/png/logo.png"),
        ),
        const SizedBox(
          height: AppSizes.xl,
        ),
        Text(
          "مرحبا بكم في ",
          style: GoogleFonts.readexPro(
              textStyle: TextStyle(
                  color: Colors.purple,
                  fontWeight: FontWeight.bold,
                  fontSize: 30)),
        ),
        const SizedBox(
          height: AppSizes.sm,
        ),
        Text(
          "مدرسة فاز",
          style: GoogleFonts.readexPro(
              textStyle: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.normal,
                  fontSize: 21)),
        ),
      ],
    );
  }
}
