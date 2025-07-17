import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gold_app/constants/colors.dart';
import 'package:gold_app/constants/textstyle.dart';
import 'package:gold_app/controller/gold_screen_controller.dart';
import 'package:gold_app/services/api_services.dart';
import 'package:gold_app/view/user/supplier/addgoldScreen.dart';
import 'package:gold_app/widget/inventory_gold_details_cards.dart';
import '../../../controller/user_check_controller.dart';
import '../../../widget/mybutton.dart';

class InventoryScreen extends StatefulWidget {
  InventoryScreen({super.key});

  @override
  State<InventoryScreen> createState() => _InventoryScreenState();
}

class _InventoryScreenState extends State<InventoryScreen> {
  String? selectedValue;
  int? currentId;
  final goldController = Get.put(GoldScreenController());
  final MyApiServices services = MyApiServices();

  Map<String, dynamic> clientData = Map();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    onRefresh();
  }
  Future<void> onRefresh() async {
    try{
      final response = await services.goldClientDetails(currentId!);
      if (response != null && response['success']) {
        setState(() {
          clientData = response['data']['data'] ?? {};
        });
      } else {
       print('somethign wen wrong');
      }
    } catch (e) {
      print('Error fetching gold client details: $e');

    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('gold'.tr),
          actions: [
            Mybutton(
              btntext: 'add_gold'.tr,
              // ontap: () {
              //   Get.to(() => AddGoldScreen());
              // },
              ontap: () async {
                await Get.to(() => AddGoldScreen());
                onRefresh();
              },
              textclr: Appcolor.mainColor,
              btnclr: Colors.white,
              size:Size(125, 40),
            ),
            const SizedBox(width: 10),
          ],
        ),
        body:
        RefreshIndicator(
          onRefresh: onRefresh,
          child:SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 28.0, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('gold'.tr, style: MyTextstyle.mainTextStyle),
                  Divider(),
                  const SizedBox(height: 20),

                  // main item list
                  Text('select_client'.tr),
                  const SizedBox(height: 10),

                  StreamBuilder<List<dynamic>>(
                    stream: goldController.getdata().asStream(),
                    builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: Container(
                            height: Get.height * 0.5,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CircularProgressIndicator(
                                  color: Appcolor.mainColor,
                                ),
                                SizedBox(height: 10),
                                Text('loading'.tr, style: MyTextstyle.subTextStyle),
                              ],
                            ),
                          ),
                        );
                      }

                      if (snapshot.hasError) {
                        return Center(
                          child: Container(
                            height: Get.height * 0.5,
                            alignment: Alignment.center,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Something went wrong! login again',
                                  style: TextStyle(color: Colors.red, fontSize: 16),
                                ),
                                const SizedBox(height: 50),
                                Mybutton(
                                  btntext: 'try_again'.tr,
                                  ontap: () {
                                    UserCheckController().logout();
                                  },
                                ),
                              ],
                            ),
                          ),
                        );
                      }

                      if (!snapshot.hasData ||
                          snapshot.data == null ||
                          snapshot.data!.isEmpty) {
                        return Center(
                          child: Container(
                            alignment: Alignment.center,
                            height: Get.height * 0.5,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [Text('no_data'.tr)],
                            ),
                          ),
                        );
                      }

                      final list = snapshot.data!;
                      return Column(
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
                              // padding: EdgeInsets.only(top: 50, left: 20, right: 20),
                              value: selectedValue,
                              isExpanded: true,
                              underline: SizedBox(),
                              hint: Text('select_client'.tr),
                              menuMaxHeight: Get.height * 0.5,
                              items:
                              list.map<DropdownMenuItem<String>>((
                                  dynamic value,
                                  ) {
                                String fullName =
                                    '${value['first_name']} ${value['last_name']}';
                                return DropdownMenuItem<String>(
                                  value: fullName,
                                  child: Text(fullName),
                                );
                              }).toList(),
                              onChanged: (String? newValue) async {
                                setState(() {
                                  selectedValue = newValue;
                                  if (newValue != null) {
                                    var selectedClient = list.firstWhere((client) {
                                      String clientName =
                                          '${client['first_name']} ${client['last_name']}';
                                      return clientName == newValue;
                                    });
                                    currentId = selectedClient['id'];
                                    // print('Selected Client ID: $currentId');
                                  }
                                });
                                final response = await MyApiServices().goldClientDetails(currentId!);
                                print(currentId);
                                print(response);

                                setState(() {
                                  clientData = response['data']['data'];
                                });
                                // goldController.response);

                              },
                            ),
                          ),
                          const SizedBox(height: 20),
                          InventoryGoldDetailsCards(clientData: clientData, onRefresh:onRefresh,
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        )
    );
  }
}