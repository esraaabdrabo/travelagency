import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../Helper/Colors.dart';
import 'package:get/get.dart';
import '../../Controller/DraweerController.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var wedth = MediaQuery.of(context).size.width;
    var heght = MediaQuery.of(context).size.height;
    final drawerController = Get.put(DraweerController());
    return Drawer(
      backgroundColor: AppColors.whiteColor,
      child: Obx(
        () => Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
                flex: 3,
                child: DrawerHeader(
                    child: SvgPicture.asset('assets/images/logo.svg',
                        width: heght * 0.13,
                        height: heght * 0.13,
                        fit: BoxFit.contain))),
            Expanded(
              flex: 1,
              child: Center(
                child: InkWell(
                  onTap: () {
                    drawerController.select(0);
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 150),
                    decoration: BoxDecoration(
                      color: drawerController.CheckIfSelected(0)
                          ? AppColors.offWhiteColor
                          : Colors.white,
                      border: Border(
                          left: BorderSide(
                        width: 4,
                        color: drawerController.CheckIfSelected(0)
                            ? AppColors.pomegranateColor
                            : Colors.white,
                      )),
                    ),
                    child: ListTile(
                      trailing: drawerController.isSelected.value
                          ? const Text("")
                          : const Text(""),
                      hoverColor: AppColors.grayColor,
                      leading: Icon(
                        Icons.airplane_ticket_outlined,
                        color: drawerController.CheckIfSelected(0)
                            ? AppColors.pomegranateColor
                            : AppColors.grayColor,
                      ),
                      title: Text('VISA',
                          style: GoogleFonts.poppins(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              color: AppColors.grayColor,
                              letterSpacing: 4)),
                      selected: drawerController.CheckIfSelected(0),
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
                    drawerController.select(1);
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 150),
                    decoration: BoxDecoration(
                      color: drawerController.CheckIfSelected(1)
                          ? AppColors.offWhiteColor
                          : Colors.white,
                      border: Border(
                          left: BorderSide(
                        width: 4,
                        color: drawerController.CheckIfSelected(1)
                            ? AppColors.pomegranateColor
                            : Colors.white,
                      )),
                    ),
                    child: ListTile(
                      trailing: drawerController.isSelected.value
                          ? const Text("")
                          : const Text(""),
                      hoverColor: AppColors.grayColor,
                      leading: Icon(
                        Icons.hotel_outlined,
                        color: drawerController.CheckIfSelected(1)
                            ? AppColors.pomegranateColor
                            : AppColors.grayColor,
                      ),
                      title: Text('HOTELS',
                          style: GoogleFonts.poppins(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              color: AppColors.grayColor,
                              letterSpacing: 4)),
                      selected: drawerController.CheckIfSelected(1),
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
                    drawerController.select(2);
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 150),
                    decoration: BoxDecoration(
                      color: drawerController.CheckIfSelected(2)
                          ? AppColors.offWhiteColor
                          : Colors.white,
                      border: Border(
                          left: BorderSide(
                        width: 4,
                        color: drawerController.CheckIfSelected(2)
                            ? AppColors.pomegranateColor
                            : Colors.white,
                      )),
                    ),
                    child: ListTile(
                      trailing: drawerController.isSelected.value
                          ? const Text("")
                          : const Text(""),
                      hoverColor: AppColors.grayColor,
                      leading: Icon(
                        Icons.group_outlined,
                        color: drawerController.CheckIfSelected(2)
                            ? AppColors.pomegranateColor
                            : AppColors.grayColor,
                      ),
                      title: Text('GROUP',
                          style: GoogleFonts.poppins(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              color: AppColors.grayColor,
                              letterSpacing: 4)),
                      selected: drawerController.CheckIfSelected(2),
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
                    drawerController.select(3);
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 150),
                    decoration: BoxDecoration(
                      color: drawerController.CheckIfSelected(3)
                          ? AppColors.offWhiteColor
                          : Colors.white,
                      border: Border(
                          left: BorderSide(
                        width: 4,
                        color: drawerController.CheckIfSelected(3)
                            ? AppColors.pomegranateColor
                            : Colors.white,
                      )),
                    ),
                    child: ListTile(
                      trailing: drawerController.isSelected.value
                          ? const Text("")
                          : const Text(""),
                      hoverColor: AppColors.grayColor,
                      leading: Icon(
                        Icons.info_outline_rounded,
                        color: drawerController.CheckIfSelected(3)
                            ? AppColors.pomegranateColor
                            : AppColors.grayColor,
                      ),
                      title: Text('ABOUT US',
                          style: GoogleFonts.poppins(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              color: AppColors.grayColor,
                              letterSpacing: 4)),
                      selected: drawerController.CheckIfSelected(3),
                    ),
                  ),
                ),
              ),
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
                    drawerController.select(4);
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 150),
                    decoration: BoxDecoration(
                      color: drawerController.CheckIfSelected(4)
                          ? AppColors.offWhiteColor
                          : Colors.white,
                      border: Border(
                          left: BorderSide(
                        width: 4,
                        color: drawerController.CheckIfSelected(4)
                            ? AppColors.pomegranateColor
                            : Colors.white,
                      )),
                    ),
                    child: ListTile(
                      trailing: drawerController.isSelected.value
                          ? const Text("")
                          : const Text(""),
                      hoverColor: AppColors.grayColor,
                      leading: Icon(
                        Icons.logout,
                        color: drawerController.CheckIfSelected(4)
                            ? AppColors.pomegranateColor
                            : AppColors.grayColor,
                      ),
                      title: Text('LOG OUT',
                          style: GoogleFonts.poppins(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              color: AppColors.grayColor,
                              letterSpacing: 4)),
                      selected: drawerController.CheckIfSelected(4),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
