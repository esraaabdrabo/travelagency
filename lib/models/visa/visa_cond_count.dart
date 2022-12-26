//conditions for one count
class VisaConditionCountryM {
  String? conditionCategory;
  List<String>? conditions;

  VisaConditionCountryM({this.conditionCategory, this.conditions});

  VisaConditionCountryM.fromJson(Map<String, dynamic> json) {
    if (json["conditionCategory"] is String) {
      conditionCategory = json["conditionCategory"];
    }
    if (json["conditions"] is List) {
      conditions = json["conditions"] == null
          ? null
          : List<String>.from(json["conditions"]);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["conditionCategory"] = conditionCategory;
    if (conditions != null) {
      data["conditions"] = conditions;
    }
    return data;
  }
}
