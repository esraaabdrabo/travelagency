import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

abstract class CustomWidgets {
  static cachedImg(String path) {
    return CachedNetworkImage(
      imageUrl: path,
      placeholder: (context, url) => CircularProgressIndicator(),
      errorWidget: (context, url, error) => Icon(Icons.error),
    );
  } ////////////////sized box

  static var sizedbox15h = const SizedBox(
    height: 15,
  );
}
