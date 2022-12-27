import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'Colors.dart';

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
var black22AbeezeTS = GoogleFonts.aBeeZee(
    fontSize: 22,
    letterSpacing: .05,
    fontWeight: FontWeight.bold,
    color: Colors.black);
var black20LatoTS = GoogleFonts.lato(
    fontSize: 20, fontWeight: FontWeight.bold, letterSpacing: .1);
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
var black15lato = GoogleFonts.lato(
    fontSize: 12,
    fontWeight: FontWeight.w700,
    textStyle: const TextStyle(shadows: [
      BoxShadow(
          color: AppColors.whiteColor, offset: Offset(2, 2), blurRadius: 3)
    ]));

var white20LatoTS = GoogleFonts.lato(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    letterSpacing: .1,
    color: AppColors.whiteColor);
var white15lato = GoogleFonts.lato(
    fontSize: 15, fontWeight: FontWeight.w700, color: AppColors.whiteColor);
////////////************************groups sc *************** */
groupNameTS({required bool isSelected}) {
  print("object");
  return GoogleFonts.aBeeZee(
      fontSize: 22,
      letterSpacing: .08,
      fontWeight: FontWeight.bold,
      color: isSelected ? Colors.white : AppColors.pomegranateColor);
}
