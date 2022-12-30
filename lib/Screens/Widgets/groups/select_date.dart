import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../Helper/Colors.dart';
import '../../../view_model/group.dart';

// ignore: must_be_immutable
class SelectDate extends StatelessWidget {
  late GroupsVM groupProvider;
  late AppLocalizations translate;
  late double wedth;
  late double heght;

  SelectDate(
      {super.key,
      required this.groupProvider,
      required this.translate,
      required this.wedth,
      required this.heght});

  @override
  Widget build(BuildContext context) {
    dateContainer(
        {required String date,
        required GroupsVM groupsProvider,
        required double width,
        required double heght}) {
      return InkWell(
        onTap: () {
          groupsProvider.changeClickedDate(dateId: date);
        },
        onHover: (value) {
          value
              ? groupsProvider.changeHoveredDate(date: date)
              : groupsProvider.changeHoveredDate(date: "");
        },
        child: Container(
          decoration: BoxDecoration(
            color: groupsProvider.currentHoveredDate == date ||
                    groupsProvider.currentClickedDate == date
                ? AppColors.pomegranateColor
                : const Color.fromARGB(0, 0, 0, 0),
            borderRadius: BorderRadius.circular(width * .0031),
          ),
          padding: EdgeInsets.symmetric(
              vertical: heght * .01, horizontal: width * .009),
          child: Row(
            children: [
              Icon(
                Icons.calendar_month_outlined,
                size: heght * .04,
                color: (groupsProvider.currentHoveredDate == date ||
                        groupsProvider.currentClickedDate == date)
                    ? Colors.white
                    : Colors.black,
              ),
              SizedBox(
                width: width * .005,
              ),
              Text(
                date,
                textAlign: TextAlign.center,
                style: GoogleFonts.aBeeZee(
                  fontSize: MediaQuery.of(context).size.height * .03,
                  fontWeight: FontWeight.bold,
                  color: (groupsProvider.currentHoveredDate == date ||
                          groupsProvider.currentClickedDate == date)
                      ? Colors.white
                      : Colors.black,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Container(
      padding:
          EdgeInsets.symmetric(horizontal: wedth * .004, vertical: heght * .03),
      height: MediaQuery.of(context).size.height * .62,
      width: wedth * .15,
      color: const Color.fromARGB(50, 154, 154, 154),
      alignment: Alignment.center,
      child: Column(
        children: [
          FittedBox(
            child: Text(translate.availableDates,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: GoogleFonts.lato(
                    fontSize: heght * .04, fontWeight: FontWeight.w600)),
          ),
          Container(
            height: MediaQuery.of(context).size.height * .37,
            padding: EdgeInsets.symmetric(horizontal: wedth * .002)
                .copyWith(top: heght * .015),
            child: ListView.builder(
              itemBuilder: (context, dateIndex) => dateContainer(
                  width: wedth,
                  heght: heght,
                  groupsProvider: groupProvider,
                  date: groupProvider
                      .groups[groupProvider.currentClickedGroupIndex]
                      .avilableDates[dateIndex]
                      .avilableDate),
              itemCount: groupProvider
                  .groups[groupProvider.currentClickedGroupIndex]
                  .avilableDates
                  .length,
            ),
          )
        ],
      ),
    );
  }
}
