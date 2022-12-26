class RoomM {
  int? childNum = 0;
  int? adultNum = 0;
  String? roomType = "";

  RoomM({this.childNum, this.adultNum, this.roomType});

  RoomM.fromJson(Map<String, dynamic> json) {
    childNum = json['childNum'];
    adultNum = json['adultNum'];
    roomType = json['roomType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['childNum'] = childNum;
    data['adultNum'] = adultNum;
    data['roomType'] = roomType;
    return data;
  }
}

List<RoomM> rooms = [RoomM(), RoomM(), RoomM(), RoomM(), RoomM(), RoomM()];
