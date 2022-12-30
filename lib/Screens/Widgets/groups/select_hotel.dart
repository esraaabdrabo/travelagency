import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../view_model/group.dart';
import 'hotel_img.dart';

// ignore: must_be_immutable
class SelectHotel extends StatelessWidget {
  late GroupsVM groupProvider;
  late AppLocalizations translate;
  late double wedth;
  late double heght;

  SelectHotel(
      {super.key,
      required this.groupProvider,
      required this.translate,
      required this.wedth,
      required this.heght});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          EdgeInsets.symmetric(horizontal: wedth * .02, vertical: heght * .03),
      height: MediaQuery.of(context).size.height * .62,
      width: wedth * .6,
      color: const Color.fromARGB(50, 154, 154, 154),
      //alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FittedBox(
            child: Text(translate.availableHotels,
                //   textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: GoogleFonts.lato(
                    fontSize: heght * .04, fontWeight: FontWeight.w600)),
          ),
          Container(
            height: MediaQuery.of(context).size.height * .47,
            padding: EdgeInsets.only(top: heght * .03),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: groupProvider
                  .groups[groupProvider.currentClickedGroupIndex]
                  .groupHotels
                  .length,
              itemBuilder: (context, hotelIndex) => HotelImg(
                hotel: groupProvider
                    .groups[groupProvider.currentClickedGroupIndex]
                    .groupHotels[hotelIndex],
                heght: heght,
                hotelIndex: hotelIndex,
                wedth: wedth,
                groupsProvider: groupProvider,
              ),
            ),
          )
        ],
      ),
    );
  }
}
