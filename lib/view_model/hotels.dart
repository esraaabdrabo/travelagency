import 'dart:developer';
import "dart:io";
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:image_picker_web/image_picker_web.dart';
import 'package:travelagency/models/hotels.dart';
import 'package:travelagency/services/hotels.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

class HotelsVM extends ChangeNotifier {
  late AppLocalizations translate;

  bool isLoading = false;
  List<HotelM> hotels = [];
  //search with country
  List<String> countries = [
    "United States of Emirates",
    "Turkey",
    "Iran",
    "Egypt",
    "Syria",
    "Lebanon"
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

  Future<void> reserveHotel() async {
    changeIsLoading(true);
    HotelsSV().reserveHotel();
    changeIsLoading(false);
  }

  /// ***************search with country**************************** */
  //change selected country
  void changeSelectedCountry(String country) {
    selectedCountry = country;
    notifyListeners();
  }

  /*** */
  test() async {
    var url = Uri.parse("https://dawatkurdi.com/testimg/");
    var img = await ImagePickerWeb.getImageAsBytes();
    MultipartFile imgFile = http.MultipartFile.fromBytes("imgFile", img!);
    log("ssss");
    var request = http.MultipartRequest('POST', url);

    request.files.add(http.MultipartFile.fromBytes("imgFile", img,
        contentType: MediaType('image', 'png')));

    /*   bytesFromPicker.showDialog(
          context: context,
          builder: (context) => Image.memory(bytesFromPicker!));*/

    /*request.files.add(http.MultipartFile.fromBytes(
        "image",
        bytesFromPicker!,
      ));
      log("start");
      request.send().then((value) {
        log(value.statusCode.toString());
      });*/
    request.send().then((value) {
      log(value.statusCode.toString());
    });
  }
}
