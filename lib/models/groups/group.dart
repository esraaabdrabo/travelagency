class GroupM {
  late String id;
  late String groupNameEn;
  late String groupNameAr;
  late String country;
  late String city;
  late List<String> avilableDates;
  late List<String> groupHotels;

  GroupM(
      {required this.id,
      required this.groupNameEn,
      required this.groupNameAr,
      required this.country,
      required this.city,
      required this.avilableDates,
      required this.groupHotels});

  GroupM.fromJson(Map<String, dynamic> json) {
    if (json["id"] is String) {
      id = json["id"];
    }
    if (json["groupNameEn"] is String) {
      groupNameEn = json["groupNameEn"];
    }
    if (json["groupNameAr"] is String) {
      groupNameAr = json["groupNameAr"];
    }
    if (json["country"] is String) {
      country = json["country"];
    }
    if (json["city"] is String) {
      city = json["city"];
    }
    if (json["avilableDates"] is List) {
      avilableDates = List<String>.from(json["avilableDates"]);
    }
    if (json["groupHotels"] is List) {
      groupHotels = List<String>.from(json["groupHotels"]);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    data["groupNameEn"] = groupNameEn;
    data["groupNameAr"] = groupNameAr;
    data["country"] = country;
    data["city"] = city;
    data["avilableDates"] = avilableDates;
    data["groupHotels"] = groupHotels;
    return data;
  }
}
