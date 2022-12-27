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
import 'package:travelagency/models/groups/group.dart';
import 'package:travelagency/view_model/visa.dart';

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
                        padding: const EdgeInsets.only(
                            right: 14.0, left: 14.0, top: 12.0, bottom: 6.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 1,
                              child: Text("Groups",
                                  style: GoogleFonts.lato(
                                      letterSpacing: 4,
                                      color: AppColors.pomegranateColor,
                                      fontSize: 36,
                                      fontWeight: FontWeight.w900)),
                            ),
                            Expanded(
                              flex: 2,
                              child: SizedBox(
                                  height: heght * 0.28,
                                  child: Stack(
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 80),
                                        child: ListView.builder(
                                            itemCount:
                                                groupsProvider.groups.length,
                                            controller: _scrollController,
                                            scrollDirection: Axis.horizontal,
                                            itemBuilder: (context, index) {
                                              return groupName(
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
                                            height: 80,
                                            width: 80,
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
                                              icon: const CircleAvatar(
                                                backgroundColor:
                                                    AppColors.pomegranateColor,
                                                radius: 100,
                                                child: Icon(Icons
                                                    .arrow_back_ios_rounded),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 70,
                                            height: 70,
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
                            Expanded(
                              flex: 4,
                              child: SizedBox(
                                  child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  selectDate(groupProvider: groupsProvider),
                                  selectHotel(groupProvider: groupsProvider)
                                ],
                              )),
                            ),
                            Expanded(flex: 1, child: Text("data"))
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
      required GroupsVM groupsProvider,
      required String groupId}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      margin: const EdgeInsets.only(right: 15, bottom: 15),
      width: 200,
      decoration: MyThemeData.groupNameDEC(
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
                style: groupNameTS(
                    isSelected:
                        groupsProvider.currentHoveredGroupID == groupId)),
            const Divider(
              endIndent: 50,
              indent: 50,
              color: Colors.white,
            )
          ],
        ),
      ),
    );
  }

  selectDate({required GroupsVM groupProvider}) {
    return Container(
      padding: const EdgeInsets.only(top: 25, bottom: 10),
      height: 250,
      width: 350,
      decoration: MyThemeData.groupDateHotelDEC(),
      alignment: Alignment.center,
      child: Column(
        //mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FittedBox(
            child: Text("Date",
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: black22AbeezeTS),
          ),
          const Divider(
            thickness: 4.2,
            color: Color.fromARGB(25, 158, 158, 158),
          ),
          Container(
            height: 170,
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: ListView.builder(
              itemBuilder: (context, dateIndex) => dateContainer(
                  groupsProvider: groupProvider,
                  date: groupProvider.groups[0].avilableDates[dateIndex]),
              itemCount: groupProvider.groups[0].avilableDates.length,
            ),
          )
        ],
      ),
    );
  }

  dateContainer({required String date, required GroupsVM groupsProvider}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: InkWell(
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
                : Color.fromARGB(33, 0, 0, 0),
            borderRadius: BorderRadius.circular(15),
          ),
          padding: const EdgeInsets.symmetric(vertical: 15),
          child: Text(
            date,
            textAlign: TextAlign.center,
            style: GoogleFonts.aBeeZee(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: groupsProvider.currentHoveredDate != date
                  ? const Color.fromARGB(150, 0, 0, 0)
                  : Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  selectHotel({required GroupsVM groupProvider}) {
    return Container(
      padding: const EdgeInsets.only(top: 25, bottom: 10),
      height: 250,
      width: 350,
      decoration: MyThemeData.groupDateHotelDEC(),
      alignment: Alignment.center,
      child: Column(
        //mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FittedBox(
            child: Text("Hotel Name",
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: black22AbeezeTS),
          ),
          const Divider(
            thickness: 4.2,
            color: Color.fromARGB(25, 158, 158, 158),
          ),
          Container(
            height: 170,
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: ListView.builder(
              itemCount: groupProvider.groups[0].groupHotels.length,
              itemBuilder: (context, hotelNameIndex) => hotelNameContainer(
                  groupsProvider: groupProvider,
                  name: groupProvider.groups[0].groupHotels[hotelNameIndex]),
            ),
          )
        ],
      ),
    );
  }

  hotelNameContainer({required String name, required GroupsVM groupsProvider}) {
    return Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: InkWell(
          onTap: () {},
          onHover: (value) {
            value
                ? groupsProvider.changeHoveredHatel(date: name)
                : groupsProvider.changeHoveredHatel(date: "");
          },
          child: Container(
            decoration: BoxDecoration(
              color: groupsProvider.currentHoveredDate == name
                  ? AppColors.pomegranateColor.withOpacity(.85)
                  : Color.fromARGB(33, 0, 0, 0),
              borderRadius: BorderRadius.circular(15),
            ),
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: Text(
              name,
              textAlign: TextAlign.center,
              style: GoogleFonts.aBeeZee(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: groupsProvider.currentHoveredDate != name
                    ? const Color.fromARGB(150, 0, 0, 0)
                    : Colors.white,
              ),
            ),
          ),
        ));
  }
}
