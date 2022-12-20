import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

abstract class CustomWidgets {
  static cachedImg(String path) {
    return CachedNetworkImage(
      imageUrl: path,
      fit: BoxFit.fill,
      placeholder: (context, url) => const CircularProgressIndicator(),
      errorWidget: (context, url, error) => const Icon(Icons.error),
    );
  } ////////////////sized box

  static var sizedbox15h = const SizedBox(
    height: 15,
  );
  static var sizedbox15w = const SizedBox(
    width: 15,
  );
}
