class GroupM {
  late String id;
  late String groupNameEn;
  late String groupNameAr;
  late String country;
  late String city;
  late List<AvilableDates> avilableDates;
  late List<GroupHotels> groupHotels;

  GroupM(
      {required this.id,
      required this.groupNameEn,
      required this.groupNameAr,
      required this.country,
      required this.city,
      required this.avilableDates,
      required this.groupHotels});

  GroupM.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    groupNameEn = json["groupNameEn"];
    groupNameAr = json["groupNameAr"];
    country = json["country"];
    city = json["city"];
    avilableDates = (json["avilableDates"] as List)
        .map((e) => AvilableDates.fromJson(e))
        .toList();
    groupHotels = (json["groupHotels"] as List)
        .map((e) => GroupHotels.fromJson(e))
        .toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    data["groupNameEn"] = groupNameEn;
    data["groupNameAr"] = groupNameAr;
    data["country"] = country;
    data["city"] = city;
    data["avilableDates"] = avilableDates.map((e) => e.toJson()).toList();
    data["groupHotels"] = groupHotels.map((e) => e.toJson()).toList();
    return data;
  }
}

class GroupHotels {
  late String hotelId;
  late String hotelName;
  late String hotelImage;

  GroupHotels(
      {required this.hotelId,
      required this.hotelName,
      required this.hotelImage});

  GroupHotels.fromJson(Map<String, dynamic> json) {
    hotelId = json["hotelId"];
    hotelName = json["hotelName"];
    hotelImage = json["hotelImage"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["hotelId"] = hotelId;
    data["hotelName"] = hotelName;
    data["hotelImage"] = hotelImage;
    return data;
  }
}

class AvilableDates {
  late String dateId;
  late String avilableDate;

  AvilableDates({required this.dateId, required this.avilableDate});

  AvilableDates.fromJson(Map<String, dynamic> json) {
    dateId = json["dateId"];
    avilableDate = json["avilableDate"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["dateId"] = dateId;
    data["avilableDate"] = avilableDate;
    return data;
  }
}
