import 'package:eyes_of_rovers/model/mockData.dart';
import 'package:flutter/material.dart';
import 'package:eyes_of_rovers/constants/Constants.dart' as CONSANTS;
import 'nasa_image_widget.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  int _currentIndex = 0;

   final List<Widget> _children = [
    NasaImageWidget(Key(CONSANTS.bottom_nav_bar_item_curiosity),MockData.getMockCuriosityImages()),
    NasaImageWidget(Key(CONSANTS.bottom_nav_bar_item_opportunity),MockData.getMockOpportunityImages()),
    NasaImageWidget(Key(CONSANTS.bottom_nav_bar_item_spirit),MockData.getMockSpritImages())
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(CONSANTS.app_name),
      ),
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped,
        currentIndex: _currentIndex,
        // this will be set when a new tab is tapped
        items: [
          BottomNavigationBarItem(
            icon: new Icon(Icons.terrain),
            title: new Text(CONSANTS.bottom_nav_bar_item_curiosity),
          ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.android),
            title: new Text(CONSANTS.bottom_nav_bar_item_opportunity),
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.airplanemode_active),
              title: Text(CONSANTS.bottom_nav_bar_item_spirit))
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
