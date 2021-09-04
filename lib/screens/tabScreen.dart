import 'package:flutter/material.dart';

import 'package:sharvaanimatrimony/conts/colors.dart';

import 'package:sharvaanimatrimony/screens/profile/profile.dart';
import 'package:sharvaanimatrimony/settings/settings.dart';

import 'home/homeScreen.dart';
import 'search/search.dart';

class TabsScreen extends StatefulWidget {
  static const routeName = '/tabs';
  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  
  
  final List<Map<String, Object>> _pages = [
    {
      'page': HomeScreen(),
      'title': 'Home',
    },
    {
      'page': SearchScreen(),
      'title': 'Search',
    },
    {
      'page': ProfileScreen(),
      'title': 'Profile',
    },
    {
      'page': SettingsScreen(),
      'title': 'Settings',
    },
  ];
  int _selectedPageIndex = 0;

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: _pages[_selectedPageIndex]['page'],
        bottomNavigationBar: BottomNavigationBar(
          onTap: _selectPage,
          backgroundColor: set2_sliver,
          unselectedItemColor: Colors.white,
          selectedItemColor: set1_meroon,
          currentIndex: _selectedPageIndex,
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(
              backgroundColor: Theme.of(context).accentColor,
              icon: Icon(
                Icons.home,
              ),
              // ignore: deprecated_member_use
              title: Text('Home'),
            ),
            BottomNavigationBarItem(
              backgroundColor: Theme.of(context).accentColor,
              icon: Icon(
                Icons.search,
              ),
              // ignore: deprecated_member_use
              title: Text('search'),
            ),
            BottomNavigationBarItem(
              backgroundColor: Theme.of(context).accentColor,
              icon: Icon(Icons.person),
              // ignore: deprecated_member_use
              title: Text('Profile'),
            ),
             BottomNavigationBarItem(
              backgroundColor: Theme.of(context).accentColor,
              icon: Icon(Icons.settings),
              // ignore: deprecated_member_use
              title: Text('Settings'),
            ),
          ],
        ),
      ),
    );
  }
}
