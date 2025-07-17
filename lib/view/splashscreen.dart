
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:gold_app/constants/imageName.dart';
import 'package:gold_app/constants/imageUrl.dart';
import 'package:gold_app/constants/textstyle.dart';
import 'package:gold_app/controller/user_check_controller.dart';


class SplashScreeen extends StatefulWidget {
  const SplashScreeen({super.key});

  @override
  State<SplashScreeen> createState() => _SplashScreeenState();
}

class _SplashScreeenState extends State<SplashScreeen> {
  final prefs = GetStorage();
  final usechechController = Get.put(UserCheckController());
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        fit: StackFit.expand,
        children: [
          Positioned.fill(
            child: Image.asset(assetsImages + background, fit: BoxFit.cover),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 220, child: Image.asset(assetsImages + logo)),
              const SizedBox(height: 20),
              Text(
                'splashText'.tr,
                style: MyTextstyle.splashscreenStyle,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
