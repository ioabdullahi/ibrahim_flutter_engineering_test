import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ibrahim_abdullahi_flutter_engineering_translation_test/core/app_colors.dart';

class AppTextStyles {
  static final TextStyle heading = GoogleFonts.dmSans(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.primaryLight,
  );
  static final TextStyle counter = GoogleFonts.dmSans(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: AppColors.primaryLight,
  );

  static final TextStyle body = GoogleFonts.dmSans(
    fontSize: 24,
    color: AppColors.primaryLight,
  );
  static final TextStyle main = GoogleFonts.dmSans(
    fontSize: 36,
    color: AppColors.black,
  );
}
