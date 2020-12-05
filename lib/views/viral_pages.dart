import 'package:flutter/material.dart';
import 'package:viral/views/campaigns/campaign.dart';
import 'package:viral/views/home.dart';
import 'package:viral/views/locations/location.dart';
import 'package:viral/views/media.dart';
import 'package:viral/views/user/profile.dart';

class ViralPages extends StatefulWidget {
  @override
  _ViralPagesState createState() => _ViralPagesState();
}

class _ViralPagesState extends State<ViralPages> {
  int _currentIndex = 0;
  final List<Widget> _children = [
    Home(),
    Campaign(),
    //Media(),
    Profile(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        onTap: onTabTapped,
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text(''),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications_active),
            title: Text(''),
          ),
          // BottomNavigationBarItem(
          //   icon: Icon(Icons.perm_media),
          //   title: Text(''),
          // ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            title: Text(''),
          ),
        ],
      ),
    );
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}
