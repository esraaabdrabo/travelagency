import 'dart:developer';
import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:travelagency/Screens/Widgets/dialogs.dart';
import 'package:travelagency/services/hotels.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../models/hotel/hotels.dart';
import '../models/hotel/reserve_hotel.dart';
import '../models/hotel/room.dart';

class HotelsVM extends ChangeNotifier {
  late AppLocalizations translate;
  bool isHotelClickAct = false;
  bool isLoading = false;
  List<HotelM> hotels = [];
  List<HotelM> searchResults = [];
  List<int> childAges = [1, 1, 1, 1];
  int childNum = 0;
  int adultNum = 1;

  //search with country
  List<String> countries = [
    "Jordan",
    "Sudia Arabia",
    "Turkey",
    "Greece",
  ];
  String selectedCountry = '';
  //////////////////////////////////////////////////////////////
  void changeIsLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }

  HotelsVM() {
    //reserveHotel();
    getAllHotels();
    selectedCountry = countries[0];
  }

  Future<void> getAllHotels() async {
    changeIsLoading(true);
    hotels = await HotelsSV().getAllHotels();
    changeIsLoading(false);
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
    if (isNumber(value) && removeSpace(value).length == 12) {
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

//adult num + room num
  validateAdultNum(String value, BuildContext context) {
    if (removeSpace(value).isNotEmpty && isNumber(value)) {
      //only convert to num if you sure the input is number
      if (int.parse(removeSpace(value)) > 0) {
        return null;
      }
    }
    return "error";
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
    selectedCountry = country;
    notifyListeners();
  }
/*
//to take every child age
  void changeCildAge({required int index, required String age}) {
    if (removeSpace(age).isNotEmpty &&
        isNumber(age) &&
        int.parse(removeSpace(age)) >= 0) {
      if (childAges.length > index) {
        childAges.removeAt(index);
      }
      childAges.insert(index, int.parse(age));
      // save the value

      notifyListeners();
    }
    log(childAges.toString());
  }*/

//user can not open the reserve form if he dont fill this

  void checkSearchReq({
    required String inDate,
    required String outDate,
  }) {
    if (removeSpace(inDate).isNotEmpty && removeSpace(outDate).isNotEmpty) {
      isHotelClickAct = true;
      notifyListeners();
    }
  }

  void search(BuildContext context) {
    changeIsLoading(true);
    searchResults = [];
    for (int i = 0; i < hotels.length; i++) {
      if (hotels[i].countryEn!.replaceAll(" ", "").toLowerCase() ==
          selectedCountry.replaceAll(" ", "").toLowerCase()) {
        if (searchResults.indexWhere((hotel) => hotel.name == hotels[i].name) ==
            -1) {
          searchResults.add(hotels[i]);
        }
      }
    }
    searchResults.isEmpty
        ? Dialogs.onlyTextContent(context, "Not found")
        : null;
    changeIsLoading(false);
  }

//*********reserve hotel**** */ */
  Uint8List? img;
  String imgName = "";
  Future<String> pickImg() async {
    //img = await ImagePickerWeb.getImageAsBytes();
    var result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowMultiple: false,
        allowedExtensions: ['jpg', 'png', 'jpeg', 'tiff']);
    img = result!.files[0].bytes;
    imgName = result.files[0].name;

    notifyListeners();
    return imgName;
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

      if (rooms.length > 1) {
        //convert to json (in order to asign values to room2ChildNumber dynamicly )
        Map<String, dynamic> reserveJson = reserve.toJson();
        for (var roomIndex = 1; roomIndex < rooms.length; roomIndex++) {
          reserveJson['room${roomIndex + 1}ChildNumber'] =
              rooms[roomIndex].childNum.toString();
          reserveJson['room${roomIndex + 1}AdultNumber'] =
              rooms[roomIndex].adultNum.toString();
          reserveJson['room${roomIndex + 1}Type'] = rooms[roomIndex].roomType;
        }
        reserve = ReserveHotelM.fromJson(reserveJson);
      }
      log("will start reserve");
      reserve.toJson();
      isSuccess = await HotelsSV().reserveHotel(reserve, img!);
      changeIsLoading(false);
      return isSuccess;
    }
  }

  //**************handle add room *************************/

  RoomM defaultRoom = RoomM(adultNum: 1, childNum: 0, roomType: "SINGLE");
  List<String> roomTypeMenu = ["SINGLE", "DOUBLE", "TRIPEL", "FAMILY"];
  List<int> childNumMenu = [0, 1, 2, 3, 4];
  List<int> adultNumMenu = [1, 2, 3, 4];
//to display roomswith list view
  List<RoomM> rooms = [
    RoomM(adultNum: 1, childNum: 0, roomType: "SINGLE"),
  ];
  void addRoom(BuildContext context) {
    //max rooms number => 6
    if (rooms.length < 6) {
      rooms.add(defaultRoom);
      log(rooms[0].roomType!);
      notifyListeners();
    } else {
      Dialogs.onlyTextContent(context, "Can not add more than 6 rooms");
    }
  }

  void changeAdultNum({required int num, required int roomIndex}) {
    rooms[roomIndex].adultNum = num;
  }

  void changeChildNum({required int num, required int roomIndex}) {
    rooms[roomIndex].childNum = num;
  }

  void changeRoomType({required String newType, required int roomIndex}) {
    rooms[roomIndex].roomType = newType;
  }

  void deleteRoom(int roomIndex) {
    if (rooms.length != 1) {
      rooms.removeAt(roomIndex);
      log("room deleted vm");
      notifyListeners();
    }
  }
}
