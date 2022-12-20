import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'Colors.dart';

abstract class MyThemeData {
  static inputDhintPre({required Widget icon, required String label}) {
    return InputDecoration(
      filled: true,
      fillColor: AppColors.offWhiteColor.withOpacity(0.8),
      focusColor: AppColors.whiteColor,
      prefixIcon: icon,
      enabled: true,
      enabledBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.grayColor, width: 0.5),
      ),
      focusedBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.pomegranateColor),
      ),
      labelText: label,
      hintStyle: GoogleFonts.lato(),
    );
  }
}
