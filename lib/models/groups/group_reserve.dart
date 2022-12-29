import 'dart:developer';

class GroupReserveM {
//  String id;
  late String userId;
  late String hotelId;
  late String groupId;
  late String dateTableId;
  late String fullName;
  late String phoneNumber;
  late String email;
  late String reserveType;
  String identifyImage = "";
  String status = "waiting";
  String statusReson = "";
  String note = "";
  String createdDate = DateTime.now().toString();
  String updatedDate = "";
  String cancelledDate = "";
  dynamic group;
  dynamic dateTable;
  dynamic user;
  dynamic hotel;

  GroupReserveM(
      {required this.userId,
      required this.hotelId,
      required this.groupId,
      required this.dateTableId,
      required this.fullName,
      required this.phoneNumber,
      required this.email,
      required this.reserveType,
      this.note = "",
      this.dateTable,
      this.user,
      this.hotel});

  GroupReserveM.fromJson(Map<String, dynamic> json) {
    /*if (json["id"] is String) {
      id = json["id"];
    }*/
    if (json["userId"] is String) {
      userId = json["userId"];
    }
    if (json["hotelId"] is String) {
      hotelId = json["hotelId"];
    }
    if (json["groupId"] is String) {
      groupId = json["groupId"];
    }
    if (json["dateTableId"] is String) {
      dateTableId = json["dateTableId"];
    }
    if (json["fullName"] is String) {
      fullName = json["fullName"];
    }
    if (json["phoneNumber"] is String) {
      phoneNumber = json["phoneNumber"];
    }
    if (json["email"] is String) {
      email = json["email"];
    }
    log("saaas");

    if (json["reserveType"] is String) {
      reserveType = json["reserveType"];
    }
    if (json["identifyImage"] is String) {
      identifyImage = json["identifyImage"];
    }
    if (json["status"] is String) {
      status = json["status"];
    }
    statusReson = json["statusReson"];
    note = json["note"];
    if (json["createdDate"] is String) {
      createdDate = json["createdDate"];
    }
    if (json["updatedDate"] is String) {
      updatedDate = json["updatedDate"];
    }
    if (json["cancelledDate"] is String) {
      cancelledDate = json["cancelledDate"];
    }

    //  group = json["group"];
    //  dateTable = json["dateTable"];
    //  user = json["user"];
    //  hotel = json["hotel"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    // _data["id"] = id;
    data["userId"] = userId;
    data["hotelId"] = hotelId;
    data["groupId"] = groupId;
    data["dateTableId"] = dateTableId;
    data["fullName"] = fullName;
    data["phoneNumber"] = phoneNumber;
    data["email"] = email;
    data["reserveType"] = reserveType;
    data["identifyImage"] = "id-$fullName-${DateTime.now().toString()}";
    data["status"] = status;
    data["statusReson"] = statusReson;
    data["note"] = note;
    data["createdDate"] = createdDate;
    data["updatedDate"] = updatedDate;
    data["cancelledDate"] = cancelledDate;
    data["group"] = group;
    data["dateTable"] = dateTable;
    data["user"] = user;
    data["hotel"] = hotel;
    return data;
  }
}
