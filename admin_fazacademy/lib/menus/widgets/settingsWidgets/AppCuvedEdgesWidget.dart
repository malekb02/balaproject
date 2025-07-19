import 'package:flutter/material.dart';

import 'AppCustomCuvedEdges.dart';


class AppCuvedEdgesWidget extends StatelessWidget {
  const AppCuvedEdgesWidget({
    super.key, this.child,
  });
  final Widget? child;
  @override
  Widget build(BuildContext context) {
    return ClipPath(
        clipper: AppCustomCuvedEdges(),
        child: child
    );
  }
}

