import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../Helper/Colors.dart';
import '../../view_model/hotels.dart';

// ignore: must_be_immutable
class RoomWidget extends StatelessWidget {
  HotelsVM hotelsProvider;
  int index;
  double wedth, heght;
  RoomWidget(
      {super.key,
      required this.index,
      required this.hotelsProvider,
      required this.heght,
      required this.wedth});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: heght * .108,
      padding: EdgeInsets.symmetric(vertical: heght * 0.008),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.offWhiteColor.withOpacity(0.5),
          borderRadius: BorderRadius.circular(wedth * .0075),
        ),
        child: Padding(
            padding: EdgeInsets.symmetric(vertical: heght * 0.008),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("ROOM ${index + 1}",
                    style: GoogleFonts.lato(
                        fontSize: heght * .035,
                        fontWeight: FontWeight.w900,
                        color: AppColors.grayColor)),
                SizedBox(width: wedth * 0.005),
                SizedBox(
                  width: wedth * 0.105,
                  child: DropdownButtonFormField(
                    itemHeight: null,
                    isExpanded: true,
                    isDense: false,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                          vertical: heght * .000, horizontal: wedth * .005),
                      labelStyle: TextStyle(fontSize: heght * .025),
                      labelText: 'Adult Num',
                      border: const OutlineInputBorder(),
                    ),
                    value: hotelsProvider.rooms[index].adultNum,
                    items: hotelsProvider.adultNumMenu
                        .map((int item) => DropdownMenuItem<int>(
                              value: item,
                              child: Text(item.toString(),
                                  style:
                                      GoogleFonts.lato(fontSize: heght * .025)),
                            ))
                        .toList(),
                    onChanged: (val) {
                      hotelsProvider.changeAdultNum(
                          num: val!, roomIndex: index);
                    },
                  ),
                ),
                SizedBox(width: wedth * 0.005),
                SizedBox(
                  width: wedth * 0.105,
                  child: DropdownButtonFormField(
                    itemHeight: null,
                    isExpanded: true,
                    isDense: false,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                          vertical: heght * .000, horizontal: wedth * .005),
                      labelText: 'Child Num',
                      labelStyle: TextStyle(fontSize: heght * .025),
                      border: const OutlineInputBorder(),
                    ),
                    value: hotelsProvider.rooms[index].childNum,
                    items: hotelsProvider.childNumMenu
                        .map((int item) => DropdownMenuItem<int>(
                              value: item,
                              child: Text(item.toString(),
                                  style:
                                      GoogleFonts.lato(fontSize: heght * .025)),
                            ))
                        .toList(),
                    onChanged: (val) {
                      hotelsProvider.changeChildNum(
                          num: val!, roomIndex: index);
                    },
                  ),
                ),
                /*  SizedBox(
                  width: wedth * 0.105,
                  child: DropdownButtonFormField(
                    isExpanded: true,
                    decoration: InputDecoration(
                      labelStyle: TextStyle(fontSize: heght * .035),
                      contentPadding: EdgeInsets.symmetric(horizontal: 5),
                      labelText: 'Room Type',
                      border: OutlineInputBorder(),
                    ),
                    value: hotelsProvider.rooms[index].roomType,
                    items: hotelsProvider.roomTypeMenu
                        .map((String item) => DropdownMenuItem<String>(
                              value: item,
                              child: Text(item,
                                  style:
                                      GoogleFonts.lato(fontSize: heght * .035)),
                            ))
                        .toList(),
                    onChanged: (val) {
                      hotelsProvider.changeRoomType(
                          newType: val!, roomIndex: index);
                    },
                  ),
                ),
            */
                InkWell(
                  onTap: () => hotelsProvider.deleteRoom(index),
                  child: Padding(
                    padding: EdgeInsets.only(left: wedth * .01),
                    child: Icon(
                      Icons.delete,
                      color: Colors.red,
                      size: heght * .045,
                    ),
                  ),
                )

                /*   SizedBox(width: wedth * 0.01),
                const Text(
                  "-",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
                ),
                SizedBox(width: wedth * 0.01),
               hotelsProvider.childNum > 0
                    ? ChildWidget(
                        wedth, heght, hotelsProvider, "Child 1 Age", 0)
                    : Container(color: Colors.white),
                SizedBox(width: wedth * 0.005),
                hotelsProvider.childNum >= 2
                    ? ChildWidget(
                        wedth, heght, hotelsProvider, "Child 2 Age", 1)
                    : Container(color: Colors.white),
                SizedBox(width: wedth * 0.005),
                hotelsProvider.childNum >= 3
                    ? ChildWidget(
                        wedth, heght, hotelsProvider, "Child 3 Age", 2)
                    : Container(color: Colors.white),
                SizedBox(width: wedth * 0.005),
                hotelsProvider.childNum >= 4
                    ? ChildWidget(
                        wedth, heght, hotelsProvider, "Child 4 Age", 3)
                    : Container(
                        color: Colors.white,
                      ),*/
              ],
            )),
      ),
    );
  }
}
