
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class FavSupplierController extends GetxController {
  late final Map<String, dynamic> data;
   final RxInt id = 2.obs;
  final storage = GetStorage();
  final RxBool isfavourite = false.obs;
  final RxMap<int, Map<String, dynamic>> favClients =
      <int, Map<String, dynamic>>{}.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    data = storage.read('userData') ?? {};
    if (data.isNotEmpty && data['data']?['user']?['id'] != null) {
      id.value = data['data']['user']['id'];
    }
    loadFavclient();

    // Listen to storage changes
    storage.listenKey('favClientMap${id.value.toString()}', (value) {
      loadFavclient();
    });
  }


  void updateUserData() {

  }

  void updateFavorites() {
    final Map<String, dynamic>? favClientMap =
        storage.read<Map>('favClientMap${id.value.toString()}')?.cast<String, dynamic>();
    if (favClientMap != null) {
      favClients.value = Map.fromEntries(
        favClientMap.entries.map(
          (e) => MapEntry(
            int.parse(e.key),
            Map<String, dynamic>.from(e.value as Map),
          ),
        ),
      );
    }
  }
  void removeFavorite(int clientId) {
    if (favClients.containsKey(clientId)) {
      favClients.remove(clientId);
      // Update storage
      final storageMap = Map.fromEntries(
          favClients.entries.map((e) => MapEntry(e.key.toString(), e.value))
      );
      storage.write('favClientMap${id.value.toString()}', storageMap);
    }
  }

  void loadFavclient() {
    final savedclient = storage.read<Map>('favClientMap${id.value.toString()}'); // Remove type parameter
    if (savedclient != null) {
      favClients.value = Map.fromEntries(
        savedclient.entries.map(
          (e) => MapEntry(
            int.parse(e.key),
            Map<String, dynamic>.from(e.value as Map),
          ),
        ),
      );
    }
    update();
  }

  void togglefavclient(int clientid, Map<String, dynamic> cliendata) {
    print(favClients);
    print(cliendata);
    print(clientid == favClients);
    if (cliendata != favClients) {
      if (favClients.containsKey(clientid)) {
        favClients.remove(clientid);
        final storagemap = Map.fromEntries(
          favClients.entries.map((e) => MapEntry(e.key.toString(), e.value)),
        );
        storage.write('favClientMap${id.value.toString()}', storagemap);
        return;
      } else {
        favClients[clientid] = cliendata;
        final storagemap = Map.fromEntries(
          favClients.entries.map((e) => MapEntry(e.key.toString(), e.value)),
        );
        storage.write('favClientMap${id.value.toString()}', storagemap);
        return;
      }
    } else {
      favClients[clientid] = cliendata;
      final storagemap = Map.fromEntries(
        favClients.entries.map((e) => MapEntry(e.key.toString(), e.value)),
      );
      storage.write('favClientMap${id.value.toString()}', storagemap);
      update();
      return;
    }



    //conversion
  }

  bool isfav(int clientid) {
    isfavourite.value = favClients.containsKey(clientid);
    return favClients.containsKey(clientid);
  }

  List<Map<String, dynamic>> getFavoriteClients() {
    return favClients.values.toList();
  }
}
