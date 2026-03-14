import 'package:flutter/material.dart';
import '../constants/app_sizes.dart';

class ResponsiveLayout extends StatelessWidget {
  final WidgetBuilder mobile;
  final WidgetBuilder tablet;
  final WidgetBuilder desktop;

  const ResponsiveLayout({
    super.key,
    required this.mobile,
    required this.tablet,
    required this.desktop,
  });

  static bool isMobile(BuildContext context) =>
      MediaQuery.sizeOf(context).width < AppSizes.mobileBreakPoint;

  static bool isTablet(BuildContext context) =>
      MediaQuery.sizeOf(context).width >= AppSizes.mobileBreakPoint &&
      MediaQuery.sizeOf(context).width < AppSizes.tabletBreakPoint;

  static bool isDesktop(BuildContext context) =>
      MediaQuery.sizeOf(context).width >= AppSizes.tabletBreakPoint;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth >= AppSizes.tabletBreakPoint) {
          return desktop(context);
        } else if (constraints.maxWidth >= AppSizes.mobileBreakPoint) {
          return tablet(context);
        } else {
          return mobile(context);
        }
      },
    );
  }
}
