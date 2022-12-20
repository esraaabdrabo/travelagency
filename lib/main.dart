import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travelagency/Screens/DesktopScreens/DesktopVisaScreen.dart';
import 'package:travelagency/Screens/MobileScreen/MobileHotelScreen.dart';
import 'package:travelagency/Screens/TabletScreen/TabletHotelScreen.dart';
import 'package:travelagency/Screens/DesktopScreens/DesktopHotelScreen.dart';
import 'package:travelagency/Screens/DesktopScreens/DesktopRegisterScreen.dart';
import 'Helper/CustomScrollBehavior.dart';
import 'Screens/DesktopScreens/DesktopSplashScreen.dart';
import 'Responsive/responsive_layout.dart';
import 'Screens/MobileScreen/MobileVisaScreen.dart';
import 'Screens/TabletScreen/TabletVisaScreen.dart';

void main() {
  runApp(const TravelAgencyApp());
}

class TravelAgencyApp extends StatelessWidget {
  const TravelAgencyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      scrollBehavior: MyCustomScrollBehavior(),
      debugShowCheckedModeBanner: false,
      title: "Travel Agency",
      home: const ResponsiveLayout(
          desktopBody: DesktopHotelScreen(),
          tabletBody: TabletHotelScreen(),
          mobileBody: MobileHotelScreen()),
      getPages: [
        GetPage(name: "/", page: () => const DesktopRegisterScreen()),
        GetPage(
          name: "/HotelScreen",
          page: () => const ResponsiveLayout(
              desktopBody: DesktopHotelScreen(),
              tabletBody: TabletHotelScreen(),
              mobileBody: MobileHotelScreen()),
        ),
        GetPage(
            name: "/VisaScreen",
            page: () => const ResponsiveLayout(
                mobileBody: MobileVisaScreen(),
                tabletBody: TabletVisaScreen(),
                desktopBody: DesktopVisaScreen()))
      ],
    );
  }
}
/**
 * {"guid":"20b742a9-b354-44fb-a37e-525c83923fe2",
 * "name":"Five Jumeirah Village",
 * "image":"https://cf.bstatic.com/xdata/images/hotel/max1024x768/213805317.jpg?k=1d31525a3a565f11ed6f43394f9a131cee10734a150719956900b2c5fd8e2b0e&o=&hp=1",
 * "locationEn":"UAE",
 * "locationAr":"ألامارات ألعربيه ألمتحده",
 * "sngPrice":99,"dblPrice":180,"trplPrice":220,"fmlyPrice":null,
 * "users":null}
 */