import 'package:crypto_t/utils/app_styles.dart';
import 'package:crypto_t/utils/widget/my_button.dart';
import 'package:flutter/material.dart';

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
                'Theme',
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
                title: 'Auto',
                onTap: () {
                  
                }
              ),
              SizedBox(width: 15),
              MyButton.create(
                context,
                title: 'Light',
                onTap: () {
                  
                }
              ),
              SizedBox(width: 15),
              MyButton.create(
                context,
                title: 'Dark',
                onTap: () {
                  
                }
              ),
            ],
          ),
          SizedBox(height: 30),

          Row(
            children: [
              SizedBox(width: 10),
              Text(
                'Language',
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
                title: 'Auto',
                onTap: () {
                  
                }
              ),
              SizedBox(width: 15),
              MyButton.create(
                context,
                title: 'English',
                onTap: () {
                  
                }
              ),
              SizedBox(width: 15),
              MyButton.create(
                context,
                title: 'Russian',
                onTap: () {
                  
                }
              ),
            ],
          ),
          SizedBox(height: 30),

          Row(
            children: [
              SizedBox(width: 10),
              Text(
                'Other',
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
                title: 'Sign Out',
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