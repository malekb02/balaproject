import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';


import '../../cores/cores.dart';



class AppShimmerEffect extends StatelessWidget {
  const AppShimmerEffect({Key? key, required this.width, required this.height,  this.radius=15, this.color}) : super(key: key);

  final double width, height, radius;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColors.blue.withOpacity(0.3)!,
      highlightColor: Colors.grey[500]!,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: color ?? Colors.white,
          borderRadius: BorderRadius.circular(radius),
        ),

      ),
    );
  }
}
