import 'package:flutter/material.dart';

import '../../../../utils/constants/colors.dart';

class SettingsMenuTile extends StatelessWidget {
  const SettingsMenuTile({Key? key, required this.icon, required this.title, required this.subtitle, this.trailing, this.onTap}) : super(key: key);

  final IconData icon;
  final String title,subtitle;
  final Widget? trailing;
  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon,size: 28,color: Appcolors.primaryColor,),
      title: Text(title,textAlign: TextAlign.end,style: Theme.of(context).textTheme.labelLarge!.apply(fontSizeFactor: 1.3),),
      subtitle: Text(subtitle,textAlign: TextAlign.end,style: Theme.of(context).textTheme.labelMedium!.apply(fontSizeFactor: 0.9),),
      trailing: trailing,
      onTap: onTap,
    );
  }
}
