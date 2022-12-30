import 'dart:developer';
import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker_web/image_picker_web.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:travelagency/models/visa/visa_cond_count.dart';
import 'package:travelagency/models/visa/visa_countries.dart';
import 'package:travelagency/models/visa/visa_reserve.dart';

import 'package:travelagency/services/visa.dart';

class VisaVM extends ChangeNotifier {
  late AppLocalizations translate;
  bool isHotelClickAct = false;
  bool isLoading = false;
  List<VisaCountriesM> visaCount = [];
  List<VisaConditionCountryM> visaCondCont = [];
  // to show visa type when click on country
  int currentCountry = 0;
  //to navigate between conditions
  int currentVisaType = 0;
  //init for visa type widget isdisappear => when click on count widget make call get visa cond
  bool showConditions = false;
  //////////////////////////////////////////////////////////////
  void changeIsLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }

  VisaVM() {
    // reserveVisa();
    getAllVisa();
  }

  Future<void> getAllVisa() async {
    changeIsLoading(true);
    visaCount = await VisaSV().getAllVisa();
    visaCount.isNotEmpty
        ? onVisaTypeClicked(clickedVisaTypeIndex: 0, firstTimeCalling: true)
        : null;
    changeIsLoading(false);
  }

  Future<void> onVisaTypeClicked(
      {required int clickedVisaTypeIndex,
      required bool firstTimeCalling}) async {
    if (clickedVisaTypeIndex == currentVisaType && !firstTimeCalling) {
    } else {
      currentVisaType = clickedVisaTypeIndex;
      await getCondCount(
        country: visaCount[currentCountry].countryEn!,
        visaType: visaCount[currentCountry].visaType![currentVisaType],
      );
    }
  }

  Future<void> getCondCount(
      {required String country, required String visaType}) async {
    changeIsLoading(true);

    log("start getting vis condition in vm");
    visaCondCont =
        await VisaSV().getCondForCount(country: country, visaType: visaType);
    log(visaCondCont.length.toString());
    changeIsLoading(false);
  }

  ///*******************click on another country***************** */
  Future<void> getVisaForNewCount(
      {required String newCountry, required int newCountIndex}) async {
    if (currentCountry == newCountIndex) {
    } else {
      changeIsLoading(true);
      currentCountry = newCountIndex;
      //call the conditions if the first visa type for new country
      currentVisaType = 0;
      await getCondCount(
          country: newCountry, visaType: visaCount[newCountIndex].visaType![0]);
      changeIsLoading(false);
    }
  }

  ///*****************reserve visa*************************//// */
  String getCountIMG() {
    return visaCount[currentCountry].countryImage!;
  }

  Future<bool> reserveVisa(
      {required String visaId,
      required String userId,
      required String fullName,
      required String phoneNumber,
      required String email,
      required String note}) async {
    var body = VisaReserveM(
        visaId: visaId,
        userId: userId,
        fullName: fullName,
        phoneNumber: phoneNumber,
        email: email,
        note: note);
    /*var body = {
      "visaId": "cf2973e2-564b-4380-bdc0-fbce5f948a91",
      "userId": "3e4ba9aa-878e-4f2d-a780-3c734f03650a",
      "fullName": "esraa",
      "phoneNumber": "07709876543",
      "email": "majdi@Gmail.com",
      "passportImage": "hjgjj",
      "identifyImage": "ghhjh",
      "form": "ffghghh",
      "note": "check  reserve api"
    };*/
    changeIsLoading(true);
    var res = await VisaSV()
        .reserveVisa(body: body, form: pdfFile!, id: idImg!, pass: passImg!);
    changeIsLoading(false);
    log("from visa reserve vm the response : $res");
    return res;
  }

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

  void checkSearchReq(
      {required String inDate,
      required String outDate,
      required String nationality,
      required String currency}) {
    if (removeSpace(inDate).isNotEmpty &&
        removeSpace(outDate).isNotEmpty &&
        removeSpace(nationality).isNotEmpty &&
        removeSpace(currency).isNotEmpty) {
      isHotelClickAct = true;
      notifyListeners();
    }
  }

//*********reserve hotel**** */ */
  Uint8List? passImg;
  Future<void> pickPassImg() async {
    passImg = await ImagePickerWeb.getImageAsBytes();
  }

  Uint8List? idImg;
  Future<void> pickIdImg() async {
    idImg = await ImagePickerWeb.getImageAsBytes();
  }

  Uint8List? pdfFile;
  Future<void> pickPdf() async {
    var result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowMultiple: false,
        allowedExtensions: ['pdf']);
    pdfFile = result!.files[0].bytes;
  }
/*
  ReserveHotelM makeReserveObj(
      {required String hotelId,
      required String fullName,
      required String phoneNumber,
      required String email,
      required String adultNumber,
      required String fromDate,
      required String toDate,
      required String note}) {
    return ReserveHotelM(
        hotelId: hotelId,
        userId: "",
        fullName: fullName,
        phoneNumber: phoneNumber,
        email: email,
        passportImage: "",
        adultNumber: adultNum.toString(),
        childNumber: childNum.toString(),
        fromDate: fromDate,
        toDate: toDate,
        note: note);
  }*/

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
      /* ReserveHotelM reserve = makeReserveObj(
          hotelId: hotelId,
          fullName: fullName,
          phoneNumber: phoneNumber,
          email: email,
          adultNumber: adultNum.toString(),
          fromDate: fromDate,
          toDate: toDate,
          note: note);*/
      log("will start reserve");
      //s  isSuccess = await HotelsSV().reserveHotel(reserve, img!);
      changeIsLoading(false);
      return isSuccess;
    }
  }
}
