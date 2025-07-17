import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:gold_app/constants/colors.dart';
import 'package:gold_app/constants/imageName.dart';
import 'package:gold_app/constants/imageUrl.dart';
import 'package:gold_app/constants/textstyle.dart';
import 'package:gold_app/controller/user_check_controller.dart';
import 'package:gold_app/view/auth/forgot_passwordscreen.dart';
import 'package:gold_app/widget/mybutton.dart';
import 'package:gold_app/widget/mytextfield.dart';
import 'package:gold_app/widget/snackbar.dart';

class Singinscreen extends StatelessWidget {
  Singinscreen({super.key});

  TextEditingController contactcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();

  UserCheckController controller = Get.put(UserCheckController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: SizedBox(
            width: double.maxFinite,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 60),
                  SizedBox(
                    height: 180,
                    child: Image.asset(assetsImages + logo),
                  ),
                  SizedBox(height: 20),
                  Text('welcome'.tr, style: MyTextstyle.mainTextStyle),
                  SizedBox(height: 8),
                  Text('signin_continue'.tr, style: MyTextstyle.subTextStyle),
                  const SizedBox(height: 50),
                  Mytextfield(
                    icon: Icon(Icons.phone),
                    controller: contactcontroller,
                    ispassword: false,
                    keytype: TextInputType.phone,
                    hinttext: 'enter_your_contact_number'.tr,
                    label: 'contact_number'.tr,
                  ),
                  const SizedBox(height: 20),
                  Mytextfield(
                    icon: Icon(Icons.lock),
                    controller: passwordcontroller,
                    ispassword: true,
                    keytype: TextInputType.text,
                    hinttext: 'enter_your_password'.tr,
                    label: 'password'.tr,
                  ),
                  const SizedBox(height: 12),
                  forgot_password(),
                  // Spacer()
                  const SizedBox(height: 50),
                  Mybutton(
                    ontap: () {
                      // Get.offAll(()=>Dashboardscreen());
                      // final AuthServices services = AuthServices();
                      // final response =await services.login('03115908753', 'Customer@123');
                      // print(response);
                      if (passwordcontroller.text.isEmpty ||
                          contactcontroller.text.isEmpty) {
                        MySnackBar.showError('error'.tr, 'error_message'.tr);
                      } else {
                        controller.checkUser(
                          contactcontroller.text.toString().trim(),
                          passwordcontroller.text.toString().trim(),
                        );
                      }

                      // controller.checkUser('03115908753', 'Customer@123');
                    },
                    btntext: 'signin'.tr,
                  ),
                  // Spacer()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget forgot_password() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        TextButton(
          onPressed: () {
            Get.to(() => ForgotPasswordscreen());
          },
          child: Text('forgot'.tr, style: MyTextstyle.secondSubTextStyle),
        ),
      ],
    );
  }
}
