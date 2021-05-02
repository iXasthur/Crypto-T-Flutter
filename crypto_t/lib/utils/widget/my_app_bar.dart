import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'my_icon_button.dart';

class MyAppBar {
  static PreferredSizeWidget create(BuildContext context,
      {required String title, Widget? leading, List<Widget>? actions}) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(50),
      child: AppBar(
        title: Text(
          title,
          style: TextStyle(
            color: Theme.of(context).textTheme.bodyText1!.color,
            fontFamily: GoogleFonts.quicksand().fontFamily,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(
          color: Theme.of(context).textTheme.bodyText1!.color,
        ),
        leading: leading != null ? leading : Container(),
        actions: actions,
        // backgroundColor: Colors.transparent,
      ),
    );
  }

  static PreferredSizeWidget createWithAutoBack(BuildContext context,
      {required String title, List<Widget>? actions, required Function() onBack}) {
    return create(context,
        title: title,
        leading: Navigator.canPop(context)
            ? MyIconButton.createBackButton(context, onBack: onBack)
            : null,
        actions: actions);
  }
}
