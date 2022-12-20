import 'package:uuid/uuid.dart';

class ReserveHotelM {
  String id = const Uuid().v1();
  late String hotelId;
  late String userId;
  late String fullName;
  late String phoneNumber;
  late String email;
  late String passportImage;
  late String fromDate;
  late String toDate;
  late bool isDone;
  late String createdDate;
  late String cancelledDate;
  late String note;
  late bool isCancelled;

  ReserveHotelM(
      {required this.hotelId,
      required this.userId,
      required this.fullName,
      required this.phoneNumber,
      required this.email,
      required this.passportImage,
      required this.fromDate,
      required this.toDate,
      required this.isDone,
      required this.createdDate,
      required this.cancelledDate,
      required this.note,
      required this.isCancelled});

  ReserveHotelM.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    hotelId = json['hotelId'];
    userId = json['userId'];
    fullName = json['fullName'];
    phoneNumber = json['phoneNumber'];
    email = json['email'];
    passportImage = json['passportImage'];
    fromDate = json['fromDate'];
    toDate = json['toDate'];
    isDone = json['isDone'];
    createdDate = json['createdDate'];
    cancelledDate = json['cancelledDate'];
    note = json['note'];
    isCancelled = json['isCancelled'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['hotelId'] = hotelId;
    data['userId'] = userId;
    data['fullName'] = fullName;
    data['phoneNumber'] = phoneNumber;
    data['email'] = email;
    data['passportImage'] = passportImage;
    data['fromDate'] = fromDate;
    data['toDate'] = toDate;
    data['isDone'] = isDone;
    data['createdDate'] = createdDate;
    data['cancelledDate'] = cancelledDate;
    data['note'] = note;
    data['isCancelled'] = isCancelled;
    return data;
  }
}
