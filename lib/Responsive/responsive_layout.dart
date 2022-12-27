import 'dart:developer';

import 'package:flutter/material.dart';

class ResponsiveLayout extends StatelessWidget {
  final Widget mobileBody;
  final Widget tabletBody;
  final Widget desktopBody;

  const ResponsiveLayout({
    super.key,
    required this.mobileBody,
    required this.tabletBody,
    required this.desktopBody,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        log("max width ${constraints.maxWidth}");
        if (constraints.maxWidth < 600) {
          return mobileBody;
        } else if (constraints.maxWidth < 900) {
          return tabletBody;
        } else {
          log("message");

          return desktopBody;
        }
      },
    );
  }
}
