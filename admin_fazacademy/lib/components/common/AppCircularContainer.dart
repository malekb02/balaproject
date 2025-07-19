import 'package:flutter/material.dart';

import '../../../../utils/constants/colors.dart';
import '../../utils/constants/sizes.dart';




class AppCircularContainer extends StatelessWidget {
  const AppCircularContainer({
    super.key, this.width=400, this.height=400,this.radius= AppSizes.cardRadiusLg,this.padding = const EdgeInsets.all(0), this.child, this.background=Colors.purple, this.margin,  this.BorderColor = Colors.purple,  this.showBorder = false,
  });
  final double? width;
  final double? height;
  final double radius;
  final EdgeInsetsGeometry padding;
  final Widget? child;
  final EdgeInsetsGeometry? margin;
  final Color background;
  final Color BorderColor ;
  final bool showBorder;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      margin: margin,
      padding:  padding,
      decoration: BoxDecoration(
        border: showBorder ? Border.all(color: BorderColor) : null,
        borderRadius: BorderRadius.circular(radius),
        color: background,
      ),
      child: child,
    );
  }
}
