class HotelM {
  String? guid;
  String? name;
  String? image;
  String? locationEn;
  String? locationAr;
  int? sngPrice;
  int? dblPrice;
  int? trplPrice;
  dynamic fmlyPrice;
  dynamic users;

  HotelM(
      {this.guid,
      this.name,
      this.image,
      this.locationEn,
      this.locationAr,
      this.sngPrice,
      this.dblPrice,
      this.trplPrice,
      this.fmlyPrice,
      this.users});

  HotelM.fromJson(Map<String, dynamic> json) {
    if (json["guid"] is String) {
      guid = json["guid"];
    }
    if (json["name"] is String) {
      name = json["name"];
    }
    if (json["image"] is String) {
      image = json["image"];
    }
    if (json["locationEn"] is String) {
      locationEn = json["locationEn"];
    }
    if (json["locationAr"] is String) {
      locationAr = json["locationAr"];
    }
    if (json["sngPrice"] is int) {
      sngPrice = json["sngPrice"];
    }
    if (json["dblPrice"] is int) {
      dblPrice = json["dblPrice"];
    }
    if (json["trplPrice"] is int) {
      trplPrice = json["trplPrice"];
    }
    fmlyPrice = json["fmlyPrice"];
    users = json["users"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["guid"] = guid;
    _data["name"] = name;
    _data["image"] = image;
    _data["locationEn"] = locationEn;
    _data["locationAr"] = locationAr;
    _data["sngPrice"] = sngPrice;
    _data["dblPrice"] = dblPrice;
    _data["trplPrice"] = trplPrice;
    _data["fmlyPrice"] = fmlyPrice;
    _data["users"] = users;
    return _data;
  }
}
