import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gold_app/constants/colors.dart';

class Clientcardview extends StatelessWidget {
  const Clientcardview({
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
    required this.isFavourite,
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
  final bool isFavourite;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final cardWidth = size.width * 0.45; // Responsive card width
    final cardHeight = size.height * 0.28; // Responsive card height // Image takes 60% of card height

    return SizedBox(
      width: cardWidth,
      height: cardHeight,
      child: Stack(
        children: [
          GestureDetector(
            onLongPress: delete_ontap,
            child: Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: isFavourite?BorderSide(
                  color: Appcolor.mainColor,
                  width: 4,
                ):BorderSide.none,
              ),
              margin: EdgeInsets.all(size.width * 0.02),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      GestureDetector(
                        onTap: edit_ontap,
                        child: ClipRRect(
                          borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                          child: CachedNetworkImage(
                            height: size.height*.150,
                            width: double.infinity,
                            fit: BoxFit.cover, imageUrl: imageurl.isNotEmpty
                              ? imageurl
                              : "https://cdn-icons-png.flaticon.com/128/3177/3177440.png",
                          ),
                        ),
                      ),
                      Positioned(
                        top: size.width * 0.02,
                        right: size.width * 0.02,
                        child: GestureDetector(
                          onTap: favotTap,
                          child: Container(
                            padding: EdgeInsets.all(size.width * 0.015),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.8),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.favorite,
                              color: isFavourite ? Colors.red : Colors.grey,
                              size: size.width * 0.05,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(size.width * 0.03),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            name,
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                              fontSize: size.width * 0.035,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: size.height*.005,),
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
                    ),
                  ),
                ],
              ),
            ),
          ),




          // #####   delete icon
          // Positioned(
          //   bottom: size.height * 0.02,
          //   right: Get.locale?.languageCode == 'ar' ? null : size.width * 0.04,
          //   left: Get.locale?.languageCode == 'ar' ? size.width * 0.04 : null,
          //   child: GestureDetector(
          //     onTap: delete_ontap,
          //     child: Container(
          //       padding: EdgeInsets.all(size.width * 0.02),
          //       decoration: BoxDecoration(
          //         color: Colors.white.withOpacity(0.8),
          //         shape: BoxShape.circle,
          //         boxShadow: [
          //           BoxShadow(
          //             color: Colors.black26,
          //             blurRadius: 4,
          //             offset: const Offset(2, 2),
          //           ),
          //         ],
          //       ),
          //       child: Icon(
          //         Icons.delete,
          //         color: Colors.red,
          //         size: size.width * 0.045,
          //       ),
          //     ),
          //   ),
          // ),





        ],
      ),
    );
  }
}
