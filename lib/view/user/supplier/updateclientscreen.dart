import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get_storage/get_storage.dart';
import 'package:gold_app/constants/textstyle.dart';
import 'package:gold_app/controller/addclientcontroller.dart';
import 'package:gold_app/controller/favclientcontroller.dart';
import 'package:gold_app/services/api_services.dart';
import 'package:gold_app/widget/mybutton.dart';
import 'package:gold_app/widget/mytextfield.dart';
import 'package:gold_app/widget/snackbar.dart';
import 'package:image_picker/image_picker.dart';

import '../../../constants/colors.dart';

class UpdateClientScreen extends StatefulWidget {
  UpdateClientScreen({super.key, required this.clientData});
  final Map<String, dynamic> clientData;

  @override
  State<UpdateClientScreen> createState() => _UpdateClientScreenState();
}

class _UpdateClientScreenState extends State<UpdateClientScreen> {
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
  FavSupplierController facController = Get.put(FavSupplierController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(facController.id.value);
    firstname = TextEditingController(
      text: widget.clientData['first_name'] ?? '',
    );
    lastname = TextEditingController(
      text: widget.clientData['last_name'] ?? '',
    );
    phone = TextEditingController(
      text: widget.clientData['contact_number'] ?? '',
    );
    password = TextEditingController(text: ''); // Leave empty for security
    email = TextEditingController(text: widget.clientData['email'] ?? '');
    address = TextEditingController(text: widget.clientData['address'] ?? '');
    bussName = TextEditingController(
      text: widget.clientData['busniess_name'] ?? '',
    );
    bussAddress = TextEditingController(
      text: widget.clientData['office_address'] ?? '',
    );
  }

  final GetStorage storage = GetStorage();

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
      appBar: AppBar(title: Text('update_client'.tr)),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'client_info'.tr,
                  style: MyTextstyle.mainTextStyle,
                  textAlign: TextAlign.center,
                ),
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
                                      ? FileImage(
                                        File(
                                          clientController
                                              .clientimage
                                              .value!
                                              .path,
                                        ),
                                      )
                                      : null,
                              child:
                                  clientController.clientimage == null
                                      ? Icon(
                                        Icons.person,
                                        size: 50,
                                        color: Appcolor.mainColor,
                                      )
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
                child: Text(
                  'client_profile'.tr,
                  style: MyTextstyle.subHeadingStyle,
                  textAlign: TextAlign.center,
                ),
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
                alignment: Alignment.centerLeft,
                child: Text(
                  'business_heading'.tr,
                  style: MyTextstyle.mainTextStyle,
                  textAlign: TextAlign.center,
                ),
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
                                  image: FileImage(
                                    File(
                                      (clientController
                                          .bussinessimage
                                          .value!
                                          .path),
                                    ),
                                  ),
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
                child: Text(
                  'business_logo'.tr,
                  style: MyTextstyle.mainHeadingStyle,
                  textAlign: TextAlign.center,
                ),
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
                btntext: 'update_client_btn'.tr,
                ontap: () async {
                  // if (clientController.bussinessimage.value == null ||
                  //     clientController.clientimage.value == null) {
                  //   Get.snackbar(
                  //     'error'.tr,
                  //     'error_message_image'.tr,
                  //     backgroundColor: Colors.red,
                  //     colorText: Colors.white,
                  //     snackPosition: SnackPosition.BOTTOM,
                  //   );
                  //   return;
                  // }
                  if (firstname.text.isEmpty ||
                      // lastname.text.isEmpty ||
                      phone.text.isEmpty
                      // // password.text.isEmpty ||
                      // email.text.isEmpty ||
                      // address.text.isEmpty ||
                      // bussName.text.isEmpty ||
                      // bussAddress.text.isEmpty
                  ) {
                    MySnackBar.showError(
                      'error'.tr,
                      'error_message'.tr,
                    );
                  } else {
                    try {
                      EasyLoading.show(status: 'loading'.tr);
                      print(
                        'Sending update request with ID: ${widget.clientData['id']}',
                      );
                      // Handle profile image

                      final result = await MyApiServices().UpdateClientInfo(
                        businessLogo: clientController.ispicedbusiness.value
                            ? clientController.bussinessimage.value
                            : null,
                        profileImage: clientController.ispicedclient.value
                            ? clientController.clientimage.value
                            : null,
                        id: widget.clientData['id'].toString(),
                        firstname: firstname.text,
                        lastname: lastname.text,
                        phone: phone.text,
                        password: password.text,
                        email: email.text,
                        address: address.text,
                        businessName: bussName.text,
                        businessAddress: bussAddress.text,
                      );

                      if (result['success'] == true) {
                        EasyLoading.dismiss();

                        final favList = storage.read<Map>('favClientMap${facController.id.value}');
                        if (favList != null) {
                          // Get the current client ID
                          final clientId = widget.clientData['id'].toString();

                          // Check if client exists in favorites
                          if (favList.containsKey(clientId)) {
                            // Update the favorite data with new values
                            final updatedClientData = {
                              'id': widget.clientData['id'],
                              'first_name': firstname.text,
                              'last_name': lastname.text,
                              'contact_number': phone.text,
                              'email': email.text,
                              'address': address.text,
                              'busniess_name': bussName.text,
                              'office_address': bussAddress.text,
                              'profile_url': result['data']?['profile_url'] ?? widget.clientData['profile_url'],
                              'busniess_logo_url': result['data']?['busniess_logo_url'] ?? widget.clientData['busniess_logo_url']
                            };

                            favList[clientId] = updatedClientData;
                            storage.write('favClientMap${facController.id.value}', favList);
                            facController.loadFavclient();
                          }
                        }

                        Get.back();
                        MySnackBar.showSuccess(
                          'success'.tr,
                          'success_client_update'.tr,
                        );
                      } else {
                        EasyLoading.dismiss();
                        MySnackBar.showError(
                          'error'.tr,
                          result['message'][0] ?? 'failed_updatet.tr',
                        );
                      }
                    } catch (e) {
                      EasyLoading.dismiss();
                      MySnackBar.showError(
                        'error'.tr,
                        e.toString(),
                      );
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
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Appcolor.iconcolor,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: widget.clientData['busniess_logo_url']!=null?Image.network(
            widget.clientData['busniess_logo_url'],
            fit: BoxFit.cover,
          ):Icon(
            CupertinoIcons.building_2_fill,
            color: Appcolor.mainColor,
            size: 70,
          ),
        ),
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
              backgroundImage: NetworkImage(
                widget.clientData['profile_url'] ?? '',
              ),
              child: widget.clientData['profile_url']==null?Icon(
                Icons.person,
                size: 50,
                color: Appcolor.mainColor,
              ):null,
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
