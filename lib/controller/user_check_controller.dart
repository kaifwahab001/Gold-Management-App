import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:gold_app/services/auth_sevices.dart';
import 'package:gold_app/view/user/client/clientbottomnavbar.dart';
import 'package:gold_app/view/user/client/clientviewscreen.dart';
import 'package:gold_app/view/auth/languagescreen.dart';
import 'package:gold_app/widget/snackbar.dart';
import '../view/auth/singinscreen.dart';
import '../view/user/supplier/supplierbottomnavbar.dart';

class UserCheckController extends GetxController {
  RxMap<String, dynamic>? data;
  final storage = GetStorage();
  AuthServices services = AuthServices();

  @override
  void onInit() {
    super.onInit();
    checkAuthStatus();
  }

  void checkAuthStatus() async {
    await Future.delayed(const Duration(seconds: 3)); // Splash delay
    final isFirstTime = storage.read('isFirstTime') ?? true;
    final token = storage.read('token');
    final userData = storage.read('userData');

    if (isFirstTime) {
      storage.write('isFirstTime', false);
      Get.offAll(() => LanguageScreen());
    } else if (token != null && userData != null) {
      final userType = storage.read('userType');
      if (userType == 'supplier') {
        Get.offAll(() => SupplierBottomnavbar());
      } else {
        Get.offAll(() => ClientBottomNavBar());
      }
    } else {
      Get.offAll(() => Singinscreen());
    }
  }

  Future<void> checkUser(String contactNumber, String password) async {
    try {
      EasyLoading.show(status: 'Loading');

      // First try supplier login
      final supplierResponse = await services.login(
        contactNumber,
        password,
        'supplier',
      );
      // print(supplierResponse);
      // Check supplier response
      if (supplierResponse['success'] == false) {
        // Supplier login failed, try client login
        final clientResponse = await services.login(
          contactNumber,
          password,
          'client',
        );

        // Always dismiss loading before showing error or success
        EasyLoading.dismiss();

        if (clientResponse['success'] == false) {
          // Both logins failed
          MySnackBar.showError('error'.tr, clientResponse['message']);
          return;
        }

        // Client login successful
        _handleLoginSuccess(clientResponse, 'client');
        return;
      }

      // Always dismiss loading before success
      EasyLoading.dismiss();

      // Supplier login successful
      _handleLoginSuccess(supplierResponse, 'supplier');
    } catch (e) {
      // Ensure loading is dismissed on error
      EasyLoading.dismiss();
      MySnackBar.showError('error'.tr, 'something_went_wrong'.tr);
    }
  }

  void _handleLoginSuccess(Map<String, dynamic> response, String userType) {
    try {
      if (response['data'] == null || response['data']['user'] == null) {
        MySnackBar.showError(
          'error'.tr,
          response['message'] ?? 'invalid_response'.tr,
        );
        return;
      }

      storage.write('token', response['data']['user']['auth_token']);
      storage.write('userData', response);
      storage.write('userType', userType);

      if (userType == 'supplier') {
        Get.offAll(() => SupplierBottomnavbar());
      } else {
        Get.offAll(() => ClientBottomNavBar());
      }

      MySnackBar.showSuccess('successful'.tr, 'login_as_a_$userType'.tr);
    } catch (e) {
      MySnackBar.showError(
        'error'.tr,
        response['message'] ?? 'login_failed'.tr,
      );
    }
  }

  void logout() {
    storage.remove('token');
    storage.remove('userData');
    Get.offAll(() => Singinscreen());
  }
}
