import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travelagency/Controller/RoomController.dart';

class ChildWidget extends StatelessWidget {
  double wedth , heght;
  RoomController roomcontroller;
  String text;
  ChildWidget(this.wedth , this.heght , this.roomcontroller , this.text);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: wedth * 0.105,
      height: heght * 0.05,
      child: DropdownButtonFormField(
        isExpanded: true,
        decoration: InputDecoration(
          labelText: text,
          border: OutlineInputBorder(),
        ),
        value: 0,
        items: [0 ,1 ,2 , 3].map((int item) =>
            DropdownMenuItem<int>(
              value: item,
              child: Text(item.toString() , style: GoogleFonts.lato()) ,
            )
        ).toList(),
        onChanged:(val){ roomcontroller.AdultCount.value = val!.toInt();},
      ),);
  }
}
