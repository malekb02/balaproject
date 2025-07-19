import 'package:flutter/material.dart';
import 'package:flutter_english_course/cores/cores.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../utils/constants/sizes.dart';



class ProfileMenu extends StatelessWidget {
  const ProfileMenu({
    super.key,  this.icon = Iconsax.arrow_right_34, required this.onPressed, required this.title, required this.value,
  });

  final IconData icon;
  final VoidCallback onPressed;
  final String title, value;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Padding(
        padding: const EdgeInsets.all(AppSizes.spaceBtwItems/1.5),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title, style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18,color: Colors.purple),overflow: TextOverflow.ellipsis,),
              Text(value, style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18,color: Colors.black),overflow: TextOverflow.ellipsis,),
            ],
          ),
        ),
      ),
    );
  }
}