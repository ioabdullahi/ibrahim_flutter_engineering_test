import 'package:flutter/widgets.dart';

class AppColors {
  static const Color primary = Color(0xffff9601);
  static const Color primaryLight = Color(0xffA5957E);
  static const Color black = Color(0xff232220);
  static const Color white = Color(0xffffffff);
  static const Color successGreen = Color(0xff27AE60);
  static const Color errorRed = Color(0xffEB5757);
  static const Color dividerGrey = Color(0xffEDEFF5);
  static const Color borderGrey = Color(0xffF0F0F0);

  static const Gradient backgroundGradient = LinearGradient(
    begin: Alignment.topLeft, // Starts at the top-left corner
    end: Alignment.bottomRight, // Ends at the bottom-right corner
    colors: [
      white,
      primary,
    ],
    stops: [0.4, 0.9],
  );
}
