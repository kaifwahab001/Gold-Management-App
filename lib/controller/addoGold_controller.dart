

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';

import '../services/api_services.dart';

class ADDGoldController extends GetxController{
  final Rx<TextEditingController> gold21k = TextEditingController().obs;
  final Rx<TextEditingController> totalValue = TextEditingController().obs;

  final  RxInt supplierId = 0.obs;
  final storage = GetStorage();

  final Rxn<XFile> image = Rxn<XFile>();


  RxList<dynamic> clientList = RxList<dynamic>();
  final RxBool isLoading = false.obs;
  final services = MyApiServices();



  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getsupplierId();
    getClient();
  }
  void getsupplierId(){
    final supplierData = storage.read('userData');
    if(supplierData!=null){
      supplierId.value = supplierData['data']['user']['id'];
      print('supplier id ${supplierId.value}');
    }
  }


  void picImage()async{
    final ImagePicker _picker = ImagePicker();
    final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      image.value = XFile(pickedFile.path);
    }
  }
  
  
  
  

  void Gold21kChange(int netWeight, int tahleel ){
    gold21k.value.text = ((netWeight * tahleel) / 875).toString();
  }

  void SARvalueChange(int rate, int netWeight){
    totalValue.value.text = (rate*netWeight/1).toString();
  }

  
  
  
  
  
  void getClient() async {
    clientList.value = await MyApiServices().getClients() as List;
  }

  
  
  Future<List<dynamic>> getdata() async {
    isLoading.value = true;
    try {
      final result = await services.getClients();
      if (result['success'] && result['data'] != null) {
        final clients = result['data']['clients']['data'] as List;
        clientList.assignAll(clients);
        return clients;
      }
      return [];
    } catch (e) {
      print('Error fetching clients: $e');
      return [];
    } finally {
      isLoading.value = false;
    }
  }

  Future<Map<String, dynamic>> getClientGoldDetails(int clientId) async {
    isLoading.value = true;
    try {
      final result = await services.goldClientDetails(clientId);
      return result;
    } catch (e) {
      print('Error fetching client details: $e');
      return {
        'success': false,
        'message': 'Error fetching client details',
        'error': e.toString()
      };
    } finally {
      isLoading.value = false;
    }
  }
}