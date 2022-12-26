import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:travelagency/Helper/text_style.dart';
import 'package:travelagency/view_model/setting.dart';
import '../../Helper/Colors.dart';
import 'package:get/get.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SettingVM settingProvider = Provider.of(context);
    var width = MediaQuery.of(context).size.width;
    var hight = MediaQuery.of(context).size.height;
    return Drawer(
      backgroundColor: AppColors.whiteColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
              flex: 3,
              child: DrawerHeader(
                  child: SvgPicture.asset('assets/images/logo.svg',
                      width: hight * 0.13,
                      height: hight * 0.13,
                      fit: BoxFit.contain))),
          Expanded(
            flex: 1,
            child: Center(
              child: InkWell(
                onTap: () {
                  settingProvider.select(0, context);
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 150),
                  decoration: BoxDecoration(
                    color: settingProvider.checkIfSelected(0)
                        ? AppColors.offWhiteColor
                        : Colors.white,
                    border: Border(
                        left: BorderSide(
                      width: 4,
                      color: settingProvider.checkIfSelected(0)
                          ? AppColors.pomegranateColor
                          : Colors.white,
                    )),
                  ),
                  child: ListTile(
                    trailing: settingProvider.isSelected
                        ? const Text("")
                        : const Text(""),
                    hoverColor: AppColors.grayColor,
                    leading: Icon(
                      Icons.airplane_ticket_outlined,
                      color: settingProvider.checkIfSelected(0)
                          ? AppColors.pomegranateColor
                          : AppColors.grayColor,
                    ),
                    title: Text('VISA',
                        style: GoogleFonts.poppins(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            color: AppColors.grayColor,
                            letterSpacing: 4)),
                    selected: settingProvider.checkIfSelected(0),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Center(
              child: InkWell(
                onTap: () {
                  settingProvider.select(1, context);
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 150),
                  decoration: BoxDecoration(
                    color: settingProvider.checkIfSelected(1)
                        ? AppColors.offWhiteColor
                        : Colors.white,
                    border: Border(
                        left: BorderSide(
                      width: 4,
                      color: settingProvider.checkIfSelected(1)
                          ? AppColors.pomegranateColor
                          : Colors.white,
                    )),
                  ),
                  child: ListTile(
                    trailing: settingProvider.isSelected
                        ? const Text("")
                        : const Text(""),
                    hoverColor: AppColors.grayColor,
                    leading: Icon(
                      Icons.hotel_outlined,
                      color: settingProvider.checkIfSelected(1)
                          ? AppColors.pomegranateColor
                          : AppColors.grayColor,
                    ),
                    title: Text('HOTELS',
                        style: GoogleFonts.poppins(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            color: AppColors.grayColor,
                            letterSpacing: 4)),
                    selected: settingProvider.checkIfSelected(1),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Center(
              child: InkWell(
                onTap: () {
                  settingProvider.select(2, context);
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 150),
                  decoration: BoxDecoration(
                    color: settingProvider.checkIfSelected(2)
                        ? AppColors.offWhiteColor
                        : Colors.white,
                    border: Border(
                        left: BorderSide(
                      width: 4,
                      color: settingProvider.checkIfSelected(2)
                          ? AppColors.pomegranateColor
                          : Colors.white,
                    )),
                  ),
                  child: ListTile(
                    trailing: settingProvider.isSelected
                        ? const Text("")
                        : const Text(""),
                    hoverColor: AppColors.grayColor,
                    leading: Icon(
                      Icons.group_outlined,
                      color: settingProvider.checkIfSelected(2)
                          ? AppColors.pomegranateColor
                          : AppColors.grayColor,
                    ),
                    title: Text('GROUP',
                        style: GoogleFonts.poppins(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            color: AppColors.grayColor,
                            letterSpacing: 4)),
                    selected: settingProvider.checkIfSelected(2),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Center(
              child: InkWell(
                onTap: () {
                  settingProvider.select(3, context);
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 150),
                  decoration: BoxDecoration(
                    color: settingProvider.checkIfSelected(3)
                        ? AppColors.offWhiteColor
                        : Colors.white,
                    border: Border(
                        left: BorderSide(
                      width: 4,
                      color: settingProvider.checkIfSelected(3)
                          ? AppColors.pomegranateColor
                          : Colors.white,
                    )),
                  ),
                  child: ListTile(
                    trailing: settingProvider.isSelected
                        ? const Text("")
                        : const Text(""),
                    hoverColor: AppColors.grayColor,
                    leading: Icon(
                      Icons.info_outline_rounded,
                      color: settingProvider.checkIfSelected(3)
                          ? AppColors.pomegranateColor
                          : AppColors.grayColor,
                    ),
                    title: Text('ABOUT US',
                        style: GoogleFonts.poppins(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            color: AppColors.grayColor,
                            letterSpacing: 4)),
                    selected: settingProvider.checkIfSelected(3),
                  ),
                ),
              ),
            ),
          ),
          Row(
            children: [
              //arabic lang
              lang(
                  settingProvider: settingProvider,
                  newLang: "ar",
                  title: "لغة عربية") //english lang
              ,
              lang(
                  settingProvider: settingProvider,
                  newLang: "en",
                  title: "English") //english lang
            ],
          ),
          Expanded(
              flex: 4,
              child: Container(
                  color: AppColors.whiteColor, child: const Text(""))),
          Expanded(
            flex: 1,
            child: Center(
              child: InkWell(
                onTap: () {
                  settingProvider.select(4, context);
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 150),
                  decoration: BoxDecoration(
                    color: settingProvider.checkIfSelected(4)
                        ? AppColors.offWhiteColor
                        : Colors.white,
                    border: Border(
                        left: BorderSide(
                      width: 4,
                      color: settingProvider.checkIfSelected(4)
                          ? AppColors.pomegranateColor
                          : Colors.white,
                    )),
                  ),
                  child: ListTile(
                    trailing: settingProvider.isSelected
                        ? const Text("")
                        : const Text(""),
                    hoverColor: AppColors.grayColor,
                    leading: Icon(
                      Icons.logout,
                      color: settingProvider.checkIfSelected(4)
                          ? AppColors.pomegranateColor
                          : AppColors.grayColor,
                    ),
                    title: Text('LOG OUT',
                        style: GoogleFonts.poppins(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            color: AppColors.grayColor,
                            letterSpacing: 4)),
                    selected: settingProvider.checkIfSelected(4),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  lang(
      {required SettingVM settingProvider,
      required String newLang,
      required String title}) {
    return Expanded(
      flex: 1,
      child: Center(
        child: InkWell(
          onTap: () {
            settingProvider.changeLang(newLang);
          },
          child: AnimatedContainer(
              padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 20),
              duration: const Duration(milliseconds: 150),
              decoration: BoxDecoration(
                color: settingProvider.currentLang == newLang
                    ? AppColors.offWhiteColor
                    : Colors.white,
                border: Border(
                    left: BorderSide(
                  width: 4,
                  color: settingProvider.currentLang == newLang
                      ? AppColors.pomegranateColor
                      : Colors.white,
                )),
              ),
              child: Text(
                title,
                style: black15lato,
              )),
        ),
      ),
    );
  }
}
