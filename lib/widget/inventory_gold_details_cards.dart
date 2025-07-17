import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:gold_app/services/api_services.dart';
import 'package:gold_app/view/user/supplier/update_gold_screen.dart';
import 'package:gold_app/widget/mybutton.dart';
import 'package:url_launcher/url_launcher.dart';

import '../constants/imageUrl.dart';
import '../constants/textstyle.dart';

class InventoryGoldDetailsCards extends StatefulWidget {
  InventoryGoldDetailsCards({super.key, required this.clientData, required this.onRefresh,});

  final Map<String, dynamic> clientData;
  final Future<void> Function() onRefresh;
  @override
  State<InventoryGoldDetailsCards> createState() => _InventoryGoldDetailsCardsState();
}

class _InventoryGoldDetailsCardsState extends State<InventoryGoldDetailsCards> {
  @override
  void initState() {
    super.initState();
    print(widget.clientData);
  }

  @override
  Widget build(BuildContext context) {
    if (widget.clientData.isEmpty || widget.clientData['balance_sheet'] == null) {
      return Column(
        children: [
          Container(
            width: double.maxFinite,
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: ShapeDecoration(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
                side: BorderSide(color: Colors.grey.shade400),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text.rich(
                  style: MyTextstyle.goldInventoryStyleInactive,
                  TextSpan(
                    children: [
                      TextSpan(text: 'gold_contact'.tr),
                      TextSpan(
                        text: '-',
                        style: MyTextstyle.goldInventoryStyleActive,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Text.rich(
                  style: MyTextstyle.goldInventoryStyleInactive,
                  TextSpan(
                    children: [
                      TextSpan(text: 'gold_address'.tr),
                      TextSpan(
                        text: '-',
                        style: MyTextstyle.goldInventoryStyleActive,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Container(
            width: double.maxFinite,
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: ShapeDecoration(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
                side: BorderSide(color: Colors.grey.shade400),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text.rich(
                  style: MyTextstyle.goldInventoryStyleInactive,
                  TextSpan(
                    children: [
                      TextSpan(text: 'gold_gold'.tr),
                      TextSpan(
                        text: '-',
                        style: MyTextstyle.goldInventoryStyleActive,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Text.rich(
                  style: MyTextstyle.goldInventoryStyleInactive,
                  TextSpan(
                    children: [
                      TextSpan(text: 'gold_SAR_cash'.tr),
                      TextSpan(
                        text: '-',
                        style: MyTextstyle.goldInventoryStyleActive,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Container(
            width: double.maxFinite,
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: ShapeDecoration(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
                side: BorderSide(color: Colors.grey.shade400),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text.rich(
                  style: MyTextstyle.goldInventoryStyleInactive,
                  TextSpan(
                    children: [
                      TextSpan(text: 'gold_debit'.tr),
                      TextSpan(
                        text: '-',
                        style: MyTextstyle.goldInventoryStyleActive,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Text.rich(
                  style: MyTextstyle.goldInventoryStyleInactive,
                  TextSpan(
                    children: [
                      TextSpan(text: 'gold_credit'.tr),
                      TextSpan(
                        text: '-',
                        style: MyTextstyle.goldInventoryStyleActive,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Text.rich(
                  style: MyTextstyle.goldInventoryStyleInactive,
                  TextSpan(
                    children: [
                      TextSpan(text: 'gold_total_debit'.tr),
                      TextSpan(
                        text: '-',
                        style: MyTextstyle.goldInventoryStyleActive,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Text.rich(
                  style: MyTextstyle.goldInventoryStyleInactive,
                  TextSpan(
                    children: [
                      TextSpan(text: 'gold_total_credit'.tr),
                      TextSpan(
                        text: '-',
                        style: MyTextstyle.goldInventoryStyleActive,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    }

    final goldsData = widget.clientData['golds']?['data'] ?? [];
    if (goldsData.isEmpty) {
      return Center(
        child: Text('No gold data available'),
      );
    }

    return Column(
      children: [
        Container(
          width: double.maxFinite,
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: ShapeDecoration(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
              side: BorderSide(color: Colors.grey.shade400),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text.rich(
                style: MyTextstyle.goldInventoryStyleInactive,
                TextSpan(
                  children: [
                    TextSpan(text: 'gold_contact'.tr),
                    TextSpan(
                      text: goldsData[0]['client']['contact_number'] ?? '-',
                      style: MyTextstyle.goldInventoryStyleActive,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Text.rich(
                style: MyTextstyle.goldInventoryStyleInactive,
                TextSpan(
                  children: [
                    TextSpan(text: 'gold_address'.tr),
                    TextSpan(
                      text: goldsData[0]['client']['address'] ?? '-',
                      style: MyTextstyle.goldInventoryStyleActive,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        Container(
          width: double.maxFinite,
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: ShapeDecoration(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
              side: BorderSide(color: Colors.grey.shade400),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text.rich(
                style: MyTextstyle.goldInventoryStyleInactive,
                TextSpan(
                  children: [
                    TextSpan(text: 'gold_gold'.tr),
                    TextSpan(
                      text: '${widget.clientData['balance_sheet']['gold_balance']}',
                      style: MyTextstyle.goldInventoryStyleActive,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Text.rich(
                style: MyTextstyle.goldInventoryStyleInactive,
                TextSpan(
                  children: [
                    TextSpan(text: 'gold_SAR_cash'.tr),
                    TextSpan(
                      text: '${widget.clientData['balance_sheet']['cash_balance']}',
                      style: MyTextstyle.goldInventoryStyleActive,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        Container(
          width: double.maxFinite,
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: ShapeDecoration(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: BorderSide(color: Colors.grey.shade400),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text.rich(
                style: MyTextstyle.goldInventoryStyleInactive,
                TextSpan(
                  children: [
                    TextSpan(text: 'gold_debit'.tr),
                    TextSpan(
                      text: '${widget.clientData['balance_sheet']['total_debit_gold']}',
                      style: MyTextstyle.goldInventoryStyleActive,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Text.rich(
                style: MyTextstyle.goldInventoryStyleInactive,
                TextSpan(
                  children: [
                    TextSpan(text: 'gold_credit'.tr),
                    TextSpan(
                      text: '${widget.clientData['balance_sheet']['total_credit_gold']}',
                      style: MyTextstyle.goldInventoryStyleActive,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Text.rich(
                style: MyTextstyle.goldInventoryStyleInactive,
                TextSpan(
                  children: [
                    TextSpan(text: 'gold_total_debit'.tr),
                    TextSpan(
                      text: '${widget.clientData['balance_sheet']['total_debit_cash']}',
                      style: MyTextstyle.goldInventoryStyleActive,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Text.rich(
                style: MyTextstyle.goldInventoryStyleInactive,
                TextSpan(
                  children: [
                    TextSpan(text: 'gold_total_credit'.tr),
                    TextSpan(
                      text: '${widget.clientData['balance_sheet']['total_credit_cash']}',
                      style: MyTextstyle.goldInventoryStyleActive,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
            border: TableBorder.all(
              color: Colors.grey.shade400,
              borderRadius: BorderRadius.circular(10),
            ),
            columns: [
              // DataColumn(label: Text('table_id'.tr)),
              DataColumn(label: Text('received_date'.tr)),
              DataColumn(label: Text('deliver_date'.tr)),
              DataColumn(label: Text('received_gold'.tr)),
              DataColumn(label: Text('gold_given'.tr)),
              DataColumn(label: Text('net_weight'.tr)),
              DataColumn(label: Text('tehleel'.tr)),
              DataColumn(label: Text('gold_21k'.tr)),
              DataColumn(label: Text('received_rate'.tr)),
              DataColumn(label: Text('receive_amount_SAR'.tr)),
              DataColumn(label: Text('deliver_netWeight'.tr)),
              DataColumn(label: Text('delivery_tehleel'.tr)),
              DataColumn(label: Text('sample_pic'.tr)),
              DataColumn(label: Text('action'.tr)),
            ],
            rows: goldsData.map<DataRow>((record) {
              return DataRow(
                cells: [
                  // DataCell(Text(record['id'].toString() ?? '-')),
                  DataCell(Text(record['recieved_at']?.toString().split('T').first ?? '-')),
                  DataCell(Text(record['returned_at']?.toString().split('T').first ?? '-')),
                  DataCell(Text(record['gold_recieve'].toString() ?? '-')),
                  DataCell(Text(record['gold_given']?.toString() ?? '-')),
                  DataCell(Text(record['net_weight']?.toString() ?? '-')),
                  DataCell(Text(record['tahleel']?.toString() ?? '-')),
                  DataCell(Text(record['gold_karat']?.toString() ?? '-')),
                  DataCell(Text(record['rate_per_gram'] ?? '-')),
                  DataCell(Text(record['total_value']?.toString() ?? '-')),
                  DataCell(Text(record['returned_net_weight']?.toString() ?? '-')),
                  DataCell(Text(record['returned_tahleel'] ?? '-')),
                  DataCell(GestureDetector(
                      onTap: () {
                        showDialog(context: context, builder: (context) {
                          return Dialog(
                            child: Container(
                              padding: EdgeInsets.all(10),
                              height: 400,
                              width: double.maxFinite,
                              decoration: BoxDecoration(
                                  image: DecorationImage(image: CachedNetworkImageProvider(record['picture_url'] ?? sampleImage), fit: BoxFit.cover),                            borderRadius: BorderRadius.circular(15)
                              ),
                            ),
                          );
                        },);
                      },
                      child: CachedNetworkImage(imageUrl:record['picture_url'] ?? sampleImage, height: 30, width: 50))),
                  DataCell(Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // IconButton(
                      //   onPressed: () {
                      //     Get.to(() => UpdateGoldScreen(clientData: record, id: record['id']));
                      //   },
                      IconButton(
                        onPressed: () async {
                          await Get.to(() => UpdateGoldScreen(clientData: record, id: record['id']));
                          widget.onRefresh();
                        },
                        icon: Icon(Icons.edit, size: 20),
                      ),
                      Container(height: 20, width: 2, color: Colors.grey),
                      IconButton(
                        onPressed: () async {
                          try {
                            EasyLoading.show(status: '');
                            final response = await MyApiServices().deleteGold(record['id']);
                            Get.snackbar(
                              'success'.tr,
                              response['message'],
                              backgroundColor: Colors.green,
                              colorText: Colors.white,
                              snackPosition: SnackPosition.BOTTOM,
                            );
                            EasyLoading.dismiss();
                            await widget.onRefresh();
                          } catch (e) {
                            EasyLoading.dismiss();
                            Get.snackbar(
                              'error'.tr,
                              e.toString(),
                              backgroundColor: Colors.red,
                              colorText: Colors.white,
                              snackPosition: SnackPosition.BOTTOM,
                            );
                          }
                        },
                        icon: Icon(CupertinoIcons.delete, size: 20),
                      ),
                    ],
                  )),
                ],
              );
            }).toList(),
          ),
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            // Text('export_data'.tr, style: MyTextstyle.labelStyle),
            const SizedBox(width: 20),
            Mybutton(
              size: Size(125, 40),
              btntext: 'download'.tr,
              ontap: ()  async{

                // this is opening url
                EasyLoading.show();
                final result =await  MyApiServices().getPdfFile(widget.clientData['balance_sheet']['client_id'].toString());
                EasyLoading.dismiss();
                // print(result['data']['data']['pdf_url']);
                final url = Uri.parse(result['data']['data']['pdf_url']);

                // ur; launcher
                if(await canLaunchUrl(url)){
                  EasyLoading.dismiss();
                  await launchUrl(url);
                }else{
                  throw "Can't Generate pdf file";
                }
              },
            ),
          ],
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}