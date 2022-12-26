//get all vis count
class VisaCountriesM {
  String? countryEn;
  String? countryAr;
  String? countryImage;
  List<String>? visaType;

  VisaCountriesM(
      {this.countryEn, this.countryAr, this.countryImage, this.visaType});

  VisaCountriesM.fromJson(Map<String, dynamic> json) {
    if (json["countryEn"] is String) {
      countryEn = json["countryEn"];
    }
    if (json["countryAr"] is String) {
      countryAr = json["countryAr"];
    }
    if (json["countryImage"] is String) {
      countryImage = json["countryImage"];
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
