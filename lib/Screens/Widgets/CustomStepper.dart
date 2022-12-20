import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travelagency/Helper/Colors.dart';

class CustomStepper extends StatelessWidget {
  final double wedth , heght;
  const CustomStepper({Key? key, required this.wedth, required this.heght}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: heght * 0.16, // = 153.76
      width: wedth * 0.08, // = 153.6
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
                border: Border.all(
                  color: AppColors.grayColor,
                  width: 1,
                )
            ),
            child: Icon(Icons.check , color: AppColors.grayColor , size: 50 ),
          ),
          Text("Step One" , style: GoogleFonts.lato(color: AppColors.grayColor , fontWeight: FontWeight.bold , fontSize: 22),),
          Text("Select Country Visa" , style: GoogleFonts.lato(color: AppColors.grayColor , fontWeight: FontWeight.w400 , fontSize: 14),)
        ],
      ),
    );
  }
}
