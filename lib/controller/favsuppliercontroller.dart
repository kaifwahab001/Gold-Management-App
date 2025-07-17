import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class FavsClientController extends GetxController {
  final storage = GetStorage();
  final RxBool isfavourite = false.obs;
  final RxMap<int, Map<String, dynamic>> favSuppliers =
      <int, Map<String, dynamic>>{}.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    loadFavclient();
  }

  void updateFavorites() {
    final Map<String, dynamic>? favSupplierMap =
        storage.read<Map>('favSupplierMap')?.cast<String, dynamic>();
    if (favSupplierMap != null) {
      favSuppliers.value = Map.fromEntries(
        favSupplierMap.entries.map(
          (e) => MapEntry(
            int.parse(e.key),
            Map<String, dynamic>.from(e.value as Map),
          ),
        ),
      );
    }
  }

  void removeFavorite(int clientId) {
    if (favSuppliers.containsKey(clientId)) {
      favSuppliers.remove(clientId);
      // Update storage
      final storageMap = Map.fromEntries(
        favSuppliers.entries.map((e) => MapEntry(e.key.toString(), e.value)),
      );
      storage.write('favSupplierMap', storageMap);
    }
  }

  void loadFavclient() {
    final savedclient = storage.read<Map>(
      'favSupplierMap',
    ); // Remove type parameter
    if (savedclient != null) {
      favSuppliers.value = Map.fromEntries(
        savedclient.entries.map(
          (e) => MapEntry(
            int.parse(e.key),
            Map<String, dynamic>.from(e.value as Map),
          ),
        ),
      );
    }
  }

  void togglefavclient(int clientid, Map<String, dynamic> cliendata) {
    print(favSuppliers);
    print(cliendata);
    print(clientid == favSuppliers);
    if (cliendata != favSuppliers) {
      if (favSuppliers.containsKey(clientid)) {
        favSuppliers.remove(clientid);
        final storagemap = Map.fromEntries(
          favSuppliers.entries.map((e) => MapEntry(e.key.toString(), e.value)),
        );
        storage.write('favSupplierMap', storagemap);
        return;
      } else {
        favSuppliers[clientid] = cliendata;
        final storagemap = Map.fromEntries(
          favSuppliers.entries.map((e) => MapEntry(e.key.toString(), e.value)),
        );
        storage.write('favSupplierMap', storagemap);
        return;
      }
    } else {
      favSuppliers[clientid] = cliendata;
      final storagemap = Map.fromEntries(
        favSuppliers.entries.map((e) => MapEntry(e.key.toString(), e.value)),
      );
      storage.write('favSupplierMap', storagemap);
      return;
    }

    //conversion
  }

  bool isfav(int clientid) {
    isfavourite.value = favSuppliers.containsKey(clientid);
    return favSuppliers.containsKey(clientid);
  }

  List<Map<String, dynamic>> getFavoriteClients() {
    return favSuppliers.values.toList();
  }
}
