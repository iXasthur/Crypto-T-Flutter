import 'package:flutter/material.dart';

class MyTextField {
  static const double fieldMinHeight = 50;
  static const double borderRadius = 17;

  static Widget create(BuildContext context, TextEditingController controller,
      {String hint = '', required Function(String) onChanged}) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
      ),
      width: double.infinity,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Container(
          constraints: BoxConstraints(minHeight: fieldMinHeight),
          child: Center(
            child: TextField(
              decoration: InputDecoration(
                border: InputBorder.none,
                isDense: true,
                hintText: hint,
              ),
              autocorrect: false,
              style: TextStyle(
                fontSize: 18,
                color: Theme.of(context).textTheme.bodyText1!.color,
              ),
              controller: controller,
              // textCapitalization: TextCapitalization.sentences,
              onChanged: (s) {
                onChanged.call(s);
              },
            ),
          ),
        ),
      ),
    );
  }
}
