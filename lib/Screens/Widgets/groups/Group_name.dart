import 'package:flutter/material.dart';

import '../../../Helper/my_theme.dart';
import '../../../Helper/text_style.dart';
import '../../../view_model/group.dart';

class GroupName extends StatelessWidget {
  late String name;
  late double wedth;
  late int groupIndex;
  late GroupsVM groupsProvider;
  late String groupId;
  GroupName(
      {super.key,
      required this.name,
      required this.wedth,
      required this.groupIndex,
      required this.groupsProvider,
      required this.groupId});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      margin: const EdgeInsets.symmetric(horizontal: 15),
      width: wedth * .15,
      decoration: MyThemeData.groupNameDEC(context,
          isSelected: groupsProvider.currentClickedGroupIndex == groupIndex,
          isHovered: groupsProvider.currentHoveredGroupID == groupId),
      child: InkWell(
        onHover: (value) {
          value
              ? groupsProvider.changeGroupHovered(id: groupId)
              : groupsProvider.changeGroupHovered(id: "");
        },
        onTap: () {
          //display dates and hotels
          groupsProvider.changeClickedGroup(groupIndex: groupIndex);
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
}
