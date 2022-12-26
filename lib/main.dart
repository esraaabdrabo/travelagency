import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
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

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: "AIzaSyB_obePDd0xaQ08XWSOEFsP34xN39FzgSY",
            authDomain: "travelagency-c84fa.firebaseapp.com",
            projectId: "travelagency-c84fa",
            storageBucket: "travelagency-c84fa.appspot.com",
            messagingSenderId: "918387895834",
            appId: "1:918387895834:web:486f22ba87b021a9082ba3",
            measurementId: "G-VP204YBJ06"));
  } else {
    await Firebase.initializeApp();
  }
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
          home: /* const ResponsiveLayout(
                mobileBody: Scaffold(
                  backgroundColor: Colors.white,
                ),
                tabletBody: DesktopVisaScreen(),
                desktopBody: DesktopVisaScreen())*/
              const ResponsiveLayout(
                  desktopBody: DesktopHotelScreen(),
                  tabletBody: DesktopHotelScreen(),
                  mobileBody: MobileHotelScreen()),
        );
      },
    );
  }
}
