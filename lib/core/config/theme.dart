import 'package:pmf_admin/core/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppThemes {
  static final appTheme = ThemeData(
    scaffoldBackgroundColor: AppColors.kSecondColor,
    fontFamily: GoogleFonts.poppins().fontFamily,
    colorScheme: const ColorScheme.light(
      primary: AppColors.kPrimaryColor,
    ),
  );
}
