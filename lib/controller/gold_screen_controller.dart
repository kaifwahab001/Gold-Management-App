import 'package:get/get.dart';
import 'package:gold_app/services/api_services.dart';

class GoldScreenController extends GetxController {
  RxList<dynamic> clientList = RxList<dynamic>();
  final RxBool isLoading = false.obs;
  final services = MyApiServices();
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getClient();
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
