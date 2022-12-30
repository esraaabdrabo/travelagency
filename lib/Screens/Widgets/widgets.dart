import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:travelagency/Helper/Colors.dart';

abstract class CustomWidgets {
  static Center loading = const Center(
    child: CircularProgressIndicator(
      color: AppColors.pomegranateColor,
    ),
  );
  static cachedImg(String path) {
    return CachedNetworkImage(
      imageUrl: path,
      fit: BoxFit.fill,
      placeholder: (context, url) => const SizedBox(
        width: 50,
        height: 50,
        child: CircularProgressIndicator(),
      ),
      errorWidget: (context, url, error) => const Icon(Icons.error),
    );
  } ////////////////sized box

  static var sizedbox15h = const SizedBox(
    height: 15,
  );
  static var sizedbox15w = const SizedBox(
    width: 15,
  );
  //exit btn
  static exit(BuildContext context) {
    return Align(
      alignment: Alignment.topRight,
      child: //exit btn
          InkWell(
        onTap: () => Navigator.pop(context),
        child: Padding(
          padding: EdgeInsets.all(5),
          child: Icon(
            Icons.cancel,
            size: MediaQuery.of(context).size.width * .02,
          ),
        ),
      ),
    );
  }
}
