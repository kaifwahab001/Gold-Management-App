import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MySnackBar {
  static void showSuccess([heading, message,  duration =  const  Duration(seconds: 2)]) {
    Get.snackbar(
      heading,
      message,
      snackPosition: SnackPosition.TOP,
      colorText: Colors.white,
      backgroundColor: Colors.green,
      duration: duration,
    );
  }

  static void showError(heading, message) {
    Get.snackbar(
      heading,
      message,
      snackPosition: SnackPosition.TOP,
      colorText: Colors.white,
      backgroundColor: Colors.red,
    );
  }
}
