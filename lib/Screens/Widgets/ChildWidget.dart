import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travelagency/view_model/hotels.dart';

// ignore: must_be_immutable
class ChildWidget extends StatelessWidget {
  double wedth, heght;
  HotelsVM hotelsProvider;
  int index;
  String text;
  ChildWidget(
      this.wedth, this.heght, this.hotelsProvider, this.text, this.index,
      {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: wedth * 0.105,
      height: heght * 0.06,
      child: DropdownButtonFormField(
        isExpanded: true,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 7),
          labelText: text,
          border: const OutlineInputBorder(),
        ),
        value: hotelsProvider.childAges[index],
        items: [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15]
            .map((int item) => DropdownMenuItem<int>(
                  value: item,
                  child: Text(item.toString(), style: GoogleFonts.lato()),
                ))
            .toList(),
        onChanged: (val) {
          // hotelsProvider.changeCildAge(index: index, age: val.toString());
        },
      ),
    );
  }
}
