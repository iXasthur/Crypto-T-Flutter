import 'package:crypto_t/pages/settings_page.dart';
import 'package:crypto_t/utils/widget/my_app_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class HomeScaffold extends StatefulWidget {
  HomeScaffold({Key? key}) : super(key: key);

  @override
  _HomeScaffoldState createState() => _HomeScaffoldState();
}

class _HomeScaffoldState extends State<HomeScaffold> {
  final List<String> titles = ['Cryptos', 'Map', 'Settings'];
  final List<String> tabs = ['Cryptos', 'Map', 'Settings'];

  int _selectedIndex = 0;

  List<Widget> _widgetOptions = <Widget>[
    Container(),
    Container(),
    SettingsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar.create(
        context,
        title: titles[_selectedIndex],
      ),
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 20,
              color: Colors.black.withOpacity(.1),
            ),
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
            child: GNav(
                gap: 7,
                color: Theme
                    .of(context)
                    .textTheme
                    .bodyText1!
                    .color,
                activeColor: Colors.white,
                iconSize: 24,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 7),
                duration: Duration(milliseconds: 200),
                tabBackgroundColor: Colors.deepPurpleAccent,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                tabs: [
                  GButton(
                    icon: CupertinoIcons.cube,
                    backgroundColor: Colors.orange,
                    text: tabs[0],
                  ),
                  GButton(
                    icon: Icons.map,
                    text: tabs[1],
                  ),
                  GButton(
                    icon: Icons.settings,
                    backgroundColor: Colors.green,
                    text: tabs[2],
                  ),
                ],
                selectedIndex: _selectedIndex,
                onTabChange: (index) {
                  setState(() {
                    _selectedIndex = index;
                  });
                }),
          ),
        ),
      ),
    );
  }
}
