//get all vis count
import 'dart:developer';

class VisaCountriesM {
  String? visaId;
  String? countryEn;
  String? countryAr;
  String? countryImage;
  String? form;
  List<String>? visaType;

  VisaCountriesM(
      {this.visaId,
      this.countryEn,
      this.countryAr,
      this.countryImage,
      this.visaType});

  VisaCountriesM.fromJson(Map<String, dynamic> json) {
    visaId = json["visaId"];
    if (json["countryEn"] is String) {
      countryEn = json["countryEn"];
    }
    if (json["countryAr"] is String) {
      countryAr = json["countryAr"];
    }
    if (json["countryImage"] is String) {
      countryImage = json["countryImage"];
    }
    if (json["form"] is String) {
      form = json["form"];
    }

    if (json["visaType"] is List) {
      visaType =
          json["visaType"] == null ? null : List<String>.from(json["visaType"]);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["countryEn"] = countryEn;
    data["countryAr"] = countryAr;
    data["countryImage"] = countryImage;
    if (visaType != null) {
      data["visaType"] = visaType;
    }
    return data;
  }
}
