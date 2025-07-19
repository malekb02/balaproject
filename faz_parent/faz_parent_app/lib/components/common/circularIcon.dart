import 'package:flutter/material.dart';

import '../../../utils/constants/colors.dart';
import '../../utils/constants/sizes.dart';
import '../../utils/helpers/helper_functions.dart';


class CircularIcon extends StatelessWidget {
  const CircularIcon({
    super.key,  this.height,  this.width, required this.icon, this.backgroundcolor, this.onPressed, this.size= AppSizes.lg, this.color});

  final double? height,width,size ;
  final IconData icon;
  final Color? backgroundcolor;
  final Color? color;
  final VoidCallback? onPressed;


  @override
  Widget build(BuildContext context) {
    final dark = AppHelperFunctions.isDarkMode(context);
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: backgroundcolor ?? (dark ? Appcolors.black.withOpacity(0.9) : Appcolors.white.withOpacity(0.9)),
        borderRadius: BorderRadius.circular(100),
      ),
      child: IconButton(onPressed: onPressed,icon: Icon(icon , color: color,size: size, ),),
    );
  }
}
