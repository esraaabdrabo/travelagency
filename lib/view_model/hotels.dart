import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:image_picker_web/image_picker_web.dart';
import 'package:travelagency/Screens/Widgets/dialogs.dart';
import 'package:travelagency/models/hotels.dart';
import 'package:travelagency/services/hotels.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:http/http.dart' as http;
// ignore: depend_on_referenced_packages
import 'package:http_parser/http_parser.dart';

class HotelsVM extends ChangeNotifier {
  late AppLocalizations translate;
  bool isHotelClickAct = false;
  bool isLoading = false;
  List<HotelM> hotels = [];
  List<HotelM> searchResults = [];
  List<String> childAges = [];
  int childNum = 0;
  //search with country
  List<String> countries = [
    "UAE", //"United States of Emirates",
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

//to increase text form field for child age
  void changeCildNum({required String num}) {
    if (removeSpace(num).isNotEmpty && isNumber(num)) {
      if (int.parse(removeSpace(num)) > 0) {
        childNum = int.parse(num);
        notifyListeners();
      }
    }
  }

//to take every child age
  void changeCildAge({required int index, required String age}) {
    if (removeSpace(age).isNotEmpty &&
        isNumber(age) &&
        int.parse(removeSpace(age)) >= 0) {
      if (childAges.length > index) {
        childAges.removeAt(index);
      }
      childAges.insert(index, age);
      // save the value

      notifyListeners();
    }
    log(childAges.toString());
  }

//user can not open the reserve form if he dont fill this

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

  void search(BuildContext context) {
    changeIsLoading(true);
    searchResults = [];
    for (var hotel in hotels) {
      log(hotel.locationEn!);
      if (hotel.locationEn == selectedCountry) {
        searchResults.add(hotel);
      }
    }
    searchResults.isEmpty ? Dialogs.notFound(context) : null;
    changeIsLoading(false);
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
