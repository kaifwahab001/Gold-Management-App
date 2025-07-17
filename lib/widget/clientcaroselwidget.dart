import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_getx_widget.dart';
import 'package:gold_app/controller/favsuppliercontroller.dart';


class ClientCarosoulWidget extends StatelessWidget {
  const ClientCarosoulWidget({
    super.key,
    required this.name,
    required this.bussinesname,
    required this.contact,
    required this.email,
    required this.address,
    required this.details_ontap,
    required this.edit_ontap,
    required this.delete_ontap,
    required this.imageurl,
    required this.favotTap,
    required this.clientId,
    required this.borderSide,
  });

  final String name;
  final String bussinesname;
  final String contact;
  final String email;
  final String address;
  final VoidCallback favotTap;
  final VoidCallback details_ontap;
  final VoidCallback edit_ontap;
  final VoidCallback delete_ontap;
  final String imageurl;
  final int clientId;
  final BorderSide borderSide;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GetX<FavsClientController>(
      init: FavsClientController(),
      builder: (controller) => Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: borderSide,
        ),
        elevation: 2,
        color: Colors.white,
        child: Stack(
          children: [
            Column(
              children: [
                Flexible(
                  flex: 2,
                  child: GestureDetector(
                    onTap: edit_ontap,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: CachedNetworkImage(
                        imageUrl: imageurl,
                        height: 150,
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),
                    ),
                  ),
                ),
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: size.height * .005),
                            SizedBox(
                              width: size.width * 0.60,
                              child: Text(
                                name,
                                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  fontSize: size.width * 0.035,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            SizedBox(height: size.height * .005),
                            Text(
                              contact,
                              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: Colors.grey,
                                fontSize: size.width * 0.03,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Positioned(
              top: 10,
              right: 10,
              child: Container(
                height: 35,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  onPressed: favotTap,
                  icon: Icon(
                    controller.isfav(clientId)
                        ? Icons.favorite
                        : Icons.favorite_border,
                    size: 20,
                    color: controller.isfav(clientId)
                        ? Colors.red
                        : Colors.grey,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}