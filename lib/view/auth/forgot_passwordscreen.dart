import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:gold_app/constants/colors.dart';
import 'package:gold_app/constants/textstyle.dart';
import 'package:gold_app/view/auth/otpscreen.dart';
import 'package:gold_app/widget/mybutton.dart';

import '../../constants/imageName.dart';
import '../../constants/imageUrl.dart';
import '../../widget/mytextfield.dart';

class ForgotPasswordscreen extends StatelessWidget {
  const ForgotPasswordscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'forgot_pass'.tr,
        ),
        foregroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 100),
              Icon(Icons.lock_reset,size: 100,color: Appcolor.mainColor,),
              SizedBox(height: 20),
              Text(
                'reset_pass'.tr,
                style: MyTextstyle.mainTextStyle,
              ),
              SizedBox(height: 8),
              Text(
                'enter_your_contact_des'.tr,
                style: MyTextstyle.subTextStyle,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 50),
              Mytextfield(
                icon: Icon(Icons.lock),
                ispassword: false,
                hinttext: 'enter_your_contact_number'.tr,
                label: 'contact_number'.tr,
              ),
              const SizedBox(height: 50,),
              Mybutton(btntext: 'send_code'.tr, ontap: (){
                Get.to(()=>OTPScreen());
              })
            ],
          ),
        ),
      ),
    );
  }
}
