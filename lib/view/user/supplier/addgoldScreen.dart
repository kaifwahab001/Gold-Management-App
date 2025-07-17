import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:gold_app/controller/addoGold_controller.dart';
import 'package:gold_app/services/api_services.dart';
import 'package:gold_app/widget/mybutton.dart';
import 'package:gold_app/widget/mytextfield.dart';
import 'package:gold_app/widget/snackbar.dart';
import '../../../constants/colors.dart';
import '../../../constants/textstyle.dart';

class AddGoldScreen extends StatefulWidget {
  AddGoldScreen({super.key});

  @override
  State<AddGoldScreen> createState() => _AddGoldScreenState();
}

class _AddGoldScreenState extends State<AddGoldScreen> {
  String? selectedClient;
  String? selectedGoldType;
  int? currentId;
  List<dynamic> clientList = [];
  bool isLoading = true;
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController goldrecieveddController = TextEditingController();
  final TextEditingController netWeightController = TextEditingController();
  final TextEditingController tehleelController = TextEditingController();
  final TextEditingController rateController = TextEditingController();
  final TextEditingController gold21KController = TextEditingController();
  final TextEditingController totalValueController = TextEditingController();
  
  
  

  final ADDGoldController goldController = Get.put(ADDGoldController());

  @override
  void initState() {
    super.initState();
    loadClients();
  }

  Future<void> loadClients() async {
    try {
      final data = await goldController.getdata();
      setState(() {
        clientList = data;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    _dateController.dispose();
    goldrecieveddController.dispose();
    netWeightController.dispose();
    tehleelController.dispose();
    rateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print(selectedClient);
    print(selectedGoldType);
    return Scaffold(
      appBar: AppBar(title: Text('add_gold'.tr)),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 28.0, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 15),
              Text('select_client'.tr),
              const SizedBox(height: 5),
              buildClientDropdown(),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildClientDropdown() {
    if (isLoading) {
      return Center(
        child: Container(
          height: Get.height * 0.5,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(color: Appcolor.mainColor),
              SizedBox(height: 10),
              Text('loading'.tr, style: MyTextstyle.subTextStyle),
            ],
          ),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 50,
          padding: EdgeInsets.symmetric(horizontal: 20),
          decoration: ShapeDecoration(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
              side: BorderSide(color: Colors.grey),
            ),
          ),
          width: double.maxFinite,
          child: DropdownButton<String>(
            value: selectedClient,
            isExpanded: true,
            underline: SizedBox(),
            hint: Text('select_client'.tr),
            menuMaxHeight: Get.height * 0.5,
            items:
                clientList.map<DropdownMenuItem<String>>((dynamic value) {
                  String fullName =
                      '${value['first_name']} ${value['last_name']}';
                  return DropdownMenuItem<String>(
                    value: fullName,
                    child: Text(fullName),
                  );
                }).toList(),
            onChanged: (String? newValue) {
              setState(() {
                selectedClient = newValue;
                if (newValue != null) {
                  var selectedClient = clientList.firstWhere((client) {
                    String clientName =
                        '${client['first_name']} ${client['last_name']}';
                    return clientName == newValue;
                  });
                  currentId = selectedClient['id'];
                  // print('Selected Client ID: $currentId');
                }
              });
            },
          ),
        ),
        const SizedBox(height: 15),

        Text('gold_type'.tr),
        const SizedBox(height: 5),
        Container(
          height: 48,
          padding: EdgeInsets.symmetric(horizontal: 15),
          decoration: ShapeDecoration(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: BorderSide(color: Colors.grey.shade400),
            ),
          ),
          width: double.maxFinite,
          child: DropdownButton<String>(
            value: selectedGoldType,
            isExpanded: true,
            hint: Text('gold_type'.tr),
            underline: SizedBox(),
            items:
                ['recieved', 'returned'].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
            onChanged: (newValue) {
              setState(() {
                selectedGoldType = newValue;
              });
            },
          ),
        ),

        recieveddGold(context),

        const SizedBox(height: 25),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Mybutton(
              btnclr: Colors.blueGrey.shade400,
              size: Size(100, 30),
              btntext: 'image'.tr,
              ontap: () => goldController.picImage(),
            ),
            Obx(
              () => Row(
                children: [
                  Text(
                    goldController.image.value == null
                        ? 'choose_image'.tr
                        : goldController.image.value!.path.split('/').last,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                  const SizedBox(width: 20),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 50),

        // main button for submit the value
        Align(
          alignment: Alignment.center,
          child: Mybutton(
            btntext: 'submit'.tr,
            ontap: () async {
              if (selectedClient == null) {
                MySnackBar.showError(
                  'error'.tr,
                  'gold_select_error'.tr,
                );
                return;
              }
              if (_dateController.text.isEmpty ||
                  goldrecieveddController.text.isEmpty ||
                  netWeightController.text.isEmpty ||
                  tehleelController.text.isEmpty ||
                  selectedGoldType == null ||
                  rateController.text.isEmpty) {
                MySnackBar.showError(
                  'error'.tr,
                  'error_message'.tr,
                );
              } else {
                try {
                  EasyLoading.show(status: 'Please wait');
                  final result = await MyApiServices().createGoldApi(
                      client_id: currentId.toString(),
                      gold_type: selectedGoldType.toString(),
                      recieved_at: selectedGoldType == 'recieved' ? _dateController.text : '',
                      deliver_at: selectedGoldType == 'recieved' ? '' : _dateController.text,
                      gold_recieve: selectedGoldType == 'recieved' ? goldrecieveddController.text : '',
                      gold_given: selectedGoldType == 'recieved' ? '' : goldrecieveddController.text,
                      net_weight: selectedGoldType == 'recieved' ? netWeightController.text : '',
                      delivery_netWeight: selectedGoldType == 'recieved' ? '' : netWeightController.text,
                      tahleel: selectedGoldType == 'recieved' ? tehleelController.text : '',
                      delivery_tehleel: selectedGoldType == 'recieved' ? '' : tehleelController.text,
                      gold_karat: gold21KController.text, // Changed to .text
                      rate_per_gram: rateController.text,
                      total_value: totalValueController.text, // Changed to .text
                      supplier_id: goldController.supplierId.value.toString(),
                      picture: goldController.image.value?.path // Changed to optional path
                  );
                  if (result['success'] == true) {
                    EasyLoading.dismiss();
                    Get.back();
                    MySnackBar.showSuccess(
                      'success'.tr,
                      'gold_success'.tr,
                    );
                  } else {
                    EasyLoading.dismiss();
                    MySnackBar.showError(
                      'error'.tr,
                      result['message'][0] ?? 'Failed to Create Gold',
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
        ),
        const SizedBox(height: 30),
      ],
    );
  }

  Column recieveddGold(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 25),
        ADDGoldTextField(
          Iconntap: () async {
            final pickedDate = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(2000),
              lastDate: DateTime(2030),
            );
            if (pickedDate != null) {
              setState(() {
                _dateController.text =
                    "${pickedDate.day.toString().padLeft(2, '0')}/"
                    "${pickedDate.month.toString().padLeft(2, '0')}/"
                    "${pickedDate.year}";
              });
            }
          },
          hinttext: 'DD/MM/YYYY',
          label:
              selectedGoldType == 'recieved'
                  ? 'recievedd_date'.tr
                  : 'deliver_date'.tr,
          controller: _dateController,
          ispassword: false,
          icon: Icon(Icons.date_range_outlined),
          keytype: TextInputType.datetime,
          isSufficIcon: true,
        ),
        const SizedBox(height: 25),
        ADDGoldTextField(
          controller: goldrecieveddController,
          hinttext: '',
          label:
              selectedGoldType == 'recieved'
                  ? 'recievedd_gold'.tr
                  : 'gold_given'.tr,
          ispassword: false,
          keytype: TextInputType.text,
          isSufficIcon: false,
          icon: Icon(null),
          Iconntap: () {},
        ),
        const SizedBox(height: 25),
        ADDGoldTextField(
          controller: netWeightController,
          hinttext: '',
          label:
              selectedGoldType == 'recieved'
                  ? 'net_weight'.tr
                  : 'deliver_netWeight'.tr,
          ispassword: false,
          keytype: TextInputType.number,
          isSufficIcon: false,
          icon: Icon(null),
          Iconntap: () {},
          onchange: (p0) {
            double gold21k = (double.parse(netWeightController.text)*double.parse(tehleelController.text)/875);
            gold21KController.text = gold21k.toStringAsFixed(2);

            double totalvalue = double.parse(netWeightController.text)*double.parse(rateController.text);
            totalValueController.text = totalvalue.toStringAsFixed(2);
          },
        ),
        const SizedBox(height: 25),
        ADDGoldTextField(
          controller: tehleelController,
          onchange: (value) {
            double gold21k = (double.parse(netWeightController.text)*double.parse(tehleelController.text)/875);
            gold21KController.text = gold21k.toStringAsFixed(2);

          },
          hinttext: '',
          label:
              selectedGoldType == 'recieved'
                  ? 'tehleel'.tr
                  : 'delivery_tehleel'.tr,
          ispassword: false,
          keytype: TextInputType.number,
          isSufficIcon: false,
          icon: Icon(null),
          Iconntap: () {},
        ),
        const SizedBox(height: 25),
        ADDGoldTextField(
          readOnly: true,
          controller: gold21KController,
          hinttext: '',
          label: 'gold_21k'.tr,
          ispassword: false,
          keytype: TextInputType.number,
          isSufficIcon: false,
          icon: Icon(null),
          Iconntap: () {},
        ),
        const SizedBox(height: 25),
        ADDGoldTextField(
          controller: rateController,
          hinttext: '',
          label: 'rate'.tr,
          ispassword: false,
          keytype: TextInputType.number,
          isSufficIcon: false,
          icon: Icon(null),
          Iconntap: () {},
          onchange: (value) {
           double totalvalue = double.parse(netWeightController.text)*double.parse(rateController.text);
           totalValueController.text = totalvalue.toStringAsFixed(2);
          },
        ),
        const SizedBox(height: 25),
        ADDGoldTextField(
          readOnly: true,
          controller: totalValueController,
          hinttext: '',
          label: 'total_value'.tr,
          ispassword: false,
          keytype: TextInputType.number,
          isSufficIcon: false,
          icon: Icon(null),
          Iconntap: () {},
        ),
      ],
    );
  }
}
