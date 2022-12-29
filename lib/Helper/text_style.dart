import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'Colors.dart';

screenTitle(BuildContext context) {
  return GoogleFonts.lato(
      letterSpacing: 4,
      color: AppColors.pomegranateColor,
      fontSize: MediaQuery.of(context).size.height * .08,
      fontWeight: FontWeight.w900);
}

var red36lato = GoogleFonts.lato(
    letterSpacing: 4,
    color: AppColors.pomegranateColor,
    fontSize: 28,
    fontWeight: FontWeight.w900);
var red22lato = GoogleFonts.lato(
    letterSpacing: .12,
    color: AppColors.pomegranateColor,
    fontSize: 20,
    shadows: [
      const BoxShadow(
          offset: Offset(-2, 2),
          color: Color.fromARGB(70, 0, 0, 0),
          blurRadius: 2)
    ],
    fontWeight: FontWeight.w700);
var red15lato = GoogleFonts.lato(
    fontSize: 12,
    fontWeight: FontWeight.w700,
    color: AppColors.pomegranateColor);
black22AbeezeTS(BuildContext context) {
  return GoogleFonts.aBeeZee(
      fontSize: MediaQuery.of(context).size.height * .04,
      letterSpacing: .05,
      fontWeight: FontWeight.bold,
      color: Colors.black);
}

black20LatoTS(BuildContext context) {
  return GoogleFonts.lato(
      fontSize: MediaQuery.of(context).size.height * .025,
      fontWeight: FontWeight.bold,
      letterSpacing: .1);
}

var black20LatoWShadow = GoogleFonts.lato(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    letterSpacing: .1,
    shadows: const [
      BoxShadow(
          offset: Offset(-2, 2),
          blurRadius: 3,
          color: Color.fromARGB(173, 255, 255, 255))
    ]);
black15lato(BuildContext context) {
  return GoogleFonts.lato(
      fontSize: MediaQuery.of(context).size.height * .025,
      fontWeight: FontWeight.w700,
      textStyle: const TextStyle(shadows: [
        BoxShadow(
            color: AppColors.whiteColor, offset: Offset(2, 2), blurRadius: 3)
      ]));
}

var white20LatoTS = GoogleFonts.lato(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    letterSpacing: .1,
    color: AppColors.whiteColor);
white15lato(BuildContext context) {
  return GoogleFonts.lato(
      fontSize: MediaQuery.of(context).size.height * .03,
      fontWeight: FontWeight.w700,
      color: AppColors.whiteColor);
}

////////////************************groups sc *************** */
groupNameTS(BuildContext context, {required bool isSelected}) {
  return GoogleFonts.aBeeZee(
      fontSize: MediaQuery.of(context).size.height * .04,
      letterSpacing: .08,
      fontWeight: FontWeight.w400,
      color: Colors
          .white); // isSelected ? Colors.white : AppColors.pomegranateColor);
}
