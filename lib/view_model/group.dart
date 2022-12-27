import 'dart:developer';
import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker_web/image_picker_web.dart';
import 'package:travelagency/Screens/Widgets/dialogs.dart';
import 'package:travelagency/models/groups/group.dart';
import 'package:travelagency/services/groups.dart';
import 'package:travelagency/services/hotels.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../models/hotel/hotels.dart';
import '../models/hotel/reserve_hotel.dart';
import '../models/hotel/room.dart';

class GroupsVM extends ChangeNotifier {
  late AppLocalizations translate;
  bool isLoading = false;
  String currentHoveredGroupID = "";
  String currentHoveredDate = "";
  String currentHoveredHotel = "";

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

  ///*******************hovered date will take red bg************* */
  void changeHoveredDate({required String date}) {
    currentHoveredDate = date;
    notifyListeners();
  }

  ///*******************hovered date will take red bg************* */
  void changeHoveredHatel({required String date}) {
    currentHoveredDate = date;
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
    return translate.email;
  }

//phone
  validatePhone(String value, BuildContext context) {
    if (isNumber(value) && removeSpace(value).length == 11) {
      return null;
    }
    translate = AppLocalizations.of(context)!;
    return translate.email;
  }

//email
  validateEmail(String value, BuildContext context) {
    if (value.contains("@") && removeSpace(value).isNotEmpty) {
      return null;
    }
    translate = AppLocalizations.of(context)!;
    return translate.email;
  }

//date
  validateDate(String value, BuildContext context) {
    if (removeSpace(value).isNotEmpty) {
      return null;
    }

    translate = AppLocalizations.of(context)!;
    return translate.email;
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
  ReserveHotelM makeReserveObj({
    required String hotelId,
    required String fullName,
    required String phoneNumber,
    required String email,
    required String fromDate,
    required String toDate,
    required String note,
  }) {
    return ReserveHotelM(
        hotelId: hotelId,
        userId: userId,
        fullName: fullName,
        phoneNumber: phoneNumber,
        email: email,
        roomsNumber: rooms.length.toString(),
        room1ChildNumber: rooms[0].childNum.toString(),
        room1AdultNumber: rooms[0].adultNum.toString(),
        room1Type: rooms[0].roomType!,
        fromDate: fromDate,
        toDate: toDate,
        note: note);
  }

  Future<bool> reserveHotel(
      {required String hotelId,
      required String fullName,
      required String phoneNumber,
      required String email,
      required String fromDate,
      required String toDate,
      required String note}) async {
    {
      changeIsLoading(true);
      bool isSuccess = false;
      ReserveHotelM reserve = makeReserveObj(
          hotelId: hotelId,
          fullName: fullName,
          phoneNumber: phoneNumber,
          email: email,
          fromDate: fromDate,
          toDate: toDate,
          note: note);
      log("will start reserve");
      reserve.toJson();
      isSuccess = await HotelsSV().reserveHotel(reserve, img!);
      changeIsLoading(false);
      return isSuccess;
    }
  }
}
