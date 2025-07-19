import 'package:flutter/material.dart';

import '../../../../utils/constants/colors.dart';


class SectionHeading extends StatelessWidget {
  const SectionHeading({
    super.key,
    this.textcolor = Appcolors.white,
    this.showActionButton = false,
    required this.title,
    this.ButtonTitle = "Voir tous",
    this.onPressed,
  });

  final Color? textcolor;
  final bool showActionButton;
  final String title, ButtonTitle;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: Theme.of(context)
              .textTheme
              .headlineSmall!
              .apply(color: textcolor),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        if (showActionButton)
          TextButton(
              onPressed: onPressed,
              child: Text(
                ButtonTitle,
                style: Theme.of(context)
                    .textTheme
                    .labelLarge!
                    .apply(color: textcolor),
              ))
      ],
    );
  }
}
