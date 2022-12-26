// ignore: file_names
// ignore_for_file: avoid_print, unused_local_variable

import 'dart:developer';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:travelagency/Helper/constants.dart';

import '../models/hotel/hotels.dart';
import '../models/hotel/reserve_hotel.dart';

class HotelsSV {
  Future<List<HotelM>> getAllHotels() async {
    /* var response = await http.get(
      Uri.parse(Constants.allHotelsURL),
    );*/
    List<HotelM> hotels = [];
    var response = [
      {
        "guid": "f70025c6-0f73-4a37-948c-155ebaf87af2",
        "name": "Divan Istanbul",
        "image":
            "https://cf.bstatic.com/xdata/images/hotel/max1024x768/41087981.jpg?k=913558a5c722f6ce16a587f68e287022458bf15ab041ce6f52040a9ad69bb5d2&o=&hp=1",
        "locationEn": "Turkey",
        "locationAr": "تركيا",
        "sngPrice": 51,
        "dblPrice": 79,
        "trplPrice": 108,
        "fmlyPrice": 200,
        "hotelReserves": null
      },
      {
        "guid": "e4c7efa2-cefb-4be2-bcfc-5f4ec64e3d46",
        "name": "Tilal Liwa Hotel",
        "image":
            "https://cf.bstatic.com/xdata/images/hotel/max1024x768/76853227.jpg?k=2b61f85738a8405afc804602e5f217d2fb6284d1e0e0d8f73f131121fe886c46&o=&hp=1",
        "locationEn": "UAE",
        "locationAr": "ألامارات ألعربيه ألمتحده",
        "sngPrice": 81,
        "dblPrice": 190,
        "trplPrice": 21,
        "fmlyPrice": null,
        "hotelReserves": null
      },
      {
        "guid": "52c5fc42-0012-4cb4-8d67-6809c2de491d",
        "name": "Crowne Plaza Antalya",
        "image":
            "https://cf.bstatic.com/xdata/images/hotel/max1024x768/242976733.jpg?k=07024a4a313f3fae4710ff84ff76a4db16efb472f5051a7bf5b0ae9b09b6e78f&o=&hp=1",
        "locationEn": "Turkey",
        "locationAr": "تركيا",
        "sngPrice": 67,
        "dblPrice": 100,
        "trplPrice": 130,
        "fmlyPrice": 180,
        "hotelReserves": null
      },
      {
        "guid": "ceefe876-b34c-4863-863d-9b3ceada5213",
        "name": "CVK Park Bosphorus Hotel Istanbul\r\n",
        "image":
            "https://cf.bstatic.com/xdata/images/hotel/max1024x768/264603329.jpg?k=2d453049aa6ca684ab4e7fec4170dfdfa8ca1ea76647e37d2d5fce687006227e&o=&hp=1",
        "locationEn": "Turkey",
        "locationAr": "تركيا",
        "sngPrice": 45,
        "dblPrice": 89,
        "trplPrice": 112,
        "fmlyPrice": null,
        "hotelReserves": null
      },
      {
        "guid": "14a72518-9e1e-486a-a087-f3e34c0156e5",
        "name": "The Ranch - Lodge & Equestrian Center\r\n",
        "image":
            "https://cf.bstatic.com/xdata/images/hotel/max1024x768/285051372.jpg?k=6653eb25f70c658486f9b14b8e83ace20541111a78d2b16fc4fa5502576b784a&o=&hp=1",
        "locationEn": "Lebanon",
        "locationAr": "لبنان",
        "sngPrice": 80,
        "dblPrice": 110,
        "trplPrice": 200,
        "fmlyPrice": 240,
        "hotelReserves": null
      }
    ];
    for (Map<String, dynamic> hotel in response) {
      hotels.add(HotelM.fromJson(hotel));
    }
    /* if (response.statusCode == 200) {
      log("succes get all hotels");
      List<dynamic> data = jsonDecode(response.body);
      //convert every object to hotel model
      log(data.toString());
      for (Map<String, dynamic> hotel in data) {
        hotels.add(HotelM.fromJson(hotel));
      }
    } else {
      print("${response.statusCode} error in all hotels");
    }*/
    return hotels;
  }

  Future<bool> reserveHotel(
    ReserveHotelM data,
    Uint8List img,
  ) async {
    bool isSuccess = false;
    log("will reserve hotel from hotelsv");
    var response = await http.post(
      Uri.parse(Constants.reserveHotel),
      body: data.toJson(),
    );
    if (response.statusCode == 200) {
      log("reservation in hotels done");
      uploadImg(img, data.passportImage);
      isSuccess = true;
    } else {
      log("error in reserve hotel");
      log(response.statusCode.toString());
    }
    return isSuccess;
  }

  void uploadImg(Uint8List img, String name) {
    FirebaseStorage storage = FirebaseStorage.instance;
    var ref = storage.ref("Passports/").child("$name.jpg");
    try {
      ref.putData(img).then((p0) {
        log("image uploaded");
      });
    } on FirebaseException catch (e) {
      log("error in uploaing image");
      log(e.toString());
    }
  }
}
