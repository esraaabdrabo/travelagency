import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travelagency/Controller/RoomController.dart';

import '../../Helper/Colors.dart';
import '../Widgets/Drawer.dart';
import '../Widgets/RoomWidget.dart';

class TabletHotelScreen extends StatefulWidget {
  const TabletHotelScreen({Key? key}) : super(key: key);

  @override
  State<TabletHotelScreen> createState() => _TabletHotelScreenState();
}

class _TabletHotelScreenState extends State<TabletHotelScreen> {
  final roomController = Get.put(RoomController());
  TextEditingController checkInDateController = TextEditingController();
  TextEditingController checkoutDateController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var wedth = MediaQuery.of(context).size.width; //1536
    var heght = MediaQuery.of(context).size.height;
    List<Widget> roomWidgets = List.generate(
        roomController.RoomCount.value.toInt(),
        (index) => RoomWidget(
//roomindex: index + 1,
              wedth: wedth,
              heght: heght,
            ));

    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      drawer: CustomDrawer(),
    );
  }
}
