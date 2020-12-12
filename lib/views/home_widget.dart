import 'package:eyes_of_rovers/model/enum.dart';
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
    NasaImageWidget(Key(CONSANTS.bottom_nav_bar_item_curiosity),
        MockData.getMockCuriosityImages()),
    NasaImageWidget(Key(CONSANTS.bottom_nav_bar_item_opportunity),
        MockData.getMockOpportunityImages()),
    NasaImageWidget(
        Key(CONSANTS.bottom_nav_bar_item_spirit), MockData.getMockSpritImages())
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _generateTabs().length,
      child: Scaffold(
        appBar: AppBar(
          title: Text(CONSANTS.app_name),
          bottom: TabBar(
            isScrollable: true,
            tabs:_generateTabs(),
          ),
        ),
        body: _children[_currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          onTap: _onTabTapped,
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
      ),
    );
  }

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  List<Tab> _generateTabs() {
    if (_currentIndex == 0) {
      return [
        Tab(text: getCameraName(eCamera.FHAZ)),
        Tab(text: getCameraName(eCamera.RHAZ)),
        Tab(text: getCameraName(eCamera.MAST)),
        Tab(text: getCameraName(eCamera.CHEMCAM)),
        Tab(text: getCameraName(eCamera.MAHLI)),
        Tab(text: getCameraName(eCamera.MARDI)),
        Tab(text: getCameraName(eCamera.NAVCAM)),
      ];
    } else if (_currentIndex == 1 ) {
      return [
        Tab(text: getCameraName(eCamera.FHAZ)),
        Tab(text: getCameraName(eCamera.RHAZ)),
        Tab(text: getCameraName(eCamera.NAVCAM)),
        Tab(text: getCameraName(eCamera.PANCAM)),
        Tab(text: getCameraName(eCamera.MINITES)),
      ];
    } else if (_currentIndex == 2) {
      return [
        Tab(text: getCameraName(eCamera.FHAZ)),
        Tab(text: getCameraName(eCamera.RHAZ)),
        Tab(text: getCameraName(eCamera.NAVCAM)),
        Tab(text: getCameraName(eCamera.PANCAM)),
        Tab(text: getCameraName(eCamera.MINITES)),
      ];
    }
  }
}
