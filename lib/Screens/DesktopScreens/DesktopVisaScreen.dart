import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travelagency/Controller/VisaController.dart';
import 'package:travelagency/Helper/Colors.dart';
import 'package:travelagency/Screens/Widgets/Drawer.dart';
import '../Widgets/PlaceWidget.dart';

class DesktopVisaScreen extends StatefulWidget {
  const DesktopVisaScreen({Key? key}) : super(key: key);

  @override
  State<DesktopVisaScreen> createState() => _DesktopVisaScreenState();
}

class _DesktopVisaScreenState extends State<DesktopVisaScreen> {
  @override
  Widget build(BuildContext context) {
    var wedth = MediaQuery.of(context).size.width;
    var heght = MediaQuery.of(context).size.height;
    final visaController = Get.put(VisaController());

    final ScrollController _scrollController = ScrollController();
    return Scaffold(
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Expanded(flex: 1, child: CustomDrawer()),
          Expanded(
            flex: 4,
            child: Padding(
              padding: const EdgeInsets.only(
                  right: 14.0, left: 14.0, top: 12.0, bottom: 6.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 1,
                    child: Text("VISA",
                        style: GoogleFonts.lato(
                            letterSpacing: 4,
                            color: AppColors.pomegranateColor,
                            fontSize: 36,
                            fontWeight: FontWeight.w900)),
                  ),
                  Expanded(
                    flex: 4,
                    child: SizedBox(
                        width: double.infinity,
                        height: heght * 0.313,
                        child: Stack(
                          children: [
                            ListView(
                              controller: _scrollController,
                              scrollDirection: Axis.horizontal,
                              children: [
                                SizedBox(
                                  width: wedth * 0.011,
                                ),
                                PlaceWidget(
                                    imageLink: "assets/images/iran.jpg",
                                    capitalName: "IRAN"),
                                SizedBox(
                                  width: wedth * 0.011,
                                ),
                                PlaceWidget(
                                    imageLink: "assets/images/istanbul.jpg",
                                    capitalName: "ISTANBUL"),
                                SizedBox(
                                  width: wedth * 0.011,
                                ),
                                PlaceWidget(
                                    imageLink: "assets/images/egypt.jpg",
                                    capitalName: "EGYPT"),
                                SizedBox(
                                  width: wedth * 0.011,
                                ),
                                PlaceWidget(
                                    imageLink: "assets/images/iran.jpg",
                                    capitalName: "IRAN"),
                                SizedBox(
                                  width: wedth * 0.011,
                                ),
                                PlaceWidget(
                                    imageLink: "assets/images/istanbul.jpg",
                                    capitalName: "ISTANBUL"),
                                SizedBox(
                                  width: wedth * 0.011,
                                ),
                                PlaceWidget(
                                    imageLink: "assets/images/egypt.jpg",
                                    capitalName: "EGYPT"),
                                SizedBox(
                                  width: wedth * 0.011,
                                ),
                                PlaceWidget(
                                    imageLink: "assets/images/iran.jpg",
                                    capitalName: "IRAN"),
                                SizedBox(
                                  width: wedth * 0.011,
                                ),
                                PlaceWidget(
                                    imageLink: "assets/images/istanbul.jpg",
                                    capitalName: "ISTANBUL"),
                                SizedBox(
                                  width: wedth * 0.011,
                                ),
                                PlaceWidget(
                                    imageLink: "assets/images/egypt.jpg",
                                    capitalName: "EGYPT"),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                SizedBox(
                                  height: 80,
                                  width: 80,
                                  child: IconButton(
                                    onPressed: () async {
                                      await Future.delayed(
                                          const Duration(milliseconds: 300));
                                      SchedulerBinding.instance
                                          .addPostFrameCallback((_) {
                                        _scrollController.animateTo(
                                            _scrollController
                                                .position.minScrollExtent,
                                            duration: const Duration(
                                                milliseconds: 300),
                                            curve: Curves.fastOutSlowIn);
                                      });
                                    },
                                    icon: const CircleAvatar(
                                      backgroundColor:
                                          AppColors.pomegranateColor,
                                      radius: 100,
                                      child: Icon(Icons.arrow_back_ios_rounded),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 70,
                                  height: 70,
                                  child: IconButton(
                                    onPressed: () async {
                                      await Future.delayed(
                                          const Duration(milliseconds: 300));
                                      SchedulerBinding.instance
                                          .addPostFrameCallback((_) {
                                        _scrollController.animateTo(
                                            _scrollController
                                                .position.maxScrollExtent,
                                            duration: const Duration(
                                                milliseconds: 300),
                                            curve: Curves.fastOutSlowIn);
                                      });
                                    },
                                    icon: const CircleAvatar(
                                      backgroundColor:
                                          AppColors.pomegranateColor,
                                      radius: 100,
                                      child:
                                          Icon(Icons.arrow_forward_ios_rounded),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        )),
                  ),
                  SizedBox(height: heght * 0.04),
                  Expanded(
                      child: ListView(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    children: const [
                      ChoiceChip(
                        label: Text("Medical"),
                        selected: true,
                        selectedColor: AppColors.pomegranateColor,
                      ),
                      ChoiceChip(
                        label: Text("Trade"),
                        selected: false,
                        selectedColor: AppColors.pomegranateColor,
                      ),
                      ChoiceChip(
                        label: Text("Torist"),
                        selected: false,
                        selectedColor: AppColors.pomegranateColor,
                      ),
                    ],
                  )),
                  Expanded(
                    flex: 5,
                    child: Container(
                      height: heght * 0.375,
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 16.0),
                      decoration: BoxDecoration(
                        color: AppColors.offWhiteColor.withOpacity(0.4),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(5)),
                        border: Border.all(
                          width: 0.05,
                          color: AppColors.offWhiteColor,
                          style: BorderStyle.solid,
                        ),
                      ),
                      child: Column(
                        children: [
                          Expanded(
                              flex: 1,
                              child: ListView(
                                scrollDirection: Axis.horizontal,
                                children: [
                                  SizedBox(
                                      width: wedth * 0.150,
                                      child: Text(
                                        "Requirments",
                                        style: GoogleFonts.lato(
                                            fontWeight: FontWeight.bold,
                                            color: AppColors.pomegranateColor,
                                            fontSize: 18),
                                      )),
                                  SizedBox(
                                      width: wedth * 0.150,
                                      child: Text(
                                        "Period",
                                        style: GoogleFonts.lato(
                                            fontWeight: FontWeight.bold,
                                            color: AppColors.pomegranateColor,
                                            fontSize: 18),
                                      )),
                                  SizedBox(
                                      width: wedth * 0.150,
                                      child: Text(
                                        "Price",
                                        style: GoogleFonts.lato(
                                            fontWeight: FontWeight.bold,
                                            color: AppColors.pomegranateColor,
                                            fontSize: 18),
                                      )),
                                  SizedBox(
                                      width: wedth * 0.150,
                                      child: Text(
                                        "Validaity",
                                        style: GoogleFonts.lato(
                                            fontWeight: FontWeight.bold,
                                            color: AppColors.pomegranateColor,
                                            fontSize: 18),
                                      )),
                                  SizedBox(
                                      width: wedth * 0.150,
                                      child: Text(
                                        "Refundable",
                                        style: GoogleFonts.lato(
                                            fontWeight: FontWeight.bold,
                                            color: AppColors.pomegranateColor,
                                            fontSize: 18),
                                      )),
                                ],
                              )),
                          Expanded(
                              flex: 3,
                              child: ListView(
                                scrollDirection: Axis.horizontal,
                                children: [
                                  SizedBox(
                                    height: heght * 0.312,
                                    width: wedth * 0.150,
                                    child: ListView(
                                      children: [
                                        Text(
                                          " - Full Name Including Father and grandfather names",
                                          style: GoogleFonts.lato(
                                              color: AppColors.grayColor,
                                              fontSize: 16),
                                        ),
                                        Text(
                                          " - High resolution passport scan ",
                                          style: GoogleFonts.lato(
                                              color: AppColors.grayColor,
                                              fontSize: 16),
                                        ),
                                        Text(
                                          " - Passport valid at least six months",
                                          style: GoogleFonts.lato(
                                              color: AppColors.grayColor,
                                              fontSize: 16),
                                        ),
                                        Text(
                                          " - Date and place of birth",
                                          style: GoogleFonts.lato(
                                              color: AppColors.grayColor,
                                              fontSize: 16),
                                        ),
                                        Text(
                                          " - Education level",
                                          style: GoogleFonts.lato(
                                              color: AppColors.grayColor,
                                              fontSize: 16),
                                        ),
                                        Text(
                                          " - Occupation",
                                          style: GoogleFonts.lato(
                                              color: AppColors.grayColor,
                                              fontSize: 16),
                                        ),
                                        Text(
                                          " - Reason for visit",
                                          style: GoogleFonts.lato(
                                              color: AppColors.grayColor,
                                              fontSize: 16),
                                        ),
                                        Text(
                                          " - Free to choose the airline",
                                          style: GoogleFonts.lato(
                                              color: AppColors.grayColor,
                                              fontSize: 16),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: heght * 0.312,
                                    width: wedth * 0.150,
                                    child: ListView(
                                      children: [
                                        Text(
                                          "  7-10 working days",
                                          style: GoogleFonts.lato(
                                              color: AppColors.grayColor,
                                              fontSize: 16),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: heght * 0.312,
                                    width: wedth * 0.150,
                                    child: ListView(
                                      children: [
                                        Text(
                                          "- \$50 (minor price : 50\$)",
                                          style: GoogleFonts.lato(
                                              color: AppColors.grayColor,
                                              fontSize: 16),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: heght * 0.312,
                                    width: wedth * 0.150,
                                    child: ListView(
                                      children: [
                                        Text(
                                          "- Free Normal Visa ",
                                          style: GoogleFonts.lato(
                                              color: AppColors.grayColor,
                                              fontSize: 16),
                                        ),
                                        Text(
                                          "- Visa Validaity is 56 days from the days of it\'s issuance",
                                          style: GoogleFonts.lato(
                                              color: AppColors.grayColor,
                                              fontSize: 16),
                                        ),
                                        Text(
                                          "- Duration Of Stay 28 days ",
                                          style: GoogleFonts.lato(
                                              color: AppColors.grayColor,
                                              fontSize: 16),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: heght * 0.312,
                                    width: wedth * 0.150,
                                    child: ListView(
                                      children: [
                                        Text(
                                          "No",
                                          style: GoogleFonts.lato(
                                              color: AppColors.grayColor,
                                              fontSize: 16),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              )),
                          Expanded(
                              flex: 1,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  SizedBox(
                                      width: 100,
                                      height: 40,
                                      child: ElevatedButton(
                                          onPressed: () {},
                                          style: ElevatedButton.styleFrom(
                                              backgroundColor:
                                                  AppColors.pomegranateColor),
                                          child: const Text("Confirm"))),
                                ],
                              )),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
