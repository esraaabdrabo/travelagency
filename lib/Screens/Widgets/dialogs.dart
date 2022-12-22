import 'package:flutter/material.dart';

import '../../Helper/Colors.dart';
import '../../Helper/text_style.dart';

abstract class Dialogs {
  static notFound(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Text(
          "Not found",
          textAlign: TextAlign.center,
          style: black20LatoTS,
        ),
        actions: [
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.pomegranateColor.withOpacity(0.8),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("ok"))
        ],
      ),
    );
  }
}
