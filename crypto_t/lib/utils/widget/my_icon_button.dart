import 'package:flutter/material.dart';

class MyIconButton {
  static Widget createBackButton(BuildContext context, {required Function() onBack}) {
    return IconButton(
      icon: Icon(
        Icons.arrow_back_ios_rounded,
      ),
      onPressed: () {
        onBack.call();
        Navigator.pop(context);
      },
    );
  }
}
