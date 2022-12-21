import 'package:flutter/cupertino.dart';
import 'package:travelagency/models/hotels.dart';
import 'package:travelagency/services/hotels.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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

//adult num + room num
  validateAdultNum(String value, BuildContext context) {
    if (removeSpace(value).isNotEmpty &&
        isNumber(value) &&
        int.parse(removeSpace(value)) > 0) {
      return null;
    }
    return "error";
  }

//child num
  validateChildNum(String value, BuildContext context) {
    if (removeSpace(value).isNotEmpty &&
        isNumber(value) &&
        int.parse(removeSpace(value)) >= 0) {
      return null;
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
}
