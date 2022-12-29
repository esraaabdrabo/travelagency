import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travelagency/Helper/Colors.dart';
import 'package:travelagency/Helper/constants.dart';
import 'package:travelagency/Helper/my_theme.dart';
import 'package:travelagency/Screens/TabletScreen/TabletHotelScreen.dart';
import 'package:travelagency/Responsive/responsive_layout.dart';
import 'package:travelagency/Controller/UserInfoConroller.dart';

import '../MobileScreen/MobileHotelScreen.dart';
import 'DesktopHotelScreen.dart';

class DesktopRegisterScreen extends StatelessWidget {
  const DesktopRegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var heeght = MediaQuery.of(context).size.height;
    var wedth = MediaQuery.of(context).size.width;
    UserInfoController userInfoController = UserInfoController();
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
              image: DecorationImage(
            colorFilter: const ColorFilter.linearToSrgbGamma(),
            image: NetworkImage(Constants.splashImg),
            fit: BoxFit.cover,
          )),
          child: Container(
            decoration:
                BoxDecoration(color: AppColors.offWhiteColor.withOpacity(0.4)),
            child: Center(
              child: Container(
                height: 670,
                width: 500,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: AppColors.whiteColor.withOpacity(0.8),
                  border: Border.all(
                      width: 0.0,
                      color: AppColors.pomegranateColor.withOpacity(0.2),
                      style: BorderStyle.solid),
                  boxShadow: const [
                    BoxShadow(
                      blurRadius: 5.0,
                      color: Colors.black45,
                      blurStyle: BlurStyle.outer,
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Center(
                        child: SvgPicture.asset('assets/images/logo.svg',
                            width: 200, height: 200, fit: BoxFit.fill)),
                    const SizedBox(height: 30),
                    Center(
                      child: SizedBox(
                        width: 280,
                        height: 40,
                        child: TextFormField(
                          onChanged: (String keySearch) {},
                          style: const TextStyle(fontSize: 16.0),
                          decoration: MyThemeData.inputDhintPre(
                            context,
                            icon: const Icon(
                              Icons.person,
                              color: Colors.grey,
                              size: 20,
                            ),
                            label: "Full Name",
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    Center(
                      child: SizedBox(
                        width: 280,
                        height: 40,
                        child: TextFormField(
                          onChanged: (String keySearch) {},
                          style: const TextStyle(fontSize: 16.0),
                          decoration: MyThemeData.inputDhintPre(
                            context,
                            icon: const Icon(
                              Icons.email,
                              color: Colors.grey,
                              size: 20,
                            ),
                            label: "Email",
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    Center(
                      child: SizedBox(
                        width: 280,
                        height: 40,
                        child: TextFormField(
                          onChanged: (String keySearch) {},
                          style: const TextStyle(fontSize: 16.0),
                          decoration: MyThemeData.inputDhintPre(context,
                              icon: const Icon(
                                Icons.phone,
                                color: Colors.grey,
                                size: 20,
                              ),
                              label: "Phone Number"),
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    Center(
                      child: Obx(
                        () => SizedBox(
                          width: 280,
                          child: DropdownButtonFormField(
                            isExpanded: true,
                            decoration: const InputDecoration(
                              filled: true,
                              fillColor: AppColors.offWhiteColor,
                            ),
                            hint: Text('Select Your Nationality',
                                style: GoogleFonts.lato()),
                            value: userInfoController.selectedNationality.value,
                            items: userInfoController.nationalites
                                .map((String item) => DropdownMenuItem<String>(
                                      value: item,
                                      child:
                                          Text(item, style: GoogleFonts.lato()),
                                    ))
                                .toList(),
                            onChanged: (val) {
                              userInfoController.selectedNationality.value =
                                  val.toString();
                            },
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    Center(
                      child: SizedBox(
                        width: 280,
                        height: 40,
                        child: TextFormField(
                            obscureText: true,
                            onChanged: (String keySearch) {},
                            style: const TextStyle(fontSize: 16.0),
                            decoration: MyThemeData.inputDhintPre(context,
                                icon: const Icon(
                                  Icons.lock,
                                  color: Colors.grey,
                                  size: 20,
                                ),
                                label: "Password")),
                      ),
                    ),
                    const SizedBox(height: 30),
                    Center(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.pomegranateColor,
                        ),
                        onPressed: () {
                          Get.to(
                            const ResponsiveLayout(
                                mobileBody: MobileHotelScreen(),
                                tabletBody: TabletHotelScreen(),
                                desktopBody: DesktopHotelScreen()),
                          );
                        },
                        child: SizedBox(
                          width: 250,
                          height: 40,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text("Register",
                                  style: GoogleFonts.poppins(fontSize: 18)),
                              const SizedBox(width: 10),
                              const Icon(
                                Icons.arrow_forward_rounded,
                                size: 16,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
