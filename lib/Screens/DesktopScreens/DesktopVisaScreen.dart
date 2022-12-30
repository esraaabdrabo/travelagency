import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:travelagency/Helper/Colors.dart';
import 'package:travelagency/Helper/text_style.dart';
import 'package:travelagency/Screens/Widgets/Drawer.dart';
import 'package:travelagency/Screens/Widgets/visa/confirm_btn.dart';
import 'package:travelagency/Screens/Widgets/widgets.dart';
import 'package:travelagency/view_model/visa.dart';
import '../../Helper/my_theme.dart';
import '../Widgets/PlaceWidget.dart';

class DesktopVisaScreen extends StatefulWidget {
  const DesktopVisaScreen({Key? key}) : super(key: key);

  @override
  State<DesktopVisaScreen> createState() => _DesktopVisaScreenState();
}

class _DesktopVisaScreenState extends State<DesktopVisaScreen> {
  final formKey = GlobalKey<FormState>();

  TextEditingController nameCont = TextEditingController();
  TextEditingController phoneCont = TextEditingController();
  TextEditingController emailCont = TextEditingController();
  TextEditingController noteCont = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    nameCont.dispose();
    phoneCont.dispose();
    emailCont.dispose();
    noteCont.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var wedth = MediaQuery.of(context).size.width;
    var heght = MediaQuery.of(context).size.height;

    final ScrollController _scrollController = ScrollController();
    return ChangeNotifierProvider(
      create: (context) => VisaVM(),
      builder: (context, child) {
        AppLocalizations translate = AppLocalizations.of(context)!;

        VisaVM visaProvider = Provider.of(context);
        return Scaffold(
          body: visaProvider.isLoading
              ? CustomWidgets.loading
              : Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Expanded(flex: 1, child: CustomDrawer()),
                    Expanded(
                      flex: 4,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: heght * .001, horizontal: wedth * .01),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                                flex: 1,
                                child:
                                    Text("VISA", style: screenTitle(context))),
                            SizedBox(
                              height: heght * .025,
                            ),
                            //countery img
                            Expanded(
                              flex: 5,
                              child: SizedBox(
                                  child: Stack(
                                children: [
                                  ListView.builder(
                                    itemCount: visaProvider.visaCount.length,
                                    controller: _scrollController,
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, index) =>
                                        PlaceWidget(
                                            countIndex: index,
                                            imageLink: visaProvider
                                                .visaCount[index].countryImage!,
                                            capitalName: visaProvider
                                                .visaCount[index].countryEn!),
                                  ),
                                  //next and previous country
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      SizedBox(
                                        height: 80,
                                        width: 80,
                                        child: IconButton(
                                          onPressed: () async {
                                            await Future.delayed(const Duration(
                                                milliseconds: 300));
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
                                            child: Icon(
                                                Icons.arrow_back_ios_rounded),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 70,
                                        height: 70,
                                        child: IconButton(
                                          onPressed: () async {
                                            await Future.delayed(const Duration(
                                                milliseconds: 300));
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
                                            child: Icon(Icons
                                                .arrow_forward_ios_rounded),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              )),
                            ),
                            SizedBox(height: heght * 0.04),
                            //visa type btn => trade medical
                            Expanded(
                                child: ListView.builder(
                              itemCount: visaProvider
                                  .visaCount[visaProvider.currentCountry]
                                  .visaType!
                                  .length,
                              itemBuilder: (context, index) => visaType(
                                  wedth, heght,
                                  visaProvider: visaProvider,
                                  visaTypeIndex: index),
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                            )),
                            //bottom sction contain visa type and conditions
                            Expanded(
                              flex: 5,
                              child: Container(
                                height: heght * 0.375,
                                width: double.infinity,
                                padding: EdgeInsets.symmetric(
                                        vertical: heght * 0.003,
                                        horizontal: wedth * .005)
                                    .copyWith(bottom: 0),
                                decoration: BoxDecoration(
                                  color:
                                      AppColors.offWhiteColor.withOpacity(0.4),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(5)),
                                  border: Border.all(
                                    width: 0.05,
                                    color: AppColors.offWhiteColor,
                                    style: BorderStyle.solid,
                                  ),
                                ),
                                child: Column(
                                  children: [
                                    Expanded(
                                        flex: 5,
                                        child: ListView.builder(
                                          itemCount:
                                              visaProvider.visaCondCont.length,
                                          itemBuilder: (context,
                                                  conditionIndex) =>
                                              condition(
                                                  wedth: wedth,
                                                  height: heght,
                                                  visaProvider: visaProvider,
                                                  conditionIndex:
                                                      conditionIndex),
                                          scrollDirection: Axis.horizontal,
                                        )),
                                    ConfirmBtnVisa(
                                        visaProvider: visaProvider,
                                        translate: translate)
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
      },
    );
  }

  visaType(double width, double height,
      {required VisaVM visaProvider, required int visaTypeIndex}) {
    return InkWell(
      onTap: () {
        visaProvider.onVisaTypeClicked(
            clickedVisaTypeIndex: visaTypeIndex, firstTimeCalling: false);
      },
      child: Padding(
        padding: EdgeInsets.only(right: width * .005),
        child: ChoiceChip(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(width * .005)),
          padding: EdgeInsets.symmetric(
              vertical: height * .005, horizontal: width * .015),
          label: Text(
              visaProvider.visaCount[visaProvider.currentCountry]
                  .visaType![visaTypeIndex],
              style: white15lato(context)),
          labelStyle: TextStyle(color: Colors.white),
          selected: visaProvider.currentVisaType == visaTypeIndex,
          selectedColor: AppColors.pomegranateColor,
        ),
      ),
    );
  }

  conditionName(
      {required double wedth,
      required double hight,
      required String condition,
      required int conditionIndex}) {
    return SizedBox(
        width: wedth * .15,
        child: Text(
          condition,
          style: GoogleFonts.lato(
              fontWeight: FontWeight.bold,
              color: AppColors.pomegranateColor,
              fontSize: hight * .035),
        ));
  }

  condition(
      {required double wedth,
      required double height,
      required VisaVM visaProvider,
      required int conditionIndex}) {
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          //condition name
          conditionName(
              hight: height,
              condition:
                  visaProvider.visaCondCont[conditionIndex].conditionCategory!,
              wedth: wedth,
              conditionIndex: conditionIndex),
          SizedBox(
            height: height * .008,
          ),
          SizedBox(
            height: height * 0.24,
            width: wedth * .15,
            child: ListView.separated(
              separatorBuilder: (context, index) => const Divider(),
              itemCount:
                  visaProvider.visaCondCont[conditionIndex].conditions!.length,
              itemBuilder: (context, index) {
                return conditionContent(
                    haveDollar: visaProvider
                                .visaCondCont[conditionIndex].conditionCategory!
                                .toLowerCase() ==
                            "price"
                        ? true
                        : false,
                    hight: height,
                    index: index,
                    content: visaProvider
                        .visaCondCont[conditionIndex].conditions![index]);
              },
            ),
          ),
        ],
      ),
    );
  }

  conditionContent(
      {required String content,
      required int index,
      required bool haveDollar,
      required double hight}) {
    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: Text(
        !haveDollar ? "- $content" : "- $content \$",
        style:
            GoogleFonts.lato(color: AppColors.grayColor, fontSize: hight * .03),
      ),
    );
  }
}
