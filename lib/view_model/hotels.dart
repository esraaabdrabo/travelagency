import 'package:flutter/cupertino.dart';
import 'package:travelagency/models/hotels.dart';
import 'package:travelagency/services/Hotels.dart';

class HotelsVM extends ChangeNotifier {
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
    getAllHotels();
    selectedCountry = countries[0];
  }
  Future<void> getAllHotels() async {
    changeIsLoading(true);
    hotels = await HotelsSV().getAllHotels();
    changeIsLoading(false);
  }

  /*****************search with country**************************** */
  //change selected country
  void changeSelectedCountry(String country) {
    selectedCountry = country;
    notifyListeners();
  }
}
