
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';

import '../services/api_services.dart';

class UpdateGoldController extends GetxController{
  final Rx<TextEditingController> gold21k = TextEditingController().obs;
  final Rx<TextEditingController> SARvalue = TextEditingController().obs;

  final  RxInt supplierId = 0.obs;
  final storage = GetStorage();

  final Rxn<XFile> image = Rxn<XFile>();

  final services = MyApiServices();



  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getsupplierId();
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
    gold21k.value.text = ((netWeight * tahleel) / 875).toStringAsFixed(2);
    update();
  }

  void SARvalueChange(int rate, int netWeight){
    SARvalue.value.text = (rate*netWeight/1).toString();
    update();
  }

}