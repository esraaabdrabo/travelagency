import 'dart:convert';
import 'dart:developer';
import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:http/http.dart' as http;
import 'package:travelagency/models/visa/visa_cond_count.dart';
import 'package:travelagency/models/visa/visa_countries.dart';
import 'package:travelagency/models/visa/visa_reserve.dart';

import '../Helper/constants.dart';

class VisaSV {
  Future<List<VisaCountriesM>> getAllVisa() async {
    /*List<VisaCountriesM> visa = [];

    var data = [
      {
        "visaId": "e7ab6795-7f30-49d3-9f2d-2d1c059c9390",
        "countryEn": "Turkey",
        "countryAr": "تركيا",
        "countryImage":
            "https://images.unsplash.com/photo-1567527259232-3a7fcd490c55?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=387&q=80",
        "visaType": ["tourist", "trade"]
      },
      {
        "visaId": "76db07b7-764d-4f06-92a0-38722e6e88ea",
        "countryEn": "Qatar",
        "countryAr": "قطر",
        "countryImage":
            "https://images.unsplash.com/photo-1550350505-553196f2a527?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=327&q=80",
        "visaType": ["tourist"]
      },
      {
        "visaId": "635ec096-b082-40a9-9032-72db3b052aba",
        "countryEn": "Sudia Arabia",
        "countryAr": "ألسعوديه",
        "countryImage":
            "https://images.unsplash.com/photo-1580418827493-f2b22c0a76cb?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=387&q=80",
        "visaType": ["tourist"]
      },
      {
        "visaId": "47b47d88-9d15-4ff0-9ab7-b69abcf8005f",
        "countryEn": "Jordan",
        "countryAr": "ألاردن",
        "countryImage":
            "https://images.unsplash.com/photo-1554357345-187a92a9eeab?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=465&q=80",
        "visaType": ["tourist"]
      }
    ];
    for (Map<String, dynamic> visaObj in data) {
      visa.add(VisaCountriesM.fromJson(visaObj));
    }*/
    var response = await http.get(
      Uri.parse(Constants.allvisaURL),
    );
    List<VisaCountriesM> visa = [];

    if (response.statusCode == 200) {
      log("succes get all visa");
      List<dynamic> data = jsonDecode(response.body);
      //convert every object to visa model
      log(data.toString());
      for (Map<String, dynamic> visaObj in data) {
        visa.add(VisaCountriesM.fromJson(visaObj));
        log("message");
        log(visaObj["form"].toString());
      }
    } else {
      log("${response.statusCode} error in all visa");
    }
    return visa;
  }

  Future<List<VisaConditionCountryM>> getCondForCount(
      {required String country, required String visaType}) async {
    var url =
        "${Constants.visaConditionCountry}country=$country&visatype=$visaType";
    var response = await http.get(
      Uri.parse(url),
    );
    List<VisaConditionCountryM> visaReq = [];

    if (response.statusCode == 200) {
      log(url);

      log("succes get  visa condition for $country sv");
      List<dynamic> data = jsonDecode(response.body);
      //convert every object to visa model
      for (Map<String, dynamic> visaObj in data) {
        visaReq.add(VisaConditionCountryM.fromJson(visaObj));
      }
    } else {
      log("${response.statusCode} error in all visa");
    }
    log(visaReq.toString());
    log("end in vis count cond sv");
    return visaReq;
  }

  Future<bool> reserveVisa({
    required VisaReserveM body,
    required Uint8List pass,
    required Uint8List id,
    required Uint8List form,
  }) async {
    bool isSuccess = false;

    var response = await http.post(Uri.parse(Constants.visaReserveURL),
        body: body.toJson());

    if (response.statusCode == 200) {
      await uploadImg(
          img: pass,
          name: body.passportImage,
          path: Constants.passportPath,
          ext: "jpg");
      await uploadImg(
          img: id,
          name: body.identifyImage,
          path: Constants.idPath,
          ext: "jpg");
      await uploadImg(
          img: form, name: body.form, path: Constants.pdfPath, ext: "pdf");

      isSuccess = true;
      log("succes reserve visa sv");
    } else {
      log("${response.statusCode} error in reserve visa");
    }
    return isSuccess;
  }

  Future<bool> uploadImg(
      {required Uint8List img,
      required String name,
      required String path,
      required String ext}) async {
    FirebaseStorage storage = FirebaseStorage.instance;
    var ref = storage.ref(path).child("$name.$ext");
    bool isSuccess = false;
    try {
      ref.putData(img).then((p0) async {
        log("$path image uploaded");
        isSuccess = true;
        log(await ref.getDownloadURL());
      });
    } on FirebaseException catch (e) {
      log("error in uploaing image");
      log(e.toString());
    }
    return isSuccess;
  }
}
