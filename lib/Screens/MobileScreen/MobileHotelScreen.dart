import 'package:flutter/material.dart';

import '../../Helper/Colors.dart';
import '../Widgets/Drawer.dart';

class MobileHotelScreen extends StatefulWidget {
  const MobileHotelScreen({Key? key}) : super(key: key);

  @override
  State<MobileHotelScreen> createState() => _MobileHotelScreenState();
}

class _MobileHotelScreenState extends State<MobileHotelScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        backgroundColor: AppColors.pomegranateColor,
      ),
      drawer: const CustomDrawer(),
    );
  }
}
