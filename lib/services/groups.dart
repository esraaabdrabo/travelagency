// ignore: file_names
// ignore_for_file: avoid_print, unused_local_variable

import 'dart:developer';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:travelagency/Helper/constants.dart';
import 'package:travelagency/models/groups/group.dart';

import '../models/hotel/reserve_hotel.dart';

class GroupsSV {
  Future<List<GroupM>> getAllGroups() async {
    /* var response = await http.get(
      Uri.parse(Constants.allGroupsURL),
    );*/
    List<GroupM> groups = [];
    var body = [
      {
        "id": "041ce3ea-141c-4902-afae-2fb8879a978f",
        "groupNameEn": "Amman Group",
        "groupNameAr": "كروب عمان",
        "country": "Jordan",
        "city": "Amman",
        "avilableDates": ["2023-01-01T00:00:00", "2023-01-02T00:00:00"],
        "groupHotels": ["The Ritaz-Carlton", "W Amman Hotel"]
      },
      {
        "id": "c9e09630-18c4-4d94-843f-6ceea8470ac8",
        "groupNameEn": "Mekka Group",
        "groupNameAr": "كروب مكه",
        "country": "Sudia Arabia",
        "city": "Mekka",
        "avilableDates": ["2022-12-30T00:00:00"],
        "groupHotels": ["Hilton Makkah"]
      }
    ];
    for (Map<String, dynamic> group in body) {
      groups.add(GroupM.fromJson(group));
    }
    /* if (response.statusCode == 200) {
      log("succes get all Groups");
      List<dynamic> data = jsonDecode(response.body);
      //convert every object to hotel model
      log(data.toString());
      for (Map<String, dynamic> hotel in data) {
        groups.add(GroupM.fromJson(hotel));
      }
    } else {
      print("${response.statusCode} error in all Groups");
    }*/
    return groups;
  }

  Future<bool> reserveHotel(
    ReserveHotelM data,
    Uint8List img,
  ) async {
    bool isSuccess = false;
    log("will reserve hotel from Groupsv");
    var response =
        await http.post(Uri.parse(Constants.reserveHotel), body: data.toJson());
    if (response.statusCode == 200) {
      log("reservation in Groups done");
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
