import 'package:get/get.dart';

class EyebuttonController extends GetxController{
  var isvisible = true.obs;

  void changeVisibility(){
    isvisible.value = !isvisible.value;
  }
}