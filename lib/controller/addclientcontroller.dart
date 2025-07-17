
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gold_app/widget/snackbar.dart';
import 'package:image_picker/image_picker.dart';

class AddClientController extends GetxController {


  // for image picker
  final ImagePicker _picker = ImagePicker();
  final Rxn<XFile> clientimage = Rxn<XFile>();
  final Rxn<XFile> bussinessimage = Rxn<XFile>();
  final RxBool ispicedclient = false.obs;
  final RxBool ispicedbusiness = false.obs;

  // pick image
  Future<XFile?> pickimage() async {
    try {
      final XFile? file = await _picker.pickImage(source: ImageSource.gallery);
      if (file != null) {
        clientimage.value = file;
        ispicedclient.value = true;
      }
      return file;
    } catch (e) {
      MySnackBar.showError(
        'Error',
        'Permission denied',
      );
      return null;
    }
  }

  Future<XFile?> businessPickImage() async {
    try {
      final XFile? file = await _picker.pickImage(source: ImageSource.gallery);
      if (file != null) {
        bussinessimage.value = file;
        ispicedbusiness.value = true;
        update();
      }
      return file;
    } catch (e) {
      MySnackBar.showError(
        'Error',
        'Permission denied',
      );
      return null;
    }
  }

  // save data to firestore
  // Future<void> saveclient(AddClientModel model) async {
  //   try {
  //     Get.dialog(
  //       const Center(child: CircularProgressIndicator()),
  //       barrierDismissible: false,
  //     );
  //
  //     final docRef = await firestore.collection("clients").doc();
  //
  //     // upload image
  //     final String? imageurl = await _uploadImage(image, path);
  //   } catch (e) {
  //     Get.snackbar(
  //       'Error',
  //       'Failed to save',
  //       backgroundColor: Colors.red,
  //       colorText: Colors.white,
  //       snackPosition: SnackPosition.BOTTOM,
  //     );
  //   }
  // }
  //
  // /// for image save
  // Future<String?> _uploadImage(XFile? image, String path) async {
  //   if (image == null) return null;
  //   final ref = storage.ref().child(path);
  //   await ref.putFile(File(image.path));
  //   return await ref.getDownloadURL();
  // }
}
