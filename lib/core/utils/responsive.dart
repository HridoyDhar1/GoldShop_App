import 'package:flutter/widgets.dart';

class Responsive {
  final double screenWidth;
  final double screenHeight;

  Responsive({required this.screenWidth, required this.screenHeight});

  bool get isMobile => screenWidth < 600;
  bool get isTablet => screenWidth >= 600 && screenWidth < 1200;
  bool get isDesktop => screenWidth >= 1200;

  double getImageSize() {
    if (isMobile) return 250;
    if (isTablet) return 350;
    return 400;
  }

  double getTitleFontSize() {
    if (isMobile) return 30;
    if (isTablet) return 35;
    return 40;
  }

  double getSubtitleFontSize() {
    if (isMobile) return 25;
    if (isTablet) return 30;
    return 35;
  }
  double getTextDes(){
    if(isMobile) return 15;
    if(isTablet) return 20;
    return 25;
  }

  double getButtonPaddingH() {
    if (isMobile) return 50;
    if (isTablet) return 60;
    return 70;
  }

  double getButtonPaddingV() {
    if (isMobile) return 15;
    if (isTablet) return 20;
    return 25;
  }

  static Responsive of(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Responsive(screenWidth: size.width, screenHeight: size.height);
  }
}
