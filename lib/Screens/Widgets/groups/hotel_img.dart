import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../Helper/Colors.dart';
import '../../../Helper/my_theme.dart';
import '../../../models/groups/group.dart';
import '../../../view_model/group.dart';

class HotelImg extends StatelessWidget {
  late GroupsVM groupsProvider;
  late double wedth;
  late double heght;
  late int hotelIndex;
  late GroupHotels hotel;
  HotelImg(
      {super.key,
      required this.groupsProvider,
      required this.wedth,
      required this.heght,
      required this.hotelIndex,
      required this.hotel});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: wedth * .002),
        child: InkWell(
          onTap: () {
            groupsProvider.changeClickedHotel(hotelId: hotel.hotelId);
          },
          onHover: (value) {
            value
                ? groupsProvider.changeHoveredHatel(hotel: hotel.hotelName)
                : groupsProvider.changeHoveredHatel(hotel: "");
          },
          child: SizedBox(
            width: wedth * .13,
            child: Container(
              decoration: BoxDecoration(
                  color: (groupsProvider.currentHoveredHotel ==
                              hotel.hotelName ||
                          hotel.hotelId == groupsProvider.currentClickedHotel)
                      ? AppColors.pomegranateColor
                      : const Color.fromARGB(0, 0, 0, 0),
                  borderRadius: BorderRadius.circular(wedth * .005)),
              padding: EdgeInsets.only(
                  top: heght * .012,
                  bottom: heght * .038,
                  left: wedth * .006,
                  right: wedth * .006),
              child: Stack(
                alignment: AlignmentDirectional.bottomStart,
                children: [
                  //back ground img
                  Container(
                      alignment: Alignment.bottomLeft,
                      width: wedth * .13,
                      decoration: BoxDecoration(
                          color: groupsProvider.currentHoveredDate ==
                                  hotel.hotelName
                              ? AppColors.pomegranateColor
                              : const Color.fromARGB(0, 0, 0, 0),
                          image: DecorationImage(
                              image: NetworkImage(hotel.hotelImage),
                              fit: BoxFit.fill))),
                  Container(decoration: MyThemeData.blackLayer),
                  Container(
                    width: wedth * .08,
                    padding: EdgeInsets.only(
                        left: wedth * .005, bottom: heght * .02),
                    child: Text(
                      hotel.hotelName,
                      style: GoogleFonts.aBeeZee(
                          fontSize: MediaQuery.of(context).size.height * .03,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
