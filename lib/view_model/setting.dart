import 'package:flutter/material.dart';
import 'package:travelagency/Responsive/responsive_layout.dart';
import 'package:travelagency/Screens/DesktopScreens/DesktopGroupScreen.dart';

import '../Screens/DesktopScreens/DesktopHotelScreen.dart';
import '../Screens/DesktopScreens/DesktopVisaScreen.dart';
import '../Screens/MobileScreen/MobileHotelScreen.dart';
import '../Screens/MobileScreen/MobileVisaScreen.dart';
import '../Screens/TabletScreen/TabletVisaScreen.dart';

class SettingVM extends ChangeNotifier {
  //*********current screen**** */
  int indexselected = 0;
  bool isSelected = false;
  void select(int index, BuildContext context) {
    indexselected = index;
    if (index == 0) {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => const ResponsiveLayout(
                  mobileBody: MobileVisaScreen(),
                  tabletBody: TabletVisaScreen(),
                  desktopBody: DesktopVisaScreen())));
    } else if (index == 1) {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const ResponsiveLayout(
                desktopBody: DesktopHotelScreen(),
                tabletBody: DesktopHotelScreen(),
                mobileBody: MobileHotelScreen()),
          ));
    } else if (index == 2) {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const ResponsiveLayout(
                desktopBody: DesktopGroupScreen(),
                tabletBody: DesktopGroupScreen(),
                mobileBody: DesktopGroupScreen()),
          ));
    }
  }

//to make drawer section have red border////
  bool checkIfSelected(index) {
    if (indexselected != index) {
      return false;
    } else {
      return true;
    }
  }

  //*********language********* */
  String currentLang = "en";
  void changeLang(String newLang) {
    if (newLang == currentLang) {
    } else {
      currentLang = newLang;
      notifyListeners();
    }
  }
}
