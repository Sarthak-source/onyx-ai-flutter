
import 'package:flutter/material.dart';

extension ResponsiveExtension on BuildContext {
  double get width => MediaQuery.of(this).size.width;
  double get height => MediaQuery.of(this).size.height;

  bool get isMobile => MediaQuery.of(this).size.width < 850;

  bool get isTablet =>
      MediaQuery.of(this).size.width >= 850 &&
          MediaQuery.of(this).size.width < 1100;

  bool get isDesktop => MediaQuery.of(this).size.width >= 1100;

  bool get isPortrait =>
      MediaQuery.of(this).orientation == Orientation.portrait;

  bool get isLandscape =>
      MediaQuery.of(this).orientation == Orientation.landscape;


  double getWidth({
    double? ratioMobile,
    double? ratioTablet,
    double? ratioDesktop,
    double? ratioDesktopOpenSideMenu,
    bool sideMenuIsOpen = false,
  }) {
    final screenWidth = MediaQuery.of(this).size.width;
    if (isMobile) {
      return screenWidth * (ratioMobile ?? 1.0);
    } else if (isTablet) {
      return screenWidth * (ratioTablet ?? 1.0);
    } else if (isDesktop) {
      return screenWidth * (sideMenuIsOpen
          ? (ratioDesktopOpenSideMenu ?? ratioDesktop ?? 1.0)
          : (ratioDesktop ?? 1.0));
    }
    return screenWidth;
  }

  double getHeight({
    double? ratioMobile,
    double? ratioTablet,
    double? ratioDesktop,
    double? ratioTabletPortrait,
  }) {
    final screenHeight = MediaQuery.of(this).size.height;

    if (isMobile) {
      return screenHeight * (ratioMobile ?? 1.0);
    } else if (isTablet) {
      return isPortrait
          ? screenHeight * (ratioTabletPortrait ?? 1.0)
          : screenHeight * (ratioTablet ?? 1.0);
    } else if (isDesktop) {
      return screenHeight * (ratioDesktop ?? 1.0);
    }
    return screenHeight;
  }
}