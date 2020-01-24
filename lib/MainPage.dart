import 'package:flutter/material.dart';

import 'CategoryPage.dart';
import 'HomePage.dart';
import 'ProfilePage.dart';
import 'VideoPage.dart';

class MainPage extends StatefulWidget {
  
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int currentIndex = 0;



  var activity = [
    HomePage("","All"),
    CategoryPage(),
    VideoPage(),
    ProfilePage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: activity[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (int index) {
          setState(() {
            currentIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        fixedColor: Colors.blue,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Home'),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.category,
            ),
            title: Text(
              'Category',
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.video_library,
            ),
            title: Text(
              'Video',
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person_pin,
            ),
            title: Text(
              "Accounts",
            ),
          ),
        ],
      ),
    );
  }
}
