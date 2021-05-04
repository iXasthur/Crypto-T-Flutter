import 'package:flutter/material.dart';

class MyButton {
  static Widget create(BuildContext context,
      {required String title,
      TextAlign textAlign = TextAlign.center,
      Function()? onTap}) {

    return Expanded(
      child: Container(
        constraints: BoxConstraints(minHeight: 50),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: Theme.of(context).scaffoldBackgroundColor,
            elevation: 2.2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18.0),
            ),
          ),
          onPressed: onTap,
          child: Text(
            title,
            style: TextStyle(
              fontSize: 17,
              color: Theme.of(context).textTheme.bodyText1!.color,
              fontWeight: FontWeight.w500,
            ),
            textAlign: textAlign,
          ),
        ),
      ),
    );
  }
}
