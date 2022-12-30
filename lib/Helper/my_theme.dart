import 'dart:math';

import 'package:flutter/material.dart';
import 'package:travelagency/Helper/text_style.dart';

import 'Colors.dart';

abstract class MyThemeData {
  static inputDhintPre(BuildContext context,
      {required Widget icon, required String label, bool isRequired = true}) {
    return InputDecoration(
        errorText: null,
        filled: true,
        fillColor: AppColors.offWhiteColor.withOpacity(0.8),
        focusColor: AppColors.whiteColor,
        prefixIcon: icon,
        suffixIcon: isRequired
            ? const Text(
                "*",
                textAlign: TextAlign.center,
              )
            : null,
        enabled: true,
        /*  enabledBorder: const OutlineInputBorder(
         borderSide: BorderSide(color: AppColors.grayColor, width: 0.5),
        ),*/
        focusedBorder: const OutlineInputBorder(
          borderSide:
              BorderSide(width: 2, color: Color.fromARGB(208, 61, 61, 61)),
        ),
        errorBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.pomegranateColor),
        ),
        labelText: label,
        hintStyle: black15lato(context),
        helperStyle: black15lato(context),
        contentPadding:
            EdgeInsets.all(MediaQuery.of(context).size.width * .005),
        labelStyle: black15lato(context));
  }

  static groupNameDEC(BuildContext context,
      {required bool isSelected, required bool isHovered}) {
    return BoxDecoration(
        boxShadow: const [
          BoxShadow(
              color: Color.fromARGB(88, 154, 154, 154),
              blurRadius: 4,
              offset: Offset(0, 4))
        ],
        borderRadius:
            BorderRadius.circular(MediaQuery.of(context).size.width * .01),
        color: isSelected || isHovered
            ? const Color(0xff9F1212)
            : const Color.fromARGB(251, 129, 129, 210));
  }

//*****************groups****************************** */

  static var blackLayer = const BoxDecoration(
      gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.transparent, Colors.black]));
}
