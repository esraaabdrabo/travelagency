// ignore: file_names
// ignore_for_file: avoid_print

import 'package:http/http.dart' as http;
import 'package:travelagency/Helper/constants.dart';
import 'package:travelagency/models/hotels.dart';

class HotelsSV {
  Future<List<HotelM>> getAllHotels() async {
    // var response = await http.get(Uri.parse(Constants.allHotelsURL));
    List<HotelM> response = [];
    var data = [
      {
        "guid": "20b742a9-b354-44fb-a37e-525c83923fe2",
        "name": "Five Jumeirah Village",
        "image":
            "https://cf.bstatic.com/xdata/images/hotel/max1024x768/213805317.jpg?k=1d31525a3a565f11ed6f43394f9a131cee10734a150719956900b2c5fd8e2b0e&o=&hp=1",
        "locationEn": "UAE",
        "locationAr": "ألامارات ألعربيه ألمتحده",
        "sngPrice": 99,
        "dblPrice": 180,
        "trplPrice": 220,
        "fmlyPrice": 200,
        "users": null
      },
      {
        "guid": "fd6ef6a8-3bab-4c82-a8dc-f2d17f23799a",
        "name": "Divan Cave Hotel",
        "image":
            "https://cf.bstatic.com/xdata/images/hotel/max1024x768/41087981.jpg?k=913558a5c722f6ce16a587f68e287022458bf15ab041ce6f52040a9ad69bb5d2&o=&hp=1",
        "locationEn": "Turkey",
        "locationAr": "نركيا",
        "sngPrice": 52,
        "dblPrice": 87,
        "trplPrice": 107,
        "fmlyPrice": 168,
        "users": null
      },
      {
        "guid": "07899194-d786-4a3c-b95b-f6af62f20f28",
        "name": "Bedouin Lifestyle Camp",
        "image":
            "https://cf.bstatic.com/xdata/images/hotel/max1024x768/347573112.jpg?k=3d6ce9c6c4967dfce7fc50d228d98878301ba51949bfa8b061953ca26c0ab543&o=&hp=1",
        "locationEn": "Jordan",
        "locationAr": "أردن",
        "sngPrice": 43,
        "dblPrice": 66,
        "trplPrice": 114,
        "fmlyPrice": 180,
        "users": null
      }
    ];
    for (var hotel in data) {
      response.add(HotelM.fromJson(hotel));
    }
    return response;
    /*  if (response.statusCode == 200) {
      print("200 all hotels");
    } else {
      print("${response.statusCode} all hotels");
    }*/
  }
}
