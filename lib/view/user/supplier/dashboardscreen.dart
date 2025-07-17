import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:gold_app/constants/colors.dart';
import 'package:gold_app/constants/imageUrl.dart';
import 'package:gold_app/constants/textstyle.dart';
import 'package:gold_app/controller/favclientcontroller.dart';
import 'package:gold_app/controller/getclientcontroller.dart';
import 'package:gold_app/services/api_services.dart';
import 'package:gold_app/view/user/supplier/addclientscreen.dart';
import 'package:gold_app/widget/snackbar.dart';
import '../../../controller/user_check_controller.dart';
import 'updateclientscreen.dart';
import 'package:gold_app/widget/cauroselwidget.dart';
import 'package:gold_app/widget/clientcardview.dart';
import 'package:gold_app/widget/mybutton.dart';
import 'package:gold_app/widget/mytextfield.dart';

class Dashboardscreen extends StatefulWidget {
  Dashboardscreen({super.key});

  @override
  State<Dashboardscreen> createState() => _DashboardscreenState();
}

class _DashboardscreenState extends State<Dashboardscreen> {
  bool ishave = true;

  final MyApiServices services = MyApiServices();

  GetStorage storage = GetStorage();
  final favClientController = Get.put(FavSupplierController());
  final getClientController = Get.put(GetClientController());
  @override
  void initState() {
    super.initState();
    onRefresh();
    storage.listen(() {
      if (mounted) {
        favClientController.loadFavclient();
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    // favClientController.dispose();
  }

  final caurouselController = FlutterCarouselController();
  int currentCarouselIndex = 0;
  late List<dynamic> currentdata = [];

  void handleSearch(String value) {
    if (value.isEmpty) {
      getClientController.filterList.assignAll(currentdata);
      return;
    }

    final filtered =
        currentdata.where((client) {
          final name =
              '${client['first_name']} ${client['last_name']}'.toLowerCase();
          final business = (client['busniess_name'] ?? '').toLowerCase();
          final email = (client['email'] ?? '').toLowerCase();
          final contact = (client['contact_number'] ?? '').toLowerCase();
          final searchLower = value.toLowerCase();

          return name.contains(searchLower) ||
              business.contains(searchLower) ||
              email.contains(searchLower) ||
              contact.contains(searchLower);
        }).toList();

    getClientController.filterList.assignAll(filtered);
  }

  Future<void> onRefresh() async {
    try {
      final result = await services.getClients();
      if (result['success'] && result['data'] != null) {
        final clients = result['data']['clients']['data'] as List;
        currentdata = clients;
        getClientController.clientData.assignAll(clients);
        getClientController.filterList.assignAll(clients);
        getClientController.searchcontroller.clear();
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
                  favClientController.removeFavorite(clientId);
                  // Remove from current list
                  getClientController.filterList.removeWhere(
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
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('dashboard'.tr),
        actions: [
          Mybutton(
            textclr: Appcolor.mainColor,
            btnclr: Colors.white,
            size: Size(125, 40),
            btntext: 'add_client_'.tr,
            ontap: ()async {
              await Get.to(() => AddClientScreen());
              await onRefresh();
            },
          ),
          const SizedBox(width: 10),
        ],
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
                  controller: getClientController.searchcontroller,
                  keytype: TextInputType.text,
                ),
                const SizedBox(height: 10),

                Obx(() {
                  final favoriteClients =
                      favClientController.favClients.values.toList();
                  return favoriteClients.isNotEmpty
                      ? FlutterCarousel.builder(
                        itemCount: favoriteClients.length,
                        itemBuilder: (context, index, realIndex) {
                          final client = favoriteClients[index];
                          return CarosoulWidget(
                            borderSide:
                                currentCarouselIndex == index
                                    ? BorderSide(
                                      color: Appcolor.mainColor,
                                      width: 4,
                                    )
                                    : BorderSide.none,
                            favotTap:
                                () => favClientController.togglefavclient(
                                  client['id'],
                                  client,
                                ),
                            clientId: client['id'],
                            imageurl: client['profile_url'] ?? personUrl,
                            name:
                                '${client['first_name']} ${client['last_name']}',
                            bussinesname:
                                client['busniess_name'] ?? 'business name',
                            address: client['address'] ?? 'address',
                            contact:
                                client['contact_number'] ?? 'contact number',
                            email: client['email'] ?? 'email',
                            delete_ontap: () => on_delte(client['id']),
                            details_ontap: () {},
                            edit_ontap:
                                () => Get.to(
                                  () => UpdateClientScreen(clientData: client),
                                ),
                          );
                        },
                        options: FlutterCarouselOptions(
                          height: 250,
                          viewportFraction: 0.8,
                          initialPage: 0,
                          enableInfiniteScroll: true,
                          autoPlay: true,
                          onPageChanged: (index, reason) {
                            setState(() {
                              currentCarouselIndex = index;
                            });
                          },
                          // ... rest of your carousel options
                        ),
                      )
                      : SizedBox();
                }),

                // ?? Search bar
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 15),
                    StreamBuilder<dynamic>(
                      stream: services.getClients().asStream().map((result) {
                        if (result['status_code'] == 422) {
                          return 'SESSION_EXPIRED';
                        }

                        if (result['success'] && result['data'] != null) {
                          final clients =
                              result['data']['clients']['data'] as List;
                          currentdata = clients;
                          getClientController.clientData.assignAll(clients);
                          if (getClientController
                              .searchcontroller
                              .text
                              .isEmpty) {
                            getClientController.filterList.assignAll(clients);
                          } else {
                            handleSearch(
                              getClientController.searchcontroller.text,
                            );
                          }
                          return clients;
                        }
                        return [];
                      }),
                      builder: (context, snapshot) {
                        // if (snapshot.connectionState == ConnectionState.waiting) {
                        //   return Center(
                        //     child: Container(
                        //       height: Get.height * 0.5,
                        //       child: Column(
                        //         mainAxisAlignment: MainAxisAlignment.center,
                        //         children: [
                        //           CircularProgressIndicator(
                        //             color: Appcolor.mainColor,
                        //           ),
                        //           SizedBox(height: 10),
                        //           Text(
                        //             'loading'.tr,
                        //             style: MyTextstyle.subTextStyle,
                        //           ),
                        //         ],
                        //       ),
                        //     ),
                        //   );
                        // }

                        if (snapshot.hasError || snapshot.data == 'SESSION_EXPIRED') {
                          return Center(
                            child: Container(
                              height: Get.height * 0.5,
                              alignment: Alignment.center,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'session_expire'.tr,
                                    style: TextStyle(
                                      color: Colors.red,
                                      fontSize: 16,
                                    ),
                                  ),
                                  const SizedBox(height: 20,),
                                  Mybutton(btntext: 'try_again'.tr, ontap: (){
                                    UserCheckController().logout();
                                  })
                                ],
                              ),
                            ),
                          );
                        }
                        if (snapshot.hasData && snapshot.data.isEmpty) {
                          return Center(
                            child: Container(
                              alignment: Alignment.center,
                              height: Get.height * 0.5,child: NoData(),),
                          );
                        }

                        return Obx(() {
                          if (getClientController.filterList.isEmpty) {
                            return Center(
                              child: CircularProgressIndicator(),
                              // Column(
                              //   mainAxisAlignment:
                              //       MainAxisAlignment.center,
                              //   children: [
                              //     Icon(
                              //       CupertinoIcons.search,
                              //       size: 70,
                              //       color: Appcolor.iconcolor,
                              //     ),
                              //     const SizedBox(height: 10),
                              //     Text(
                              //       'No data found',
                              //       style: MyTextstyle.mainTextStyle,
                              //       textAlign: TextAlign.center,
                              //     ),
                              //   ],
                              // ),
                            );
                          }
                          return GridView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  childAspectRatio: 5 / 6.5,
                                  mainAxisSpacing: size.height * 0.02,
                                  crossAxisSpacing: size.width * 0.02,
                                ),
                            itemCount: getClientController.filterList.length,
                            itemBuilder: (context, index) {
                              final client = getClientController.filterList[index];
                              // print(client['first_name']);
                              final favlist = storage.read<Map>(
                                'favClientMap${favClientController.id.value}',
                              );
                              // print('favClientMap content: ${favlist}');

                              // print(favlist);
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 2,
                                ),
                                child: Obx(
                                  () => Clientcardview(
                                    isFavourite: favClientController.isfav(
                                      client['id'],
                                    ),
                                    favotTap:
                                        () =>
                                            favClientController.togglefavclient(
                                              client['id'],
                                              client,
                                            ),
                                    clientId: client['id'],
                                    imageurl:
                                        client['profile_url'] ?? personUrl,
                                    name:
                                        '${client['first_name']} ${client['last_name']??''}',
                                    bussinesname:
                                        client['busniess_name'] ??
                                        'business name',
                                    address: client['address'] ?? 'address',
                                    contact:
                                        client['contact_number'] ??
                                        'contact number',
                                    email: client['email'] ?? 'email',
                                    delete_ontap: () {
                                      on_delte(client['id']);
                                    },
                                    details_ontap: () {},
                                    edit_ontap:()async{
                                      await Get.to(
                                            () => UpdateClientScreen(
                                          clientData: client,
                                        ),
                                      );
                                      await onRefresh();
                                        }
                                  ),
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
      child: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(CupertinoIcons.person_2, size: 70, color: Appcolor.iconcolor),
            const SizedBox(height: 10),
            Text(
              'no_client'.tr,
              style: MyTextstyle.mainTextStyle,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            Text(
              'add_client'.tr,
              style: MyTextstyle.subHeadingStyle,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Mybutton(
              btntext: 'add_client_btn'.tr,
              ontap: () {
                Get.to(() => AddClientScreen());
              },
            ),
          ],
        ),
      ),
    );
  }
}
