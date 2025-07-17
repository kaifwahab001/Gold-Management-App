import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gold_app/constants/colors.dart';
import 'package:gold_app/constants/textstyle.dart';
import 'package:gold_app/widget/mybutton.dart';
import 'package:gold_app/widget/myotptextfiled.dart';


class OTPScreen extends StatelessWidget {
  const OTPScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'verify_otp'.tr,
        ),
        foregroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 100),
              Icon(Icons.verified,size: 100,color: Appcolor.mainColor,),
              SizedBox(height: 20),
              Text(
                'verification'.tr,
                style: MyTextstyle.mainTextStyle,
              ),
              SizedBox(height: 8),
              Text(
                'sent'.tr,
                style: MyTextstyle.subTextStyle,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 50),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Myotptextfiled(
                    onchanged: (value) {
                      if (value.length == 1) {
                        FocusScope.of(context).nextFocus();
                      } else {
                        FocusScope.of(context).previousFocus();
                      }
                    },
                  ),
                  const SizedBox(width: 10),
                  Myotptextfiled(
                    onchanged: (value) {
                      if (value.length == 1) {
                        FocusScope.of(context).nextFocus();
                      } else {
                        FocusScope.of(context).previousFocus();
                      }
                    },
                  ),
                  const SizedBox(width: 10),
                  Myotptextfiled(
                    onchanged: (value) {
                      if (value.length == 1) {
                        FocusScope.of(context).nextFocus();
                      } else {
                        FocusScope.of(context).previousFocus();
                      }
                    },
                  ),
                  const SizedBox(width: 10),
                  Myotptextfiled(
                    onchanged: (value) {
                      if (value.length == 1) {
                        FocusScope.of(context).nextFocus();
                      } else {
                        FocusScope.of(context).previousFocus();
                      }
                    },
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'no_code'.tr,
                    style: MyTextstyle.subTextStyle,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(width: 20,),
                  Text(
                    'second'.tr,
                    style: MyTextstyle.secondSubTextStyle,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              const SizedBox(height: 50),
              Mybutton(btntext: 'verify_btn'.tr, ontap: () {

              }),
            ],
          ),
        ),
      ),
    );
  }
}
