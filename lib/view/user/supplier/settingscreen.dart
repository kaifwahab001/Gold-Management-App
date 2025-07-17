import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:gold_app/constants/imageUrl.dart';
import 'package:gold_app/constants/textstyle.dart';
import '../../../constants/colors.dart';
import '../../../controller/languagecontroller.dart';
import '../../../controller/user_check_controller.dart';

class Settingscreen extends StatelessWidget {
  Settingscreen({super.key});
  final LanguageController controller = Get.put(LanguageController());

  final List<Map<String, dynamic>> list = [
    {
      'name': 'select_language',
      'icon': Icon(Icons.language, color: Appcolor.mainColor),
    },
    {'name': 'logout', 'icon': Icon(Icons.logout, color: Appcolor.mainColor)},
  ];

  final storage = GetStorage();

  @override
  Widget build(BuildContext context) {
    final userdata = storage.read('userData');
    ;
    print(userdata);
    return Scaffold(
      appBar: AppBar(title: Text('setting-scr'.tr)),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 28.0, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text('setting'.tr, style: MyTextstyle.mainTextStyle),
            ),

            const SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                print(userdata);
              },
              child: Container(
                height: 100,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: NetworkImage(
                      userdata['data']['user']['profile_url'] ?? personUrl,

                    ),
                    fit: BoxFit.contain
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              "${userdata['data']['user']['email']}",
              style: MyTextstyle.mainTextStyle,
            ),
            const SizedBox(height: 5),
            Text(
              "${userdata['data']['user']['contact_number']}",
              style: MyTextstyle.labelStyle,
              textDirection: TextDirection.ltr,
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: ListTile(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: BorderSide(color: Colors.grey.shade400),
                      ),
                      title: Text(
                        list[index]['name'].toString().tr,
                        style: MyTextstyle.mainHeadingStyle,
                      ),
                      leading: list[index]['icon'],
                      trailing: Icon(
                        CupertinoIcons.right_chevron,
                        color: Appcolor.mainColor,
                        size: 20,
                      ),
                      onTap: () {
                        if (index == 0) {
                          // Show language selection dialog
                          Get.dialog(
                            AlertDialog(
                              backgroundColor: Appcolor.mainColor,
                              titleTextStyle: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                              ),
                              title: Text('select_language'.tr),
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  ListTile(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      side: BorderSide(color: Colors.white),
                                    ),
                                    title: const Text('English'),
                                    onTap: () {
                                      controller.setLanguage(0, 'en');
                                      Get.back();
                                    },
                                  ),
                                  const SizedBox(height: 10),
                                  ListTile(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      side: BorderSide(color: Colors.white),
                                    ),
                                    title: const Text('العربية'),
                                    onTap: () {
                                      controller.setLanguage(1, 'ar');
                                      Get.back();
                                    },
                                  ),
                                ],
                              ),
                            ),
                          );
                        } else if (index == 1) {
                          // Handle logout
                          UserCheckController().logout();
                        }
                      },
                    ),
                  );
                },
                itemCount: list.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
