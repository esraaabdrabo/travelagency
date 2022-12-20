import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travelagency/Controller/RoomController.dart';
import 'package:travelagency/Screens/Widgets/ChildWidget.dart';

import '../../Helper/Colors.dart';


class RoomWidget extends StatelessWidget {
  final int? roomindex ;
  double wedth  , heght;
  RoomWidget({ this.roomindex , required this.heght , required this.wedth}) ;

  @override
  Widget build(BuildContext context) {
    final roomController = Get.put(RoomController());
    return Padding(
      padding: EdgeInsets.symmetric(vertical:heght*0.008),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.offWhiteColor.withOpacity(0.5),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical:heght*0.008),
          child: Obx(() => Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("ROOM$roomindex", style: GoogleFonts.lato( fontSize: 32 , fontWeight: FontWeight.w900 , color: AppColors.grayColor )),
              SizedBox(width: wedth * 0.005),
              SizedBox(
                width: wedth * 0.105,
                height: heght * 0.05,
                child: DropdownButtonFormField(
                  isExpanded: true,
                  decoration: InputDecoration(
                    labelText: 'Adult',
                    border: OutlineInputBorder(),
                  ),
                  value: 0,
                  items: [0 ,1 ,2 , 3].map((int item) =>
                      DropdownMenuItem<int>(
                        value: item,
                        child: Text(item.toString() ,style: GoogleFonts.lato()) ,
                      )
                  ).toList(),
                  onChanged:(val){ roomController.AdultCount.value = val!.toInt(); },
                ),
              ),
              SizedBox(width: wedth * 0.005),
              SizedBox(
                width: wedth * 0.105,
                height: heght * 0.05,
                child: DropdownButtonFormField(
                  isExpanded: true,
                  decoration: InputDecoration(
                    labelText: 'Child',
                    border: OutlineInputBorder(),
                  ),
                  value: 0,
                  items: [0 ,1 ,2 , 3].map((int item) =>
                      DropdownMenuItem<int>(
                        value: item,
                        child: Text(item.toString() , style: GoogleFonts.lato()) ,
                      )
                  ).toList(),
                  onChanged:(val){roomController.ChildCount.value = val!.toInt();},
                ),
              ),
              SizedBox(width: wedth * 0.01),
              Text("-" , style: TextStyle(fontWeight: FontWeight.bold ,fontSize: 28),),
              SizedBox(width: wedth * 0.01),
              roomController.ChildCount >0? ChildWidget(wedth, heght, roomController, "Child 1 Age"):Container(color: Colors.white),
              SizedBox(width: wedth * 0.005),
              roomController.ChildCount >=2?ChildWidget(wedth, heght, roomController, "Child 2 Age"):Container(color: Colors.white),
              SizedBox(width: wedth * 0.005),
              roomController.ChildCount >=3?ChildWidget(wedth, heght, roomController, "Child 3 Age"):Container(color:Colors.white),
              SizedBox(width: wedth * 0.005),
              roomController.ChildCount >=4?ChildWidget(wedth, heght, roomController, "Child 4 Age"):Container(color: Colors.white,),
              SizedBox(width: wedth * 0.009),
              IconButton(onPressed: (){}, icon: Icon(Icons.delete , color: Colors.red, size: 32,))
            ],
          )),
        ),
      ),
    );
  }
}
