import 'dart:convert';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:gold_app/config/apiconfig.dart';
import 'package:gold_app/widget/snackbar.dart';
import 'package:http/http.dart' as http;

import '../view/auth/singinscreen.dart';

class AuthServices {
  final storage = GetStorage();

  Future<Map<String, dynamic>> login(
    String contactNumber,
    String password,
    String loginType,
  ) async {
    try {
      final loginUrl = ApiConfig.login;
      final response = await http.post(
        Uri.parse(loginUrl),
        body: {
          "contact_number": '+${contactNumber}',
          "password": password,
          "login_type": loginType,
        },
      );

      print(response.body);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data;
      } else {
        final errorData = jsonDecode(response.body);
        print(errorData);
        MySnackBar.showError(
          'Error',
          errorData['message'] ?? 'Login failed',
        );
        return {'error': errorData['message'] ?? 'Login failed'};
      }
    } catch (e) {
      return {'error': 'Connection error: ${e.toString()}'};
    }
  }

  bool isLoggedIn() {
    return storage.read('token') != null;
  }

  void logout() {
    Get.offAll(() => Singinscreen());
  }
}
