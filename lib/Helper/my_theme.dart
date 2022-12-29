import 'package:flutter/material.dart';
import 'package:travelagency/Helper/text_style.dart';

import 'Colors.dart';

abstract class MyThemeData {
  static inputDhintPre(
    BuildContext context, {
    required Widget icon,
    required String label,
  }) {
    return InputDecoration(
        filled: true,
        fillColor: AppColors.offWhiteColor.withOpacity(0.8),
        focusColor: AppColors.whiteColor,
        prefixIcon: icon,
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

  static groupNameDEC(BuildContext context, {required bool isSelected}) {
    return BoxDecoration(
        boxShadow: const [
          BoxShadow(
              color: Color.fromARGB(88, 154, 154, 154),
              blurRadius: 4,
              offset: Offset(0, 4))
        ],
        borderRadius:
            BorderRadius.circular(MediaQuery.of(context).size.width * .022),
        gradient: isSelected
            ? const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xffE4E4E4), Color(0xff9F1212)])
            : const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xffE4E4E4), Colors.white]));
  }

  static groupDateHotelDEC(context) {
    return BoxDecoration(
      boxShadow: const [
        BoxShadow(
          color: Color.fromARGB(70, 154, 154, 154),
          blurRadius: 2,
          offset: Offset(-4, 4),
        ),
        BoxShadow(
          color: Color.fromARGB(255, 246, 246, 246),
        ),
      ],
      borderRadius:
          BorderRadius.circular(MediaQuery.of(context).size.width * .015),
    );
  }
}
