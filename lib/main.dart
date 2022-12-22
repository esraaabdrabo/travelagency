import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:travelagency/Screens/DesktopScreens/DesktopVisaScreen.dart';
import 'package:travelagency/Screens/MobileScreen/MobileHotelScreen.dart';
import 'package:travelagency/Screens/TabletScreen/TabletHotelScreen.dart';
import 'package:travelagency/Screens/DesktopScreens/DesktopHotelScreen.dart';
import 'package:travelagency/Screens/DesktopScreens/DesktopRegisterScreen.dart';
import 'package:travelagency/view_model/setting.dart';
import 'Helper/CustomScrollBehavior.dart';
import 'Screens/DesktopScreens/DesktopSplashScreen.dart';
import 'Responsive/responsive_layout.dart';
import 'Screens/MobileScreen/MobileVisaScreen.dart';
import 'Screens/TabletScreen/TabletVisaScreen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() {
  runApp(const TravelAgencyApp());
}

class TravelAgencyApp extends StatelessWidget {
  const TravelAgencyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => SettingVM(),
      builder: (context, child) {
        SettingVM settingProvider = Provider.of(context);
        return GetMaterialApp(
          localizationsDelegates: const [
            AppLocalizations.delegate, // Add this line
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('en', ''),
            Locale('ar', ''),
          ],
          locale: Locale(settingProvider.currentLang),
          scrollBehavior: MyCustomScrollBehavior(),
          debugShowCheckedModeBanner: false,
          title: "Travel Agency",
          home: const ResponsiveLayout(
              desktopBody: DesktopHotelScreen(),
              tabletBody: DesktopHotelScreen(),
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
      },
    );
  }
}
