import 'package:flutter/cupertino.dart';

class SettingVM extends ChangeNotifier {
  String currentLang = "en";
  void changeLang(String newLang) {
    if (newLang == currentLang) {
    } else {
      currentLang = newLang;
      notifyListeners();
    }
  }
}
