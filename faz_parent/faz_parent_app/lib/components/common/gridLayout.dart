import 'package:flutter/material.dart';

import '../../../utils/constants/sizes.dart';


class GridLayout extends StatelessWidget {
  const GridLayout({
    super.key, required this.itemcount, this.mainAxisExtent = 250 , required this.itembuilder,
  });
  final int itemcount;
  final double mainAxisExtent ;
  final Widget? Function(BuildContext, int) itembuilder;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSizes.defaultspace/2),
        child: Column(
          children: [
            GridView.builder(
                itemCount: itemcount,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: AppSizes.gridViewSpacing,
                    crossAxisSpacing: AppSizes.gridViewSpacing,
                    mainAxisExtent: mainAxisExtent
                    ),
                itemBuilder:itembuilder,
                ),
          ],
        )),
    );
  }
}