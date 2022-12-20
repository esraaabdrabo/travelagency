import 'package:get/get.dart';

class DraweerController extends GetxController{
  RxInt indexselected = 0.obs ;
  RxBool isSelected = false.obs;

  void select(int index)
  {
    indexselected.value = index;
    if(index == 0)
      {
        Get.toNamed("VisaScreen");
      }
    else if(index == 1)
    {
      Get.toNamed("HotelScreen");
    }
  }

  bool CheckIfSelected(index){
    if(indexselected != index) {
      return false;
    } else {
      return true;
    }
  }

}