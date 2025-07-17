import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:gold_app/constants/colors.dart';
import 'package:gold_app/constants/imageUrl.dart';
import 'package:gold_app/constants/textstyle.dart';
import 'package:gold_app/controller/languagecontroller.dart';
import 'package:gold_app/view/auth/singinscreen.dart';
import 'package:gold_app/widget/mybutton.dart';

class LanguageScreen extends StatelessWidget {
  LanguageScreen({super.key});

  final LanguageController controller = Get.put(LanguageController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('select_language'.tr)),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // image
          Stack(
            children: [
              Container(
              height: MediaQuery.of(context).size.height * .5,
              width: double.maxFinite,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                    languageScreen,
                  ),
                  fit: BoxFit.cover,
                ),
              ),
              foregroundDecoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.white.withOpacity(0.1),
                    Colors.white.withOpacity(0.3),
                    Appcolor.scaffoldBackgroundColor.withOpacity(0.8),
                    Appcolor.scaffoldBackgroundColor,
                  ],
                  stops: const [0.2, 0.6, 0.7, 0.9],
                ),
              ),
              alignment: Alignment.bottomLeft,
            ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30,vertical: 30),
                child: Container(
                  height:MediaQuery.of(context).size.height * .45,
                  alignment:Get.locale?.languageCode == 'ar' ? Alignment.bottomRight:Alignment.bottomLeft,
                  // child: Text('Welcome to',style: MyTextstyle.languagescreenStyle,),
                  child: Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(text: 'welcome_to'.tr, style: MyTextstyle.languageScreenStyle),
                          TextSpan(text: 'splashText'.tr, style: MyTextstyle.languageScreenNameStyle),
                        ],
                      )
                  ),
                ),
              )
    ]
          ),

          const SizedBox(height: 20,),
          Text('choose_language'.tr,style: MyTextstyle.languageScreenSubStyle,),
          const SizedBox(height: 30,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Obx(
                () => GestureDetector(
                  onTap: () {
                    controller.setLanguage(0, 'en');
                  },
                  child: Container(
                    alignment: Alignment.center,
                    height: 50,
                    width: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color:
                            controller.selectlangaue.value == 0
                                ? Appcolor.mainColor
                                : Colors.grey.shade500,
                      ),
                    ),
                    child: Text(
                      'English',
                      style: TextStyle(
                        color:
                            controller.selectlangaue.value == 0
                                ? Appcolor.mainColor
                                : Colors.grey.shade500,
                        fontSize: controller.selectlangaue.value == 0 ? 20 : 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 20),
              Obx(
                () => GestureDetector(
                  onTap: () {
                    controller.setLanguage(1, 'ar');
                  },
                  child: Container(
                    alignment: Alignment.center,
                    height: 50,
                    width: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color:
                            controller.selectlangaue.value == 1
                                ? Appcolor.mainColor
                                : Colors.grey.shade500,
                      ),
                    ),
                    child: Text(
                      'العربية',
                      style: TextStyle(
                        color:
                            controller.selectlangaue.value == 1
                                ? Appcolor.mainColor
                                : Colors.grey.shade500,
                        fontSize: controller.selectlangaue.value == 1 ? 20 : 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 50),
          Mybutton(
            btntext: 'select'.tr,
            ontap: () {
              Get.off(() => Singinscreen());
            },
          ),
        ],
      ),
    );
  }
}
