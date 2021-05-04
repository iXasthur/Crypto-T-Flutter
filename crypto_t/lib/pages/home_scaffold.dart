import 'package:crypto_t/pages/app_routes.dart';
import 'package:crypto_t/pages/cryptos_page.dart';
import 'package:crypto_t/pages/map_page.dart';
import 'package:crypto_t/pages/settings_page.dart';
import 'package:crypto_t/utils/widget/my_app_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:easy_localization/easy_localization.dart';

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
    CryptosPage(),
    MapPage(),
    SettingsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar.create(
        context,
        title: titles[_selectedIndex].tr(),
        actions: _selectedIndex == 0
        ? [
        IconButton(
          onPressed: () async {
            // Go to creator
            await Navigator.pushNamed(context, AppRoutes.creator, arguments: null);
            setState(() {
              _widgetOptions[0] = CryptosPage(); // Force to refresh
            });
          },
          icon: Icon(CupertinoIcons.plus),
          splashColor: Colors.transparent,
        ),
        ]
        : [],
      ),
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
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
                    text: tabs[0].tr(),
                  ),
                  GButton(
                    icon: Icons.map,
                    text: tabs[1].tr(),
                  ),
                  GButton(
                    icon: Icons.settings,
                    backgroundColor: Colors.green,
                    text: tabs[2].tr(),
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
