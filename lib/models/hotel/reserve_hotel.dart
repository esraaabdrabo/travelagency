import 'dart:developer';

class ReserveHotelM {
  late String hotelId;
  late String userId;
  late String fullName;
  late String phoneNumber;
  late String email;
  late String passportImage;
  late int roomsNumber;
  late int room1ChildNumber;
  late int room1AdultNumber;
  late String room1Type;
  late String fromDate;
  late String toDate;
  late String note;
  int? room2ChildNumber;
  int? room2AdultNumber;
  String? room2Type;
  int? room3ChildNumber;
  int? room3AdultNumber;
  String? room3Type;
  int? room4ChildNumber;
  int? room4AdultNumber;
  String? room4Type;
  int? room5ChildNumber;
  int? room5AdultNumber;
  String? room5Type;
  int? room6ChildNumber;
  int? room6AdultNumber;
  String? room6Type;

  ReserveHotelM(
      {required this.hotelId,
      required this.userId,
      required this.fullName,
      required this.phoneNumber,
      required this.email,
      //  required this.passportImage,
      required this.roomsNumber,
      required this.room1ChildNumber,
      required this.room1AdultNumber,
      required this.room1Type,
      this.room2ChildNumber,
      this.room2AdultNumber,
      this.room2Type,
      this.room3ChildNumber,
      this.room3AdultNumber,
      this.room3Type,
      this.room4ChildNumber,
      this.room4AdultNumber,
      this.room4Type,
      this.room5ChildNumber,
      this.room5AdultNumber,
      this.room5Type,
      this.room6ChildNumber,
      this.room6AdultNumber,
      this.room6Type,
      required this.fromDate,
      required this.toDate,
      required this.note});

  ReserveHotelM.fromJson(Map<String, dynamic> json) {
    hotelId = json['hotelId'];
    userId = json['userId'];
    fullName = json['fullName'];
    phoneNumber = json['phoneNumber'];
    email = json['email'];
    passportImage = json['passportImage'];
    roomsNumber = json['roomsNumber'];
    room1ChildNumber = json['room1ChildNumber'];
    room1AdultNumber = json['room1AdultNumber'];
    room1Type = json['room1Type'];
    room2ChildNumber = json['room2ChildNumber'];
    room2AdultNumber = json['room2AdultNumber'];
    room2Type = json['room2Type'];
    room3ChildNumber = json['room3ChildNumber'];
    room3AdultNumber = json['room3AdultNumber'];
    room3Type = json['room3Type'];
    room4ChildNumber = json['room4ChildNumber'];
    room4AdultNumber = json['room4AdultNumber'];
    room4Type = json['room4Type'];
    room5ChildNumber = json['room5ChildNumber'];
    room5AdultNumber = json['room5AdultNumber'];
    room5Type = json['room5Type'];
    room6ChildNumber = json['room6ChildNumber'];
    room6AdultNumber = json['room6AdultNumber'];
    room6Type = json['room6Type'];
    fromDate = json['fromDate'];
    toDate = json['toDate'];
    note = json['note'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['hotelId'] = hotelId;
    data['userId'] = userId;
    data['fullName'] = fullName;
    data['phoneNumber'] = phoneNumber;
    data['email'] = email;
    data['passportImage'] = "$fullName/${DateTime.now().toString()}";
    data['roomsNumber'] = roomsNumber;
    data['room1ChildNumber'] = room1ChildNumber;
    data['room1AdultNumber'] = room1AdultNumber;
    data['room1Type'] = room1Type;
    data['room2ChildNumber'] = room2ChildNumber;
    data['room2AdultNumber'] = room2AdultNumber;
    data['room2Type'] = room2Type;
    data['room3ChildNumber'] = room3ChildNumber;
    data['room3AdultNumber'] = room3AdultNumber;
    data['room3Type'] = room3Type;
    data['room4ChildNumber'] = room4ChildNumber;
    data['room4AdultNumber'] = room4AdultNumber;
    data['room4Type'] = room4Type;
    data['room5ChildNumber'] = room5ChildNumber;
    data['room5AdultNumber'] = room5AdultNumber;
    data['room5Type'] = room5Type;
    data['room6ChildNumber'] = room6ChildNumber;
    data['room6AdultNumber'] = room6AdultNumber;
    data['room6Type'] = room6Type;
    data['fromDate'] = fromDate;
    data['toDate'] = toDate;
    data['note'] = note;
    log("end convert model");
    return data;
  }
}
