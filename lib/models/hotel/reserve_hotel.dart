class ReserveHotelM {
  late String hotelId;
  late String userId;
  late String fullName;
  late String phoneNumber;
  late String email;
  String passportImage = "";
  late String roomsNumber;
  late String room1ChildNumber;
  late String room1AdultNumber;
  late String room1Type;
  String room2ChildNumber = "0";
  String room2AdultNumber = "0";
  String room2Type = "";
  String room3ChildNumber = "0";
  String room3AdultNumber = "0";
  String room3Type = "";
  String room4ChildNumber = "0";
  String room4AdultNumber = "0";
  String room4Type = "";
  String room5ChildNumber = "0";
  String room5AdultNumber = "0";
  String room5Type = "";
  String room6ChildNumber = "0";
  String room6AdultNumber = "0";
  String room6Type = "";
  late String fromDate;
  late String toDate;
  String note = "";

  ReserveHotelM(
      {required this.hotelId,
      required this.userId,
      required this.fullName,
      required this.phoneNumber,
      required this.email,
      required this.roomsNumber,
      required this.room1ChildNumber,
      required this.room1AdultNumber,
      required this.room1Type,
      this.room2ChildNumber = "0",
      this.room2AdultNumber = "0",
      this.room2Type = "",
      this.room3ChildNumber = "0",
      this.room3AdultNumber = "0",
      this.room3Type = "",
      this.room4ChildNumber = "0",
      this.room4AdultNumber = "0",
      this.room4Type = "",
      this.room5ChildNumber = "0",
      this.room5AdultNumber = "0",
      this.room5Type = "",
      this.room6ChildNumber = "0",
      this.room6AdultNumber = "0",
      this.room6Type = "",
      required this.fromDate,
      required this.toDate,
      this.note = ""});

  ReserveHotelM.fromJson(Map<String, dynamic> json) {
    hotelId = json["hotelId"];
    userId = json["userId"];
    fullName = json["fullName"];
    phoneNumber = json["phoneNumber"];
    email = json["email"];
    passportImage = json["passportImage"];
    roomsNumber = json["roomsNumber"];
    room1ChildNumber = json["room1ChildNumber"];
    room1AdultNumber = json["room1AdultNumber"];
    room1Type = json["room1Type"];
    room2ChildNumber = json["room2ChildNumber"];
    room2AdultNumber = json["room2AdultNumber"];
    room2Type = json["room2Type"];
    room3ChildNumber = json["room3ChildNumber"];
    room3AdultNumber = json["room3AdultNumber"];
    room3Type = json["room3Type"];
    room4ChildNumber = json["room4ChildNumber"];
    room4AdultNumber = json["room4AdultNumber"];
    room4Type = json["room4Type"];
    room5ChildNumber = json["room5ChildNumber"];
    room5AdultNumber = json["room5AdultNumber"];
    room5Type = json["room5Type"];
    room6ChildNumber = json["room6ChildNumber"];
    room6AdultNumber = json["room6AdultNumber"];
    room6Type = json["room6Type"];
    fromDate = json["fromDate"];
    toDate = json["toDate"];
    note = json["note"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["hotelId"] = hotelId;
    data["userId"] = userId;
    data["fullName"] = fullName;
    data["phoneNumber"] = phoneNumber;
    data["email"] = email;
    data["passportImage"] = "$fullName-${DateTime.now().toString()}-$hotelId";
    data["roomsNumber"] = roomsNumber;
    data["room1ChildNumber"] = room1ChildNumber;
    data["room1AdultNumber"] = room1AdultNumber;
    data["room1Type"] = room1Type;
    data["room2ChildNumber"] = room2ChildNumber;
    data["room2AdultNumber"] = room2AdultNumber;
    data["room2Type"] = room2Type;
    data["room3ChildNumber"] = room3ChildNumber;
    data["room3AdultNumber"] = room3AdultNumber;
    data["room3Type"] = room3Type;
    data["room4ChildNumber"] = room4ChildNumber;
    data["room4AdultNumber"] = room4AdultNumber;
    data["room4Type"] = room4Type;
    data["room5ChildNumber"] = room5ChildNumber;
    data["room5AdultNumber"] = room5AdultNumber;
    data["room5Type"] = room5Type;
    data["room6ChildNumber"] = room6ChildNumber;
    data["room6AdultNumber"] = room6AdultNumber;
    data["room6Type"] = room6Type;
    data["fromDate"] = fromDate;
    data["toDate"] = toDate;
    data["note"] = note;
    return data;
  }
}
