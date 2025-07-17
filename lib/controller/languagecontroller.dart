import 'dart:ui';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class LanguageController extends GetxController {
  final RxInt selectlangaue = 0.obs;
  final prefs = GetStorage();

  void setLanguage(int index, String lang) {
    selectlangaue.value = index;

    // save language locale with changes
    prefs.write('language', lang);
    updateLocale(lang);
    update();

    // for update keyboard
    SystemChannels.textInput.invokeMethod('TextInput.setLocale', lang);
  }

  @override
  void onInit() {
    super.onInit();
    // saved language local
   loadSavedLanguage();
  }

  void loadSavedLanguage() {
    String savedLang = prefs.read('language') ?? 'en';
    selectlangaue.value = savedLang == 'ar' ? 1 : 0;
    updateLocale(savedLang);
  }
  void updateLocale(String lang) {
    final newLocale = lang == 'ar'
        ? const Locale('ar', 'SA')
        : const Locale('en', 'US');
    Get.updateLocale(newLocale);
  }
}
