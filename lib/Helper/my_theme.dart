import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travelagency/Helper/text_style.dart';

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
          borderSide:
              BorderSide(width: 2, color: Color.fromARGB(208, 61, 61, 61)),
        ),
        errorBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.pomegranateColor),
        ),
        labelText: label,
        hintStyle: black15lato,
        helperStyle: black15lato,
        contentPadding: EdgeInsets.all(5),
        labelStyle: black15lato);
  }
}
