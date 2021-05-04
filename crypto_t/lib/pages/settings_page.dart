import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:crypto_t/utils/app_styles.dart';
import 'package:crypto_t/utils/widget/my_button.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(
        AppStylesPrimary.safeAreaX,
        AppStylesPrimary.safeAreaYTop,
        AppStylesPrimary.safeAreaX,
        0,
      ),
      child: Column(
        children: [
          Row(
            children: [
              SizedBox(width: 10),
              Text(
                'Theme'.tr(),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
                textAlign: TextAlign.left,
              ),
            ],
          ),
          SizedBox(height: 10),

          Row(
            children: [
              MyButton.create(
                context,
                title: 'Auto'.tr(),
                onTap: () {
                  AdaptiveTheme.of(context).setSystem();
                }
              ),
              SizedBox(width: 15),
              MyButton.create(
                context,
                title: 'Light'.tr(),
                onTap: () {
                  AdaptiveTheme.of(context).setLight();
                }
              ),
              SizedBox(width: 15),
              MyButton.create(
                context,
                title: 'Dark'.tr(),
                onTap: () {
                  AdaptiveTheme.of(context).setDark();
                }
              ),
            ],
          ),
          SizedBox(height: 30),

          Row(
            children: [
              SizedBox(width: 10),
              Text(
                'Language'.tr(),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
                textAlign: TextAlign.left,
              ),
            ],
          ),
          SizedBox(height: 10),
          Row(
            children: [
              MyButton.create(
                context,
                title: 'Auto'.tr(),
                onTap: () {
                  var loc = EasyLocalization.of(context)?.deviceLocale.languageCode;
                  switch (loc) {
                    case 'en':
                      EasyLocalization.of(context)?.setLocale(Locale('en'));
                      break;
                    case 'ru':
                      EasyLocalization.of(context)?.setLocale(Locale('ru'));
                      break;
                    default:
                      EasyLocalization.of(context)?.setLocale(Locale('en'));
                      break;
                  }
                  EasyLocalization.of(context)?.deleteSaveLocale();
                }
              ),
              SizedBox(width: 15),
              MyButton.create(
                context,
                title: 'English'.tr(),
                onTap: () {
                  EasyLocalization.of(context)?.setLocale(Locale('en'));
                }
              ),
              SizedBox(width: 15),
              MyButton.create(
                context,
                title: 'Russian'.tr(),
                onTap: () {
                  EasyLocalization.of(context)?.setLocale(Locale('ru'));
                }
              ),
            ],
          ),
          SizedBox(height: 30),

          Row(
            children: [
              SizedBox(width: 10),
              Text(
                'Other'.tr(),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
                textAlign: TextAlign.left,
              ),
            ],
          ),
          SizedBox(height: 10),
          Row(children: [
            MyButton.create(
                context,
                title: 'Sign Out'.tr(),
                onTap: () {
                  
                }
              ),
            ],
          ),
        ],
      ),
    );
  }
}