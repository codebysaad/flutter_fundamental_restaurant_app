import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluuter_interm_restaurant_app/screens/restaurant_tab.dart';
import 'package:fluuter_interm_restaurant_app/screens/favourite_tab.dart';
import 'package:fluuter_interm_restaurant_app/components/platform_widget.dart';
import 'package:fluuter_interm_restaurant_app/screens/settings_page.dart';
import 'package:fluuter_interm_restaurant_app/utils/notification_helper.dart';
import 'details_page.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/home_page';
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  late TabController _controller;
  final NotificationHelper _notificationHelper = NotificationHelper();

  int _bottomNavIndex = 0;
  static const String _home = 'Home';
  static const String _settings = 'Settings';
  static const String _favourite = 'Favourite';

  final List<Widget> _listWidget = [
    const RestaurantListTab(),
    const FavouriteTab(),
    const SettingsPage(),
  ];

  final List<BottomNavigationBarItem> _bottomNavBarItems = [
    BottomNavigationBarItem(
      icon: Icon(Platform.isIOS ? CupertinoIcons.home : Icons.home),
      label: _home,
    ),
    BottomNavigationBarItem(
      icon: Icon(Platform.isIOS ? CupertinoIcons.star_fill : Icons.star),
      label: _favourite,
    ),
    BottomNavigationBarItem(
      icon: Icon(Platform.isIOS ? CupertinoIcons.settings : Icons.settings),
      label: _settings,
    ),
  ];

  Future<dynamic> exitDialog() {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Are you sure?'),
        content: const Text('Do you want exit Restaurant App :('),
        actions: [
          TextButton(
            child: const Text("CANCEL"),
            onPressed: () {
              Navigator.of(context).pop(false);
            },
          ),
          TextButton(
            child: const Text("YES"),
            onPressed: () {
              SystemNavigator.pop();
            },
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    _controller = TabController(
      length: 3,
      vsync: this,
      initialIndex: 0,
    );
    super.initState();
    _notificationHelper
        .configureSelectNotificationSubject(RestaurantDetailPage.routeName);
  }

  @override
  void dispose() {
    selectNotificationSubject.close();
    _controller.dispose();
    super.dispose();
  }

  void _onBottomNavTapped(int index) {
    setState(() {
      _bottomNavIndex = index;
    });
  }

  Widget _buildAndroid(BuildContext context) {
    return Scaffold(
      body: _listWidget[_bottomNavIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _bottomNavIndex,
        items: _bottomNavBarItems,
        onTap: _onBottomNavTapped,
      ),
    );
  }

  Widget _buildIos(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(items: _bottomNavBarItems),
      tabBuilder: (context, index) {
        return _listWidget[index];
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        exitDialog();
        return Future.value(false);
      },
      child: PlatformWidget(
        androidBuilder: _buildAndroid,
        iosBuilder: _buildIos,
      ),
    );
  }
}