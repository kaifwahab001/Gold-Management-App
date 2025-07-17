import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:gold_app/constants/textstyle.dart';
import 'package:gold_app/controller/addclientcontroller.dart';
import 'package:gold_app/services/api_services.dart';
import 'package:gold_app/widget/mybutton.dart';
import 'package:gold_app/widget/mytextfield.dart';
import 'package:gold_app/widget/snackbar.dart';

import '../../../constants/colors.dart';

class AddClientScreen extends StatefulWidget {
  AddClientScreen({super.key});

  @override
  State<AddClientScreen> createState() => _AddClientScreenState();
}

class _AddClientScreenState extends State<AddClientScreen> {
  // client detail textController
  TextEditingController firstname = TextEditingController();
  TextEditingController lastname = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController address = TextEditingController();

  //  business textController
  TextEditingController bussName = TextEditingController();
  TextEditingController bussAddress = TextEditingController();

  // Getx controller for saving data into cloud
  AddClientController clientController = Get.put(AddClientController());
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    firstname.dispose();
    lastname.dispose();
    phone.dispose();
    password.dispose();
    email.dispose();
    address.dispose();
    bussName.dispose();
    bussAddress.dispose();
    clientController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('addclient_heading'.tr)),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Align(
                alignment: AlignmentDirectional.centerStart,
                child: Text('client_info'.tr, style: MyTextstyle.mainTextStyle, textAlign: TextAlign.center),
              ),
              const SizedBox(height: 30),
              /*
              Profile picture
               */
              Obx(
                () =>
                    clientController.ispicedclient.value
                        ? Align(
                          alignment: Alignment.center,
                          child: GestureDetector(
                            onTap: () {
                              clientController.pickimage();
                            },
                            child: CircleAvatar(
                              radius: 50,
                              backgroundImage:
                                  clientController.clientimage != null
                                      ? FileImage(File(clientController.clientimage.value!.path))
                                      : null,
                              child:
                                  clientController.clientimage == null
                                      ? Icon(Icons.person, size: 50, color: Appcolor.mainColor)
                                      : null,
                            ),
                          ),
                        )
                        : GestureDetector(
                          onTap: () {
                            clientController.pickimage();
                          },
                          child: profilewidget(),
                        ),
              ),
              const SizedBox(height: 10),
              Align(
                alignment: Alignment.center,
                child: Text('client_profile'.tr, style: MyTextstyle.subHeadingStyle, textAlign: TextAlign.center),
              ),

              const SizedBox(height: 20),

              /*
              First and Last name
               */
              Row(
                children: [
                  Flexible(
                    child: Mytextfield(
                      icon: Icon(Icons.person),
                      controller: firstname,
                      hinttext: 'enter_first_name'.tr,
                      label: 'first_name'.tr,
                      ispassword: false,
                    ),
                  ),
                  const SizedBox(width: 20),
                  Flexible(
                    child: Mytextfield(
                      icon: Icon(Icons.person),
                      controller: lastname,
                      hinttext: 'enter_last_name'.tr,
                      label: 'last_name'.tr,
                      ispassword: false,
                    ),
                  ),
                ],
              ),

              /*
             other details
               */
              const SizedBox(height: 15),
              Mytextfield(
                icon: Icon(Icons.phone),
                controller: phone,
                keytype: TextInputType.phone,
                hinttext: 'enter_your_contact_number'.tr,
                label: 'contact_number'.tr,
                ispassword: false,
              ),
              // const SizedBox(height: 15),
              // Mytextfield(
              //   icon: Icon(Icons.lock),
              //   controller: password,
              //   hinttext: 'enter_password'.tr,
              //   label: 'password'.tr,
              //   ispassword: true,
              // ),
              const SizedBox(height: 15),
              Mytextfield(
                icon: Icon(Icons.email),
                controller: email,
                keytype: TextInputType.emailAddress,
                hinttext: 'enter_email'.tr,
                label: 'email'.tr,
                ispassword: false,
              ),
              const SizedBox(height: 15),
              Mytextfield(
                icon: Icon(CupertinoIcons.location_solid),
                controller: address,
                hinttext: 'enter_address'.tr,
                label: 'address'.tr,
                ispassword: false,
              ),

              /*
              business logo
               */
              const SizedBox(height: 20),
              Align(
                alignment: AlignmentDirectional.centerStart,
                child: Text('business_heading'.tr, style: MyTextstyle.mainTextStyle, textAlign: TextAlign.center),
              ),
              const SizedBox(height: 20),
              Obx(
                () =>
                    clientController.ispicedbusiness.value
                        ? Align(
                          alignment: Alignment.center,
                          child: GestureDetector(
                            onTap: () {
                              clientController.businessPickImage();
                            },
                            child: Container(
                              height: 100,
                              width: 100,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: FileImage(File((clientController.bussinessimage.value!.path))),
                                  fit: BoxFit.cover,
                                ),
                                borderRadius: BorderRadius.circular(10),
                                color: Appcolor.iconcolor,
                              ),
                            ),
                          ),
                        )
                        : GestureDetector(
                          onTap: () {
                            clientController.businessPickImage();
                          },
                          child: Businesslogo(),
                        ),
              ),
              const SizedBox(height: 10),
              Align(
                alignment: Alignment.center,
                child: Text('business_logo'.tr, style: MyTextstyle.subHeadingStyle, textAlign: TextAlign.center),
              ),

              /*
              Business details
               */
              const SizedBox(height: 30),
              Mytextfield(
                icon: Icon(Icons.business_sharp),
                controller: bussName,
                hinttext: 'enter_businsess_name'.tr,
                label: 'business_name'.tr,
                ispassword: false,
              ),
              const SizedBox(height: 15),
              Mytextfield(
                icon: Icon(CupertinoIcons.location_solid),
                controller: bussAddress,
                hinttext: 'enter_office_address'.tr,
                label: 'office_address'.tr,
                ispassword: false,
              ),
              const SizedBox(height: 50),

              /*
              Button for save info
               */
              Mybutton(
                btntext: 'add_client_btn'.tr,
                ontap: () async {
                  // if (clientController.clientimage.value == null ||
                  //     clientController.bussinessimage.value == null) {
                  //   Get.snackbar(
                  //     'error'.tr,
                  //     'Please select both profile and business images',
                  //     backgroundColor: Colors.red,
                  //     colorText: Colors.white,
                  //     snackPosition: SnackPosition.BOTTOM,
                  //   );
                  //   return;
                  // }

                  if (firstname.text.isEmpty ||
                      // lastname.text.isEmpty ||
                      phone.text.isEmpty
                  // password.text.isEmpty ||
                  // email.text.isEmpty ||
                  // address.text.isEmpty ||
                  // bussName.text.isEmpty ||
                  // bussAddress.text.isEmpty
                  ) {
                    MySnackBar.showError('error'.tr, 'error_message'.tr);
                  } else {
                    try {
                      EasyLoading.show(status: 'Please wait');
                      final result = await MyApiServices().createClientusingMultirequest2(
                        businessLogo: clientController.clientimage.value,
                        profileImage: clientController.bussinessimage.value,
                        firstname: firstname.text,
                        lastname: lastname.text,
                        phone: phone.text,
                        // password: password.text,
                        email: email.text,
                        address: address.text,
                        businessName: bussName.text,
                        businessAddress: bussAddress.text,
                      );

                      if (result['success'] == true) {
                        EasyLoading.dismiss();
                        Get.back();
                        MySnackBar.showSuccess('success'.tr, 'success_message'.tr);
                      } else {
                        EasyLoading.dismiss();
                        MySnackBar.showError('error'.tr, result['message'][0] ?? 'Failed to update client');
                      }
                    } catch (e) {
                      EasyLoading.dismiss();
                      MySnackBar.showError('error'.tr, e.toString());
                    }
                  }
                },
              ),
              SizedBox(height: 60),
            ],
          ),
        ),
      ),
    );
  }

  Align Businesslogo() {
    return Align(
      alignment: Alignment.center,
      child: Container(
        height: 100,
        width: 100,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Appcolor.iconcolor),
        child: Icon(CupertinoIcons.building_2_fill, color: Appcolor.mainColor, size: 70),
      ),
    );
  }

  Align profilewidget() {
    return Align(
      alignment: Alignment.center,
      child: SizedBox(
        height: 100,
        width: 100,
        child: Stack(
          children: [
            CircleAvatar(
              backgroundColor: Appcolor.iconcolor,
              radius: 50,
              child: Icon(Icons.person, size: 50, color: Appcolor.mainColor),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: CircleAvatar(
                backgroundColor: Appcolor.mainColor,
                radius: 20,
                child: Icon(Icons.camera_alt, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
