import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:gold_app/constants/colors.dart';
import 'package:gold_app/lang.dart';
import 'package:gold_app/view/auth/languagescreen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'constants/textstyle.dart';
import 'controller/favclientcontroller.dart';
import 'view/splashscreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  final prefs = GetStorage();
  String savedLang = prefs.read('language') ?? 'en';

  // for locking the orientation of an app
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp
  ]).then(
    (value) => runApp(
      GetMaterialApp(
        debugShowCheckedModeBanner: false,
        builder: EasyLoading.init(),
        translations: Localization(),
        locale: Locale(savedLang, savedLang == 'ar' ? 'SA' : 'US'),
        fallbackLocale: const Locale('en', 'US'),
        theme: ThemeData(
          useMaterial3: true,
          scaffoldBackgroundColor: Appcolor.scaffoldBackgroundColor,
          appBarTheme: AppBarTheme(
            centerTitle: true,
            titleTextStyle: MyTextstyle.appbarStyle,
            backgroundColor: Appcolor.appbarColor,
          ),
        ),
        home: SplashScreeen(),
        // home: LanguageScreen(),
      ),
    ),
  );

  ;
}
