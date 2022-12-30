import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:travelagency/Helper/Colors.dart';
import 'package:travelagency/Helper/my_theme.dart';
import 'package:travelagency/Helper/text_style.dart';
import 'package:travelagency/Screens/Widgets/Drawer.dart';
import 'package:travelagency/Screens/Widgets/groups/confirm_btn.dart';
import 'package:travelagency/Screens/Widgets/groups/hotel_img.dart';
import 'package:travelagency/Screens/Widgets/groups/select_date.dart';
import 'package:travelagency/Screens/Widgets/groups/select_hotel.dart';
import 'package:travelagency/Screens/Widgets/widgets.dart';
import 'package:travelagency/models/groups/group.dart';

import '../../view_model/group.dart';
import '../Widgets/groups/Group_name.dart';

class DesktopGroupScreen extends StatefulWidget {
  const DesktopGroupScreen({Key? key}) : super(key: key);

  @override
  State<DesktopGroupScreen> createState() => _DesktopGroupScreenState();
}

class _DesktopGroupScreenState extends State<DesktopGroupScreen> {
  @override
  Widget build(BuildContext context) {
    var wedth = MediaQuery.of(context).size.width;
    var heght = MediaQuery.of(context).size.height;

    final ScrollController scrollController = ScrollController();
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
                                            controller: scrollController,
                                            scrollDirection: Axis.horizontal,
                                            itemBuilder: (context, index) {
                                              return GroupName(
                                                  groupIndex: index,
                                                  name: groupsProvider
                                                      .groups[index]
                                                      .groupNameEn,
                                                  wedth: wedth,
                                                  groupsProvider:
                                                      groupsProvider,
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
                                                  scrollController.animateTo(
                                                      scrollController.position
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
                                                  scrollController.animateTo(
                                                      scrollController.position
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
                            Expanded(
                              flex: 6,
                              child: Row(
                                children: [
                                  SelectDate(
                                      translate: translate,
                                      heght: heght,
                                      wedth: wedth,
                                      groupProvider: groupsProvider),
                                  SizedBox(
                                    width: wedth * .01,
                                  ),
                                  SelectHotel(
                                      translate: translate,
                                      heght: heght,
                                      wedth: wedth,
                                      groupProvider: groupsProvider)
                                ],
                              ),
                            ),
                            ConfirmBTN(
                              groupsProvider: groupsProvider,
                              translate: translate,
                            )
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
}
