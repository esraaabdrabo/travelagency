import 'package:get/get.dart';

class UserInfoController extends GetxController {
  RxString selectedNationality = 'Iraqi'.obs;

  List<String> nationalites = ['Iraqi', 'syrian', 'turkish', 'iranian'];
}
