import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:travelagency/Screens/DesktopScreens/DesktopGroupScreen.dart';
import 'package:travelagency/Screens/MobileScreen/MobileHotelScreen.dart';
import 'package:travelagency/Screens/DesktopScreens/DesktopHotelScreen.dart';
import 'package:travelagency/view_model/setting.dart';
import 'Helper/CustomScrollBehavior.dart';
import 'Responsive/responsive_layout.dart';
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
  runApp(TravelAgencyApp());
}

class TravelAgencyApp extends StatelessWidget {
  TravelAgencyApp({Key? key}) : super(key: key);

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
            home: Scaffold(body: DesktopGroupScreen()
                /*Center(
                child: Column(
                  children: [
                    SizedBox(
                      height: 150,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: [
                          SizedBox(
                            width: 10,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [select, select],
                    )
                  ],
                ),
              ),*/
                )
            /* const ResponsiveLayout(
                mobileBody: Scaffold(
                  backgroundColor: Colors.white,
                ),
                tabletBody: DesktopVisaScreen(),
                desktopBody: DesktopVisaScreen())
              const ResponsiveLayout(
                  desktopBody: DesktopHotelScreen(),
                  tabletBody: DesktopHotelScreen(),
                  mobileBody: MobileHotelScreen()),*/
            );
      },
    );
  }

  var select = Container(
    padding: EdgeInsets.only(top: 25, bottom: 10),
    height: 250,
    width: 350,
    decoration: BoxDecoration(
      boxShadow: const [
        BoxShadow(
          color: Color.fromARGB(70, 154, 154, 154),
          blurRadius: 2,
          offset: Offset(-4, 4),
        ),
        BoxShadow(
          color: Color.fromARGB(255, 246, 246, 246),
        ),
      ],
      borderRadius: BorderRadius.circular(25),
    ),
    alignment: Alignment.center,
    child: Column(
      //mainAxisAlignment: MainAxisAlignment.center,
      children: [
        FittedBox(
          child: Text(
            "Select Date",
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            style: GoogleFonts.aBeeZee(
                fontSize: 22,
                letterSpacing: .05,
                fontWeight: FontWeight.bold,
                color: Colors.black),
          ),
        ),
        Divider(
          thickness: 4.2,
          color: Color.fromARGB(25, 158, 158, 158),
        ),
        Container(
          height: 170,
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: InkWell(
                  onTap: () {},
                  onHover: (value) {},
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color.fromARGB(167, 158, 158, 158),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 15),
                    child: Text(
                      "2022-12-30T00:00:00",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.aBeeZee(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(150, 0, 0, 0)),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: InkWell(
                  onTap: () {},
                  onHover: (value) {},
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color.fromARGB(167, 158, 158, 158),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 15),
                    child: Text(
                      "2022-12-30T00:00:00",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.aBeeZee(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(150, 0, 0, 0)),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: InkWell(
                  onTap: () {},
                  onHover: (value) {},
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color.fromARGB(167, 158, 158, 158),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 15),
                    child: Text(
                      "2022-12-30T00:00:00",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.aBeeZee(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(150, 0, 0, 0)),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: InkWell(
                  onTap: () {},
                  onHover: (value) {},
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color.fromARGB(167, 158, 158, 158),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 15),
                    child: Text(
                      "2022-12-30T00:00:00",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.aBeeZee(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(150, 0, 0, 0)),
                    ),
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    ),
  );
}
