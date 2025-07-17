import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:gold_app/controller/update_goldController.dart';
import 'package:gold_app/services/api_services.dart';
import 'package:gold_app/widget/mybutton.dart';
import 'package:gold_app/widget/mytextfield.dart';
import 'package:gold_app/widget/snackbar.dart';
import '../../../constants/textstyle.dart';

class UpdateGoldScreen extends StatefulWidget {
  UpdateGoldScreen( {super.key, required this.clientData, required this.id});
  final Map<String,dynamic> clientData;
  final int id;
  @override
  State<UpdateGoldScreen> createState() => _UpdateGoldScreenState();
}

class _UpdateGoldScreenState extends State<UpdateGoldScreen> {
  String? selectedClient;
  String? selectedGoldType;
  int? currentId;
  final TextEditingController dateController = TextEditingController();
  final TextEditingController goldReceivedController = TextEditingController();
  final TextEditingController netWeightController = TextEditingController();
  final TextEditingController tehleelController = TextEditingController();
  final TextEditingController rateController = TextEditingController();
  final TextEditingController gold21KController = TextEditingController();
  final TextEditingController totalValueController = TextEditingController();

  final  UpdateGoldController goldController = Get.put(UpdateGoldController());

  @override
  void initState() {
    super.initState();
    dateController.text = widget.clientData['recieved_at']!='-'?widget.clientData['recieved_at'].toString() : widget.clientData['returned_at'].toString();
    goldReceivedController.text = widget.clientData['gold_recieve'].toString().isNotEmpty ? widget.clientData['gold_recieve'] : widget.clientData['gold_given'];
    netWeightController.text = widget.clientData['net_weight']??widget.clientData['returned_net_weight'] ;
    tehleelController.text = widget.clientData['tahleel']??widget.clientData['returned_tahleel'];
    rateController.text = widget.clientData['rate_per_gram'];
    gold21KController.text = widget.clientData['gold_karat'];
    totalValueController.text = widget.clientData['total_value'];
  }

  @override
  void dispose() {
    dateController.dispose();
    goldReceivedController.dispose();
    netWeightController.dispose();
    tehleelController.dispose();
    rateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print(widget.clientData);
    return Scaffold(
      appBar: AppBar(title: Text('update_gold'.tr)),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 28.0, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text('Client Name',style: MyTextstyle.labelStyle,),
                  Spacer(),
                  Text('${widget.clientData['client']['first_name']} ${widget.clientData['client']['last_name']}',style: MyTextstyle.subHeadingStyle,)
                ],
              ),
              if (widget.clientData['gold_type'] == 'returned')
                returnedGold(context)
              else
                receivedGold(context),

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
                  btntext: 'update_gold_btn'.tr,
                  ontap: () async {
                    if (dateController.text.isEmpty ||
                        goldReceivedController.text.isEmpty ||
                        netWeightController.text.isEmpty ||
                        tehleelController.text.isEmpty ||
                        rateController.text.isEmpty) {
                      MySnackBar.showError(
                        'error'.tr,
                        'error_message'.tr,
                      );
                    } else {
                      try {
                        EasyLoading.show(status: 'Please wait');
                        final result = await MyApiServices().updateGoldApi(
                            client_id: widget.clientData['client_id'].toString(),
                            gold_id: widget.clientData['id'].toString(),
                            gold_type: widget.clientData['gold_type'],
                            recieved_at: widget.clientData['recieved_at']!='-' ? dateController.text : '',
                            deliver_at: widget.clientData['recieved_at']!='-'? '' : dateController.text,
                            gold_recieve:  widget.clientData['gold_recieve'].toString().isNotEmpty ? goldReceivedController.text : '',
                            gold_given:  widget.clientData['gold_recieve'].toString().isNotEmpty? '' : goldReceivedController.text,
                            net_weight: widget.clientData['net_weight']!=null? netWeightController.text:'' ,
                            delivery_netWeight:  widget.clientData['net_weight']!=null? '': netWeightController.text,
                            tahleel: widget.clientData['tahleel']!=null? tehleelController.text : '',
                            delivery_tehleel: widget.clientData['tahleel']!=null ? '' : tehleelController.text,
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
                            'gold_success_update'.tr,
                          );
                        } else {
                          EasyLoading.dismiss();
                          MySnackBar.showError(
                            'error'.tr,
                            result['message'][0] ?? 'Failed to Update Gold',
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
          ),
        ),
      ),
    );
  }

  Column receivedGold(BuildContext context) {
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
                dateController.text =
                "${pickedDate.day.toString().padLeft(2, '0')}/"
                    "${pickedDate.month.toString().padLeft(2, '0')}/"
                    "${pickedDate.year}";
              });
            }
          },
          hinttext: 'DD/MM/YYYY',
          label: 'recievedd_date'.tr,
          controller: dateController,
          ispassword: false,
          icon: Icon(Icons.date_range_outlined),
          keytype: TextInputType.datetime,
          isSufficIcon: true,
        ),
        const SizedBox(height: 25),
        ADDGoldTextField(
          controller: goldReceivedController,
          hinttext: '',
          label: 'recievedd_gold'.tr,
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
          label: 'net_weight'.tr,
          ispassword: false,
          keytype: TextInputType.number,
          isSufficIcon: false,
          icon: Icon(null),
          Iconntap: () {},
          onchange: (value) {
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
          label: 'tehleel'.tr,
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



  Column returnedGold(BuildContext context) {
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
                dateController.text =
                "${pickedDate.day.toString().padLeft(2, '0')}/"
                    "${pickedDate.month.toString().padLeft(2, '0')}/"
                    "${pickedDate.year}";
              });
            }
          },
          hinttext: 'DD/MM/YYYY',
          label: 'deliver_date'.tr,
          controller: dateController,
          ispassword: false,
          icon: Icon(Icons.date_range_outlined),
          keytype: TextInputType.datetime,
          isSufficIcon: true,
        ),
        const SizedBox(height: 25),
        ADDGoldTextField(
          controller: goldReceivedController,
          hinttext: '',
          label: 'gold_given'.tr,
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
          label: 'deliver_netWeight'.tr,
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
          label: 'delivery_tehleel'.tr,
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
