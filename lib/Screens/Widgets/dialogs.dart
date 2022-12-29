import 'package:flutter/material.dart';

import '../../Helper/Colors.dart';
import '../../Helper/text_style.dart';

abstract class Dialogs {
  static onlyTextContent(BuildContext context, String content) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Text(
          content,
          textAlign: TextAlign.center,
          style: black20LatoTS(context),
        ),
        contentPadding: EdgeInsets.symmetric(
            vertical: height * .025, horizontal: width * .05),
        actions: [
          MaterialButton(
              color: AppColors.pomegranateColor,
              padding: EdgeInsets.symmetric(
                  vertical: height * .01, horizontal: width * .03),
              shape: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(width * .009)),
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                "ok",
                style: TextStyle(fontSize: height * .025, color: Colors.white),
              ))
        ],
      ),
    );
  }
}
