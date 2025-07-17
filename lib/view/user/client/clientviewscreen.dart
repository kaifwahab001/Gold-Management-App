import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:gold_app/constants/colors.dart';
import 'package:gold_app/constants/imageUrl.dart';
import 'package:gold_app/constants/textstyle.dart';
import 'package:gold_app/controller/favsuppliercontroller.dart';
import 'package:gold_app/controller/getsuppliercontroller.dart';
import 'package:gold_app/services/api_services.dart';
import 'package:gold_app/view/user/supplier/updateclientscreen.dart';
import 'package:gold_app/widget/clientcardview.dart';
import 'package:gold_app/widget/clientcaroselwidget.dart';
import 'package:gold_app/widget/mytextfield.dart';
import 'package:gold_app/widget/snackbar.dart';

class Clientviewscreen extends StatefulWidget {
  Clientviewscreen({super.key});

  @override
  State<Clientviewscreen> createState() => _ClientviewscreenState();
}

class _ClientviewscreenState extends State<Clientviewscreen> {
  bool ishave = true;

  final MyApiServices services = MyApiServices();

  GetStorage storage = GetStorage();
  final favSupplierController = Get.put(FavsClientController());
  final getSupplierController = Get.put(GetSupplierController());
  @override
  void initState() {
    super.initState();
    storage.listen(() {
      if (mounted) {
        favSupplierController.updateFavorites();
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  final caurouselController = FlutterCarouselController();
  int currentCarouselIndex = 0;
  late List<dynamic> currentdata = [];

  void handleSearch(String value) {
    if (value.isEmpty) {
      getSupplierController.filterList.assignAll(currentdata);
      return;
    }

    final filtered =
        currentdata.where((supplier) {
          final name =
              '${supplier['first_name']} ${supplier['last_name'] ?? ''}'
                  .toLowerCase();
          final company = (supplier['company_name'] ?? '').toLowerCase();
          final email = (supplier['email'] ?? '').toLowerCase();
          final contact = (supplier['contact_number'] ?? '').toLowerCase();
          final searchLower = value.toLowerCase();

          return name.contains(searchLower) ||
              company.contains(searchLower) ||
              email.contains(searchLower) ||
              contact.contains(searchLower);
        }).toList();

    getSupplierController.filterList.assignAll(filtered);
  }

  Future<void> onRefresh() async {
    try {
      final result = await services.getSupplier();
      if (result['success'] && result['data'] != null) {
        final clients = result['data']['clients']['data'] as List;
        currentdata = clients;
        getSupplierController.clientData.assignAll(clients);
        getSupplierController.filterList.assignAll(clients);
        getSupplierController.searchcontroller.clear();
      }
    } catch (e) {
      print('Error refreshing data: $e');
    }
  }

  void on_delte(int clientId) {
    Get.dialog(
      AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        title: Text('delete_client'.tr, style: MyTextstyle.mainHeadingStyle),
        content: Text(
          'delete_client_confirm'.tr,
          style: MyTextstyle.subTextStyle,
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text('cancel'.tr, style: TextStyle(color: Colors.grey)),
          ),
          TextButton(
            onPressed: () async {
              Get.back();
              try {
                EasyLoading.show(status: 'Please wait...');
                final result = await services.deleteClient(clientId);
                if (result['success'] == true) {
                  // Remove from favorites if exists
                  favSupplierController.removeFavorite(clientId);
                  // Remove from current list
                  getSupplierController.filterList.removeWhere(
                    (item) => item['id'] == clientId,
                  );
                  MySnackBar.showSuccess(
                    'success'.tr,
                    'client_deleted'.tr,
                  );
                }
                EasyLoading.dismiss();
              } catch (e) {
                EasyLoading.dismiss();
                MySnackBar.showError(
                  'error'.tr,
                  'delete_failed'.tr,
                );
              }
            },
            child: Text('delete'.tr, style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
      barrierDismissible: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    // print("back");
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('dashboard'.tr),
        // actions: [
        //   Mybutton(
        //     textclr: Appcolor.mainColor,
        //     btnclr: Colors.white,
        //     size: Size(150, 40),
        //     btntext: 'add_client_'.tr,
        //     ontap: () {
        //       Get.to(() => AddClientScreen());
        //     },
        //   ),
        //   const SizedBox(width: 10),
        // ],
      ),
      body: RefreshIndicator(
        onRefresh: onRefresh,
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            child: Column(
              children: [
                //?? search bar
                const SizedBox(height: 10),
                Mytextfield(
                  icon: Icon(Icons.search),
                  labelisVisiible: false,
                  onchange: handleSearch,
                  hinttext: 'search'.tr,
                  label: 'search_label'.tr,
                  ispassword: false,
                  controller: getSupplierController.searchcontroller,
                  keytype: TextInputType.text,
                ),
                const SizedBox(height: 10),

                /// ?? carousel slider
                GetX<FavsClientController>(
                  builder: (controller) {
                    final favoriteClients = controller.getFavoriteClients();
                    return favoriteClients.isNotEmpty
                        ? FlutterCarousel(
                          items:
                              favoriteClients.map((client) {

                                return ClientCarosoulWidget(
                                  // clientData: updatedClient, // Pass the full client data
                                  borderSide:
                                      currentCarouselIndex ==
                                              favoriteClients.indexOf(client)
                                          ? BorderSide(
                                            color: Appcolor.mainColor,
                                            width: 4,
                                          )
                                          : BorderSide.none,
                                  favotTap:
                                      () =>
                                          favSupplierController.togglefavclient(
                                            client['id'],
                                            client,
                                          ),
                                  clientId: client['id'],
                                  imageurl: client['profile_url'] ?? personUrl,
                                  name:
                                      '${client['first_name']} ${client['last_name'] ?? ''}',
                                  bussinesname:
                                      client['company_name'] ?? 'Business Name',
                                  address: client['address'] ?? 'Address',
                                  contact:
                                      client['contact_number'] ?? 'Contact',
                                  email: client['email'] ?? 'Email',
                                  delete_ontap: () => on_delte(client['id']),
                                  details_ontap: () {},
                                  edit_ontap:
                                      () => Get.to(
                                        () => UpdateClientScreen(
                                          clientData: client,
                                        ),
                                      ),
                                );
                              }).toList(),
                          options: FlutterCarouselOptions(
                            controller: caurouselController,
                            onPageChanged: (index, reason) {
                              setState(() {
                                currentCarouselIndex = index;
                              });
                            },
                            height: 250,
                            viewportFraction: 0.8,
                            initialPage: 0,
                            enableInfiniteScroll: true,
                            reverse: false,
                            autoPlay: true,
                            slideIndicator: CircularSlideIndicator(
                              slideIndicatorOptions: SlideIndicatorOptions(
                                currentIndicatorColor: Appcolor.mainColor,
                              ),
                            ),
                            autoPlayInterval: const Duration(seconds: 3),
                            autoPlayAnimationDuration: const Duration(
                              milliseconds: 800,
                            ),
                            autoPlayCurve: Curves.fastOutSlowIn,
                            enlargeCenterPage: true,
                            scrollDirection: Axis.horizontal,
                          ),
                        )
                        : SizedBox();
                  },
                ),

                // ?? Search bar
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 15),
                    StreamBuilder<dynamic>(
                      stream: services.getSupplier().asStream().map((result) {
                        if (result['success'] == true &&
                            result['data'] != null) {
                          final clients =
                              result['data']['suppliers']['data'] as List;
                          currentdata = clients;
                          getSupplierController.clientData.assignAll(clients);
                          if (getSupplierController
                              .searchcontroller
                              .text
                              .isEmpty) {
                            getSupplierController.filterList.assignAll(clients);
                          } else {
                            handleSearch(
                              getSupplierController.searchcontroller.text,
                            );
                          }
                          return clients;
                        }
                        return [];
                      }),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }

                        if (snapshot.hasError || !snapshot.hasData) {
                          return NoData();
                        }

                        if (snapshot.data.isEmpty) {
                          return NoData();
                        }

                        return Obx(() {
                          final displayList = getSupplierController.filterList;
                          return GridView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  childAspectRatio: 5 / 6.5,
                                  mainAxisSpacing: 10,
                                  crossAxisSpacing: 10,
                                ),
                            itemCount: displayList.length,
                            itemBuilder: (context, index) {
                              final supplier = displayList[index];
                              // Convert ID to int safely
                              final supplierId =
                                  int.tryParse(supplier['id'].toString()) ?? 0;

                              return Obx(
                                () => Clientcardview(
                                  isFavourite: favSupplierController.isfav(
                                    supplierId,
                                  ),
                                  favotTap:
                                      () =>
                                          favSupplierController.togglefavclient(
                                            supplierId,
                                            supplier,
                                          ),
                                  clientId: supplierId,
                                  imageurl:
                                      supplier['profile_url'] ?? personUrl,
                                  name:
                                      '${supplier['first_name']} ${supplier['last_name'] ?? ''}',
                                  bussinesname:
                                      supplier['company_name'] ??
                                      'Business Name',
                                  address: supplier['address'] ?? 'Address',
                                  contact:
                                      supplier['contact_number'] ?? 'Contact',
                                  email: supplier['email'] ?? 'Email',
                                  delete_ontap: () {},
                                  details_ontap: () {},
                                  edit_ontap: () {},
                                ),
                              );
                            },
                          );
                        });
                      },
                    ),
                    // const SizedBox(height: 120),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget NoData() {
    return Container(
      // height: Get.height-100,
      alignment: Alignment.center,
      child: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        child: Column(
          children: [
            Icon(CupertinoIcons.person_2, size: 70, color: Appcolor.iconcolor),
            const SizedBox(height: 10),
            Text(
              'no_supplier'.tr,
              style: MyTextstyle.mainTextStyle,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            // Mybutton(
            //   btntext: 'add_client_btn'.tr,
            //   ontap: () {
            //     // Get.to(() => AddClientScreen());
            //     AuthServices().logout();
            //   },
            // ),
          ],
        ),
      ),
    );
  }
}
