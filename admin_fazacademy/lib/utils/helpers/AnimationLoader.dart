import 'package:flutter/material.dart';

import 'package:lottie/lottie.dart';

import '../constants/colors.dart';
import '../constants/sizes.dart';

class AnimationLoader extends StatelessWidget {
  const AnimationLoader(
      {Key? key,
      required this.text,
      required this.animation,
      this.actionText,
      this.onActionPressed})
      : super(key: key);

  final String text;
  final String animation;
  final bool showAction = false;
  final String? actionText;
  final VoidCallback? onActionPressed;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset(animation,
              width: MediaQuery.of(context).size.width * 0.8),
          SizedBox(
            height: AppSizes.defaultspace,
          ),
          Text(
            text,
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: AppSizes.defaultspace,
          ),
          showAction
              ? SizedBox(
                  width: 250,
                  child: OutlinedButton(
                    onPressed: onActionPressed,
                    style: OutlinedButton.styleFrom(
                        backgroundColor: Appcolors.dark),
                    child: Text(
                      actionText!,
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .apply(color: Appcolors.light),
                    ),
                  ),
                )
              : SizedBox(),
        ],
      ),
    );
  }
}
