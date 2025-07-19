import 'package:flutter/material.dart';


import '../../utils/constants/colors.dart';
import '../../utils/device/device_utils.dart';
import '../../utils/helpers/helper_functions.dart';


class CustomTabBar extends StatelessWidget implements PreferredSizeWidget{
  const CustomTabBar({Key? key, required this.tabs}) : super(key: key);


    final List<Widget> tabs;
  @override
  Widget build(BuildContext context) {
    final dark = AppHelperFunctions.isDarkMode(context);
    return Material(
      color: dark ?Colors.black : Colors.white ,
      child: TabBar(
        tabs: tabs,
        isScrollable: true,
        indicatorColor: Appcolors.primaryColor,
        labelColor: dark ? Colors.white : Appcolors.primaryColor,
        unselectedLabelColor: Appcolors.darkgrey,
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(AppDeviceUtils.getAppBarHeight());
}
