import 'dart:developer';
import 'dart:math' as math;
import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker_web/image_picker_web.dart';
import 'package:travelagency/models/groups/group.dart';
import 'package:travelagency/models/groups/group_reserve.dart';
import 'package:travelagency/services/groups.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class GroupsVM extends ChangeNotifier {
  late AppLocalizations translate;
  bool isLoading = false;
  String currentHoveredGroupID = "";
  String currentHoveredDate = "";
  String currentHoveredHotel = "";
  int currentClickedGroupIndex = 0;
  String currentClickedDate = "";
  String currentClickedHotel = "";
  String clickedReserveType = "One Way";
  List<String> reserveType = ["One Way", "Two Way"];
  List<GroupM> groups = [];

  //////////////////////////////////////////////////////////////
  void changeIsLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }

  GroupsVM() {
    getAllGroups();
  }

  Future<void> getAllGroups() async {
    changeIsLoading(true);
    groups = await GroupsSV().getAllGroups();
    changeIsLoading(false);
  }

  ///****************HOVERED GROUP WILL CHANGE GRADIENT ********** */
  void changeGroupHovered({required String id}) {
    currentHoveredGroupID = id;
    notifyListeners();
  }

  void changeClickedGroup({required int groupIndex}) {
    resetClickedValues();

    currentClickedGroupIndex = groupIndex;
    notifyListeners();
  }

  ///*******************hovered date will take red bg************* */
  void changeHoveredDate({required String date}) {
    currentHoveredDate = date;
    notifyListeners();
  }

  void changeClickedDate({required String dateId}) {
    currentClickedDate = dateId;
    notifyListeners();
  }

  ///*******************hovered date will take red bg************* */
  void changeHoveredHatel({required String hotel}) {
    currentHoveredHotel = hotel;
    notifyListeners();
  }

  void changeClickedHotel({required String hotelId}) {
    currentClickedHotel = hotelId;
    notifyListeners();
  }

  ///*****************reserve hotel*************************//// */
  ///validators
  String removeSpace(String value) {
    return value.replaceAll(" ", "");
  }
  //only numbers

  bool isNumber(String value) {
    return RegExp("[0-9]").hasMatch(value);
  }

  ///name (english + arabic is allowed)
  validateName(String value, BuildContext context) {
    if (RegExp("[a-zA-Z\u0600-\u065F\u066A-\u06EF\u06FA-\u06FF]")
            .hasMatch(value) &&
        removeSpace(value).length >= 5) {
      return null;
    }
    translate = AppLocalizations.of(context)!;
    return "";
  }

//phone
  validatePhone(String value, BuildContext context) {
    if (isNumber(value) && removeSpace(value).length == 11) {
      return null;
    }
    translate = AppLocalizations.of(context)!;
    return "";
  }

//email
  validateEmail(String value, BuildContext context) {
    if (value.contains("@") && removeSpace(value).isNotEmpty) {
      return null;
    }
    translate = AppLocalizations.of(context)!;
    return "";
  }

//date
  validateDate(String value, BuildContext context) {
    if (removeSpace(value).isNotEmpty) {
      return null;
    }

    translate = AppLocalizations.of(context)!;
    return "";
  }

//child num
  validateChildNum(String value, BuildContext context) {
    if (removeSpace(value).isNotEmpty &&
        isNumber(value) &&
        int.parse(removeSpace(value)) >= 0) {
      //only convert to num if you sure the input is number
      if (int.parse(removeSpace(value)) > 0) {
        return null;
      }
    }
    return "error";
  }

  /// ***************search with country**************************** */
  //change selected country
  void changeSelectedCountry(String country) {
    notifyListeners();
  }

//*********reserve hotel**** */ */
  Uint8List? img;
  pickImg() async {
    img = await ImagePickerWeb.getImageAsBytes();
  }

  var userId = "13b545df-f25f-4845-a446-dbc6948133b9";
  GroupReserveM makeReserveObj({
    required String userId,
    required String hotelId,
    required String groupId,
    required String dateTableId,
    required String fullName,
    required String phoneNumber,
    required String email,
    required String reserveType,
    required String note,
  }) {
    return GroupReserveM(
        note: note,
        dateTable: "null",
        hotel: "null",
        user: "null",
        userId: userId,
        hotelId: hotelId,
        groupId: groupId,
        dateTableId: dateTableId,
        fullName: fullName,
        phoneNumber: phoneNumber,
        email: email,
        reserveType: reserveType);
  }

  Future<bool> reserveGroup(
      {required String userId,
      required String fullName,
      required String phoneNumber,
      required String email,
      required String note}) async {
    {
      changeIsLoading(true);
      bool isSuccess = false;
      GroupReserveM reserve = makeReserveObj(
          dateTableId: getDateTableID(),
          reserveType: clickedReserveType,
          groupId: groups[currentClickedGroupIndex].id,
          userId: userId,
          hotelId: currentClickedHotel,
          fullName: fullName,
          phoneNumber: phoneNumber,
          email: email,
          note: note);

      log("will start reserve");
      isSuccess = await GroupsSV().reserveGroup(reserve, img!);
      //reset clicked values

      if (isSuccess) {
        resetClickedValues();
      }
      changeIsLoading(false);
      return isSuccess;
    }
  }

  //********reserve group************* */
  //*******before open the form**** */
  bool canOpenReserveForm() {
    return currentClickedDate != "" && currentClickedHotel != "";
  }

  String getImage() {
    //search fot the clicked hotel to get its image
    int hotelIndex = groups[currentClickedGroupIndex]
        .groupHotels
        .indexWhere((hotel) => hotel.hotelId == currentClickedHotel);
    return groups[currentClickedGroupIndex].groupHotels[hotelIndex].hotelImage;
  }

  String getDateTableID() {
    //search fot the clicked hotel to get its image
    int dateIndex = groups[currentClickedGroupIndex]
        .avilableDates
        .indexWhere((date) => date.avilableDate == currentClickedDate);
    return groups[currentClickedGroupIndex].avilableDates[dateIndex].dateId;
  }

  void resetClickedValues() {
    currentClickedDate = "";
    currentClickedGroupIndex = 0;
    currentClickedHotel = "";
  }
}
