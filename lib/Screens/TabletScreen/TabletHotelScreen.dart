import 'package:flutter/material.dart';
import '../../Helper/Colors.dart';
import '../Widgets/Drawer.dart';

class TabletHotelScreen extends StatefulWidget {
  const TabletHotelScreen({Key? key}) : super(key: key);

  @override
  State<TabletHotelScreen> createState() => _TabletHotelScreenState();
}

class _TabletHotelScreenState extends State<TabletHotelScreen> {
  TextEditingController checkInDateController = TextEditingController();
  TextEditingController checkoutDateController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    // var wedth = MediaQuery.of(context).size.width; //1536
    //var heght = MediaQuery.of(context).size.height;
    return const Scaffold(
      backgroundColor: AppColors.whiteColor,
      drawer: CustomDrawer(),
    );
  }
}
