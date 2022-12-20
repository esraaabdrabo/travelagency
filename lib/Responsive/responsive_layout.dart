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
        if (constraints.maxWidth < 600) {
          print("mob");

          return mobileBody;
        } else if (constraints.maxWidth < 1100) {
          print("tablet");

          return tabletBody;
        } else {
          print("desk");
          return desktopBody;
        }
      },
    );
  }
}
