import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:travelagency/Helper/Colors.dart';
import 'package:travelagency/Helper/my_theme.dart';
import 'package:travelagency/Helper/text_style.dart';
import 'package:travelagency/Screens/Widgets/Drawer.dart';
import 'package:travelagency/Screens/Widgets/widgets.dart';

import '../../view_model/group.dart';

class DesktopGroupScreen extends StatefulWidget {
  const DesktopGroupScreen({Key? key}) : super(key: key);

  @override
  State<DesktopGroupScreen> createState() => _DesktopGroupScreenState();
}

class _DesktopGroupScreenState extends State<DesktopGroupScreen> {
//  final formKey = GlobalKey<FormState>();
//
//  TextEditingController nameCont = TextEditingController();
//  TextEditingController phoneCont = TextEditingController();
//  TextEditingController emailCont = TextEditingController();
//  TextEditingController noteCont = TextEditingController();
//
//  @override
//  void dispose() {
//    super.dispose();
//    nameCont.dispose();
//    phoneCont.dispose();
//    emailCont.dispose();
//    noteCont.dispose();
//  }

  @override
  Widget build(BuildContext context) {
    var wedth = MediaQuery.of(context).size.width;
    var heght = MediaQuery.of(context).size.height;

    final ScrollController _scrollController = ScrollController();
    return ChangeNotifierProvider(
      create: (context) => GroupsVM(),
      builder: (context, child) {
        AppLocalizations translate = AppLocalizations.of(context)!;

        GroupsVM groupsProvider = Provider.of(context);
        return Scaffold(
          body: groupsProvider.isLoading
              ? CustomWidgets.loading
              : Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Expanded(flex: 1, child: CustomDrawer()),
                    Expanded(
                      flex: 4,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: wedth * .01),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                                flex: 1,
                                child: Text("Groups",
                                    style: screenTitle(context))),
                            Expanded(
                              flex: 1,
                              child: SizedBox(
                                  height: heght * 0.5,
                                  child: Stack(
                                    children: [
                                      Container(
                                        margin: EdgeInsets.symmetric(
                                            horizontal: wedth * .05),
                                        child: ListView.builder(
                                            itemCount:
                                                groupsProvider.groups.length,
                                            controller: _scrollController,
                                            scrollDirection: Axis.horizontal,
                                            itemBuilder: (context, index) {
                                              return groupName(
                                                  wedth: wedth,
                                                  groupsProvider:
                                                      groupsProvider,
                                                  name: groupsProvider
                                                      .groups[index]
                                                      .groupNameEn,
                                                  groupId: groupsProvider
                                                      .groups[index].id);
                                            }),
                                      ),
                                      //next and previous country
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.stretch,
                                        children: [
                                          SizedBox(
                                            height: heght * .05,
                                            width: wedth * .05,
                                            child: IconButton(
                                              onPressed: () async {
                                                await Future.delayed(
                                                    const Duration(
                                                        milliseconds: 300));
                                                SchedulerBinding.instance
                                                    .addPostFrameCallback((_) {
                                                  _scrollController.animateTo(
                                                      _scrollController.position
                                                          .minScrollExtent,
                                                      duration: const Duration(
                                                          milliseconds: 300),
                                                      curve:
                                                          Curves.fastOutSlowIn);
                                                });
                                              },
                                              icon: CircleAvatar(
                                                backgroundColor:
                                                    AppColors.pomegranateColor,
                                                radius: 100,
                                                child: Icon(
                                                  Icons.arrow_back_ios_rounded,
                                                  size: wedth * .025,
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: heght * .05,
                                            width: wedth * .05,
                                            child: IconButton(
                                              onPressed: () async {
                                                await Future.delayed(
                                                    const Duration(
                                                        milliseconds: 300));
                                                SchedulerBinding.instance
                                                    .addPostFrameCallback((_) {
                                                  _scrollController.animateTo(
                                                      _scrollController.position
                                                          .maxScrollExtent,
                                                      duration: const Duration(
                                                          milliseconds: 300),
                                                      curve:
                                                          Curves.fastOutSlowIn);
                                                });
                                              },
                                              icon: CircleAvatar(
                                                backgroundColor:
                                                    AppColors.pomegranateColor,
                                                radius: 100,
                                                child: Icon(
                                                  Icons
                                                      .arrow_forward_ios_rounded,
                                                  size: wedth * .025,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  )),
                            ),
                            SizedBox(
                              height: heght * .025,
                            ),
                            Expanded(
                              flex: 6,
                              child: SizedBox(
                                  child: Row(
                                children: [
                                  selectDate(
                                      translate: translate,
                                      heght: heght,
                                      wedth: wedth,
                                      groupProvider: groupsProvider),
                                  SizedBox(
                                    width: wedth * .01,
                                  ),
                                  selectHotel(context,
                                      translate: translate,
                                      heght: heght,
                                      wedth: wedth,
                                      groupProvider: groupsProvider)
                                ],
                              )),
                            ),
                            SizedBox(
                              height: heght * .05,
                            ),
                            SizedBox(
                                height: heght * .1,
                                child: Align(
                                  alignment: Alignment.topRight,
                                  child: MaterialButton(
                                    shape: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(
                                            wedth * .005)),
                                    padding: EdgeInsets.symmetric(
                                        horizontal: wedth * .025,
                                        vertical: heght * .025),
                                    color: AppColors.pomegranateColor,
                                    onPressed: () {},
                                    child: Text(
                                      "Confirm",
                                      style: white15lato(context),
                                    ),
                                  ),
                                ))
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

  groupName(
      {required String name,
      required double wedth,
      required GroupsVM groupsProvider,
      required String groupId}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      margin: const EdgeInsets.symmetric(horizontal: 15),
      width: wedth * .15,
      decoration: MyThemeData.groupNameDEC(context,
          isSelected: groupsProvider.currentHoveredGroupID == groupId),
      child: InkWell(
        onHover: (value) {
          value
              ? groupsProvider.changeGroupHovered(id: groupId)
              : groupsProvider.changeGroupHovered(id: "");
        },
        onTap: () {
          //display dates and hotels
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(name,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                maxLines: 3,
                style: groupNameTS(context,
                    isSelected:
                        groupsProvider.currentHoveredGroupID == groupId)),
          ],
        ),
      ),
    );
  }

  selectDate(
      {required GroupsVM groupProvider,
      required AppLocalizations translate,
      required double wedth,
      required double heght}) {
    return Container(
      padding:
          EdgeInsets.symmetric(horizontal: wedth * .004, vertical: heght * .03),
      height: MediaQuery.of(context).size.height * .5,
      width: wedth * .15,
      decoration: MyThemeData.groupDateHotelDEC(context),
      alignment: Alignment.center,
      child: Column(
        //mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FittedBox(
            child: Text(translate.availableDates,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: GoogleFonts.lato(
                    fontSize: heght * .04, fontWeight: FontWeight.w600)),
          ),
          Container(
            height: MediaQuery.of(context).size.height * .37,
            padding: EdgeInsets.symmetric(horizontal: wedth * .002)
                .copyWith(top: heght * .015),
            child: ListView.builder(
              itemBuilder: (context, dateIndex) => dateContainer(
                  width: wedth,
                  heght: heght,
                  groupsProvider: groupProvider,
                  date: groupProvider
                      .groups[0].avilableDates[dateIndex].avilableDate),
              itemCount: groupProvider.groups[0].avilableDates.length,
            ),
          )
        ],
      ),
    );
  }

  dateContainer(
      {required String date,
      required GroupsVM groupsProvider,
      required double width,
      required double heght}) {
    return InkWell(
      onTap: () {},
      onHover: (value) {
        value
            ? groupsProvider.changeHoveredDate(date: date)
            : groupsProvider.changeHoveredDate(date: "");
      },
      child: Container(
        decoration: BoxDecoration(
          color: groupsProvider.currentHoveredDate == date
              ? AppColors.pomegranateColor.withOpacity(.85)
              : const Color.fromARGB(0, 0, 0, 0),
          borderRadius: BorderRadius.circular(width * .0031),
        ),
        padding: EdgeInsets.symmetric(
            vertical: heght * .01, horizontal: width * .009),
        child: Row(
          children: [
            Icon(
              Icons.calendar_month_outlined,
              size: heght * .04,
              color: groupsProvider.currentHoveredDate != date
                  ? Colors.black
                  : Colors.white,
            ),
            SizedBox(
              width: width * .005,
            ),
            Text(
              "03-2-2023",
              textAlign: TextAlign.center,
              style: GoogleFonts.aBeeZee(
                fontSize: MediaQuery.of(context).size.height * .03,
                fontWeight: FontWeight.bold,
                color: groupsProvider.currentHoveredDate != date
                    ? Colors.black
                    : Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  selectHotel(BuildContext context,
      {required GroupsVM groupProvider,
      required AppLocalizations translate,
      required double wedth,
      required double heght}) {
    return Container(
      padding:
          EdgeInsets.symmetric(horizontal: wedth * .02, vertical: heght * .03),
      height: MediaQuery.of(context).size.height * .5,
      width: wedth * .6,
      decoration: MyThemeData.groupDateHotelDEC(context),
      //alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FittedBox(
            child: Text(translate.availableHotels,
                //   textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: GoogleFonts.lato(
                    fontSize: heght * .04, fontWeight: FontWeight.w600)),
          ),
          Container(
            height: MediaQuery.of(context).size.height * .38,
            padding: EdgeInsets.symmetric(horizontal: wedth * .025)
                .copyWith(top: heght * .03),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: groupProvider.groups[0].groupHotels.length,
              itemBuilder: (context, hotelIndex) => hotelNameContainer(
                  heght: heght,
                  hotelIndex: hotelIndex,
                  wedth: wedth,
                  groupsProvider: groupProvider,
                  name: groupProvider
                      .groups[0].groupHotels[hotelIndex].hotelName),
            ),
          )
        ],
      ),
    );
  }

  hotelNameContainer(
      {required String name,
      required GroupsVM groupsProvider,
      required double wedth,
      required double heght,
      required int hotelIndex}) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: wedth * .008),
        child: InkWell(
          onTap: () {},
          onHover: (value) {
            value
                ? groupsProvider.changeHoveredHatel(date: name)
                : groupsProvider.changeHoveredHatel(date: "");
          },
          child: Container(
            alignment: Alignment.bottomLeft,
            width: wedth * .1,
            decoration: BoxDecoration(
                color: groupsProvider.currentHoveredDate == name
                    ? AppColors.pomegranateColor.withOpacity(.85)
                    : const Color.fromARGB(0, 0, 0, 0),
                borderRadius: BorderRadius.circular(15),
                image: DecorationImage(
                    image: NetworkImage(
                      groupsProvider
                          .groups[0].groupHotels[hotelIndex].hotelImage,
                    ),
                    fit: BoxFit.fill)),
            child: Stack(
              alignment: AlignmentDirectional.bottomEnd,
              children: [
                Container(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [Colors.transparent, Colors.black])),
                ),
                Padding(
                  padding:
                      EdgeInsets.only(left: wedth * .005, bottom: heght * .02),
                  child: Text(
                    name,
                    style: GoogleFonts.aBeeZee(
                        fontSize: MediaQuery.of(context).size.height * .03,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
