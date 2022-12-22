class Visa {
  String? id;
  String? countryEn;
  String? countryAr;
  String? countryImage;
  String? categoryEn;
  String? categoryAr;
  dynamic visaconditionVisa;

  Visa(
      {this.id,
      this.countryEn,
      this.countryAr,
      this.countryImage,
      this.categoryEn,
      this.categoryAr,
      this.visaconditionVisa});

  Visa.fromJson(Map<String, dynamic> json) {
    if (json["id"] is String) {
      id = json["id"];
    }
    if (json["countryEn"] is String) {
      countryEn = json["countryEn"];
    }
    if (json["countryAr"] is String) {
      countryAr = json["countryAr"];
    }
    if (json["countryImage"] is String) {
      countryImage = json["countryImage"];
    }
    if (json["categoryEn"] is String) {
      categoryEn = json["categoryEn"];
    }
    if (json["categoryAr"] is String) {
      categoryAr = json["categoryAr"];
    }
    visaconditionVisa = json["visaconditionVisa"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    _data["countryEn"] = countryEn;
    _data["countryAr"] = countryAr;
    _data["countryImage"] = countryImage;
    _data["categoryEn"] = categoryEn;
    _data["categoryAr"] = categoryAr;
    _data["visaconditionVisa"] = visaconditionVisa;
    return _data;
  }
}
/**
 * {"id":"7cf7c15d-7c5c-41bf-ad95-0f8810ec20a0","countryEn":"Turkey",
 * "countryAr":"تركيا",
 * "countryImage":"https://images.unsplash.com/photo-1567527259232-3a7fcd490c55?ixlib=rb-
 * 4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=687&q=80"
 * ,"categoryEn":"hurra",
 * "categoryAr":"حره","visaconditionVisa":null},
 */

class VisaType {
  String? envisatype;
  String? arvisatype;

  VisaType({this.envisatype, this.arvisatype});

  VisaType.fromJson(Map<String, dynamic> json) {
    if (json["envisatype"] is String) {
      envisatype = json["envisatype"];
    }
    if (json["arvisatype"] is String) {
      arvisatype = json["arvisatype"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["envisatype"] = envisatype;
    _data["arvisatype"] = arvisatype;
    return _data;
  }
}
