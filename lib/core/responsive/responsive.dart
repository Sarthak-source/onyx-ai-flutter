import 'package:flutter/material.dart';
import 'package:onix_bot/core/responsive/responsive_ext.dart';


class AdaptiveWrapper extends StatelessWidget {
  final Widget mobile;
  final Widget? tablet;
  final Widget desktop;
  final bool sideMenuIsOpen;

  const AdaptiveWrapper({
    super.key,
    required this.mobile,
    this.tablet,
    required this.desktop,
    this.sideMenuIsOpen = false,
  });

  @override
  Widget build(BuildContext context) {
    if (context.isDesktop) {
      return desktop;
    } else if (context.isTablet && tablet != null) {
      return tablet!;
    } else {
      return mobile;
    }
  }
}