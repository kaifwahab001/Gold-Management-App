import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../services/api_services.dart';

class GetSupplierController extends GetxController{

  RxList<dynamic> clientData = [].obs;
  RxList<dynamic> filterList = [].obs;
  final RxBool isLoading = false.obs;
  final MyApiServices services = MyApiServices();
  final TextEditingController searchcontroller = TextEditingController();

  @override
  Future<void> onInit() async {
    // TODO: implement onInit
    super.onInit();
    getdata();
    filterList = clientData;
  }

  Future<void> getdata() async{
    isLoading.value = true;
    try {
      final result = await services.getSupplier();
      if (result['success'] && result['data'] != null) {
        clientData = result;
      }
    } catch (e) {
      print('Error fetching clients: $e');
    } finally {
      isLoading.value = false;
    }
  }

  void onsearch(String query) {
    if (query.isEmpty) {
      filterList.assignAll(clientData);
      return;
    }

    Future<void> refreshData() async {
      clientData.value= await services.getClients();
      filterList = await services.getClients();
    }

  }}