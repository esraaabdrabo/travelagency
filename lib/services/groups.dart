// ignore: file_names
// ignore_for_file: avoid_print, unused_local_variable

import 'dart:convert';
import 'dart:developer';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:travelagency/Helper/constants.dart';
import 'package:travelagency/models/groups/group.dart';
import 'package:travelagency/models/groups/group_reserve.dart';

import '../models/hotel/reserve_hotel.dart';

class GroupsSV {
  Future<List<GroupM>> getAllGroups() async {
    var response = await http.get(
      Uri.parse(Constants.allGroupsURL),
    );
    List<GroupM> groups = [];
    /*var body = [
      {
        "id": "041ce3ea-141c-4902-afae-2fb8879a978f",
        "groupNameEn": "Amman Group",
        "groupNameAr": "كروب عمان",
        "country": "Jordan",
        "city": "Amman",
        "avilableDates": [
          {
            "dateId": "c9fb7912-56fb-4c58-95d7-76d649a00b7e",
            "avilableDate": "2023-01-01T00:00:00"
          },
          {
            "dateId": "acb047f7-e76f-40a3-b84c-1cc4d8f79ff8",
            "avilableDate": "2023-01-02T00:00:00"
          }
        ],
        "groupHotels": [
          {
            "hotelId": "7e282d34-ce86-4628-bb12-29531d0ea92d",
            "hotelName": "The Ritaz-Carlton",
            "hotelImage":
                "https://cf.bstatic.com/xdata/images/hotel/max1024x768/359204983.jpg?k=3cd8d6ea3582e7b3f6d2acb7f8723536373b92926667fba0a85843583be50026&o=&hp=1"
          },
          {
            "hotelId": "2223faca-eec1-40ef-9114-4eb5ba35ccf6",
            "hotelName": "W Amman Hotel",
            "hotelImage":
                "https://cf.bstatic.com/xdata/images/hotel/max1024x768/165068921.jpg?k=96bfedc5f473325b8ec19a270523aa9d7dae734b4bd4c38363596e127e5e51f4&o=&hp=1"
          }
        ]
      },
      {
        "id": "c9e09630-18c4-4d94-843f-6ceea8470ac8",
        "groupNameEn": "Mekka Group",
        "groupNameAr": "كروب مكه",
        "country": "Sudia Arabia",
        "city": "Mekka",
        "avilableDates": [
          {
            "dateId": "b4a0a3a5-a4b3-49a5-9689-e24a35a5d0b9",
            "avilableDate": "2022-12-30T00:00:00"
          }
        ],
        "groupHotels": [
          {
            "hotelId": "02c32830-fe2c-4049-992d-7b9d1d2944ea",
            "hotelName": "Hilton Makkah",
            "hotelImage":
                "https://cf.bstatic.com/xdata/images/hotel/max1024x768/94072339.jpg?k=ed635b5fc1df94017207fdc6575b4f10e3af09a55b9c87b116c35033d6e20042&o=&hp=1"
          }
        ]
      },
      {
        "id": "89db1c98-e209-42c7-a678-acf7d10845f9",
        "groupNameEn": "Greece",
        "groupNameAr": "كروب اليونان",
        "country": "Greece",
        "city": "Athena",
        "avilableDates": [
          {
            "dateId": "8747267d-781c-41e9-a26a-0ad431e9ae5b",
            "avilableDate": "2023-08-01T00:00:00"
          },
          {
            "dateId": "45f893ef-2229-458d-a544-cf9e1af85fae",
            "avilableDate": "2023-07-01T00:00:00"
          },
          {
            "dateId": "fc7da8aa-46d6-4f68-9556-05a79dcc206b",
            "avilableDate": "2023-06-01T00:00:00"
          }
        ],
        "groupHotels": [
          {
            "hotelId": "5ffe2cfc-2fda-48ec-9eda-b48128ef7e69",
            "hotelName": "Wyndham Athens Residence",
            "hotelImage":
                "https://cf.bstatic.com/xdata/images/hotel/max1024x768/151927913.jpg?k=2a3eb67631b25b72743c37adb9706f38583839c7c67661108f3cc288745382d6&o=&hp=1"
          },
          {
            "hotelId": "5ffe2cfc-2fda-48ec-9eda-b48128ef7e69",
            "hotelName": "Wyndham Athens Residence",
            "hotelImage":
                "https://cf.bstatic.com/xdata/images/hotel/max1024x768/151927913.jpg?k=2a3eb67631b25b72743c37adb9706f38583839c7c67661108f3cc288745382d6&o=&hp=1"
          },
          {
            "hotelId": "5ffe2cfc-2fda-48ec-9eda-b48128ef7e69",
            "hotelName": "Wyndham Athens Residence",
            "hotelImage":
                "https://cf.bstatic.com/xdata/images/hotel/max1024x768/151927913.jpg?k=2a3eb67631b25b72743c37adb9706f38583839c7c67661108f3cc288745382d6&o=&hp=1"
          }
        ]
      }
    ];
  */ /* for (Map<String, dynamic> group in body) {
    //  log(body.toString());
   //   groups.add(GroupM.fromJson(group));
    }*/
    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      //convert every object to hotel model
      log(data.toString());
      for (Map<String, dynamic> hotel in data) {
        groups.add(GroupM.fromJson(hotel));
      }
      log("succes get all Groups");
    } else {
      print("${response.statusCode} error in all Groups");
    }
    return groups;
  }

  Future<bool> reserveGroup(
    GroupReserveM data,
    Uint8List img,
  ) async {
    bool isSuccess = false;
    log("will reserve group from Groupsv");
    var response = await http.post(Uri.parse(Constants.groupReserveURL),
        body: data.toJson());
    if (response.statusCode == 200) {
      log("reservation in Groups sv done");
      //  uploadImg(img, data.identifyImage);
      isSuccess = true;
    } else {
      log("error in reserve group sv");
      log(response.statusCode.toString());
    }
    return isSuccess;
  }

  void uploadImg(Uint8List img, String name) {
    FirebaseStorage storage = FirebaseStorage.instance;
    var ref = storage.ref(Constants.idPath).child("$name.jpg");
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
