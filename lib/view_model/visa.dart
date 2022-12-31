import 'dart:developer';
import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';
import 'package:file_saver/file_saver.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:travelagency/Screens/Widgets/dialogs.dart';
import 'package:travelagency/models/visa/visa_cond_count.dart';
import 'package:travelagency/models/visa/visa_countries.dart';
import 'package:travelagency/models/visa/visa_reserve.dart';

import 'package:travelagency/services/visa.dart';

class VisaVM extends ChangeNotifier {
  late AppLocalizations translate;
  bool isHotelClickAct = false;
  bool isLoading = false;
  bool isVisaTypeLoading = false;

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
    // changeIsLoading(true);
    log("start getting vis condition in vm");
    visaCondCont =
        await VisaSV().getCondForCount(country: country, visaType: visaType);
    log(visaCondCont.length.toString());
    notifyListeners();
    //  changeIsLoading(false);
  }

  ///*******************click on another country***************** */
  Future<void> getVisaForNewCount(
      {required String newCountry, required int newCountIndex}) async {
    if (currentCountry == newCountIndex) {
    } else {
      // changeIsLoading(true);
      isVisaTypeLoading = true;
      notifyListeners();
      currentCountry = newCountIndex;
      //call the conditions if the first visa type for new country
      currentVisaType = 0;
      await getCondCount(
          country: newCountry, visaType: visaCount[newCountIndex].visaType![0]);
      isVisaTypeLoading = false;
      notifyListeners();
      //  changeIsLoading(false);
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
    if (isNumber(value) && removeSpace(value).length == 12) {
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
  String passName = "";
  Future<String> pickPassImg() async {
    var result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowMultiple: false,
        allowedExtensions: ['jpg', 'png', 'jpeg', 'tiff']);
    passImg = result!.files[0].bytes;
    passName = result.files[0].name;
    notifyListeners();
    return passName;
  }

  Uint8List? idImg;
  String idName = "";

  Future<String> pickIdImg() async {
    var result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowMultiple: false,
        allowedExtensions: ['jpg', 'png', 'jpeg', 'tiff']);
    idImg = result!.files[0].bytes;
    idName = result.files[0].name;
    notifyListeners();
    return idName;
  }

  Uint8List? pdfFile;
  String pdfName = "";

  Future<String> pickPdf() async {
    var result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowMultiple: false,
        allowedExtensions: ['pdf']);
    pdfFile = result!.files[0].bytes;
    pdfName = result.files[0].name;
    log(pdfName);
    return pdfName;
  }

  checkForm() {
    return visaCount[currentCountry].form;
  }

  Future<void> downloadPdf(String url, BuildContext context) async {
    MimeType type = MimeType.PDF;
    var bytes = await FirebaseStorage.instance
        .refFromURL(
          url,
        )
        .getData();
    await FileSaver.instance
        .saveFile('form', bytes!, "pdf", mimeType: type)
        .then((value) {
      Dialogs.onlyTextContent(context,
          "Form Pdf has been downloaded , please fill the required information then upload it");
    });
    print('downloaded');
  }
}
