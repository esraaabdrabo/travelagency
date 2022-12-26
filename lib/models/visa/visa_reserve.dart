class VisaReserveM {
  late String visaId;
  late String userId;
  late String fullName;
  late String phoneNumber;
  late String email;
  String passportImage = "";
  String identifyImage = "";
  String form = "";
  late String note;

  VisaReserveM(
      {required this.visaId,
      required this.userId,
      required this.fullName,
      required this.phoneNumber,
      required this.email,
      required this.note});

  VisaReserveM.fromJson(Map<String, dynamic> json) {
    if (json["visaId"] is String) {
      visaId = json["visaId"];
    }
    if (json["userId"] is String) {
      userId = json["userId"];
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
    passportImage = json["passportImage"];
    identifyImage = json["identifyImage"];
    form = json["form"];
    note = json["note"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["visaId"] = visaId;
    data["userId"] = userId;
    data["fullName"] = fullName;
    data["phoneNumber"] = phoneNumber;
    data["email"] = email;
    data["passportImage"] = "pass-$fullName-$userId-${DateTime.now()}";
    data["identifyImage"] = "id-$fullName-$userId-${DateTime.now()}";
    data["form"] = "form-$fullName-$userId-${DateTime.now()}";
    data["note"] = note;
    return data;
  }
}
