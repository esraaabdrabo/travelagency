class HotelM {
  String? guid;
  String? name;
  String? image;
  String? countryEn;
  String? countryAr;
  String? cityEn;
  String? cityAr;
  int? sngPrice;
  int? dblPrice;
  int? trplPrice;
  int? fmlyPrice;
// dynamic hotelReserves;
// dynamic groupReserve;
// dynamic group;
// dynamic dateTableGroups;

  HotelM({
    this.guid,
    this.name,
    this.image,
    this.countryEn,
    this.countryAr,
    this.cityEn,
    this.cityAr,
    this.sngPrice,
    this.dblPrice,
    this.trplPrice,
    this.fmlyPrice,
    //   this.hotelReserves,
    //   this.groupReserve,
    //   this.group,
    //   this.dateTableGroups
  });

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
    if (json["countryEn"] is String) {
      countryEn = json["countryEn"];
    }
    if (json["countryAr"] is String) {
      countryAr = json["countryAr"];
    }
    if (json["cityEn"] is String) {
      cityEn = json["cityEn"];
    }
    if (json["cityAr"] is String) {
      cityAr = json["cityAr"];
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
    if (json["fmlyPrice"] is int) {
      fmlyPrice = json["fmlyPrice"];
    }
    // hotelReserves = json["hotelReserves"];
    // groupReserve = json["groupReserve"];
    // group = json["group"];
    // dateTableGroups = json["dateTableGroups"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["guid"] = guid;
    _data["name"] = name;
    _data["image"] = image;
    _data["countryEn"] = countryEn;
    _data["countryAr"] = countryAr;
    _data["cityEn"] = cityEn;
    _data["cityAr"] = cityAr;
    _data["sngPrice"] = sngPrice;
    _data["dblPrice"] = dblPrice;
    _data["trplPrice"] = trplPrice;
    _data["fmlyPrice"] = fmlyPrice;
    // _data["hotelReserves"] = hotelReserves;
    // _data["groupReserve"] = groupReserve;
    // _data["group"] = group;
    // _data["dateTableGroups"] = dateTableGroups;
    return _data;
  }
}
