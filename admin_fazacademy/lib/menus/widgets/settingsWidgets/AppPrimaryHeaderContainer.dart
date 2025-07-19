import 'package:flutter/material.dart';

import '../../../../components/common/AppCircularContainer.dart';
import '../../../../utils/constants/colors.dart';
import 'AppCuvedEdgesWidget.dart';

class AppPrimaryHeaderContainer extends StatelessWidget {
  const AppPrimaryHeaderContainer({
    super.key, required this.child, required this.height,
  });
  final Widget child;
  final double? height;
  @override
  Widget build(BuildContext context) {
    return AppCuvedEdgesWidget(
      child: Container(
        color : Colors.purple,
        padding: const EdgeInsets.all(0),
        child: SizedBox(
          height: height,
          child: Stack(
            children: [
              Positioned(top: -150,right: -250,child: AppCircularContainer(background: Appcolors.textWhite.withOpacity(0.1),)),
              Positioned(top: 100,right: -300,child: AppCircularContainer(background: Appcolors.textWhite.withOpacity(0.1),)),
              child,
            ],
          ),
        ),
      ),
    );
  }
}
