import 'package:eyes_of_rovers/model/enum.dart';
import 'package:eyes_of_rovers/model/data.dart';
import 'package:eyes_of_rovers/model/model.dart';
import 'package:flutter/material.dart';
import 'package:eyes_of_rovers/constants/Constants.dart' as CONSANTS;
import 'nasa_image_widget.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Data mockData = Data();
  int _currentIndex = 0;
  eCamera _selectedCamera=eCamera.FHAZ;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _generateTabs().length,
      child: Scaffold(
        appBar: AppBar(
          title: Text(CONSANTS.app_name),
          bottom: TabBar(
            isScrollable: true,
            tabs: _generateTabs(),
            onTap: (int index) {
              _onTopTabTapped(index);
            },
          ),
        ),
        body: FutureBuilder(
            future: _getPhotos(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if(snapshot.data!=null){
                if((snapshot.data as List<NasaImage>).isNotEmpty){
                  return NasaImageWidget(Key(_currentIndex.toString()),snapshot.data);
                }else{
                  return Center(
                      child: (Text("Looks like there isn't a photo in this list. Try another filter"))
                  );
                }
              }else{
                return Center(
                    child: (Text("Error retrieving data at this point please try again later"))
                );
              }
            }
        ),
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
    } else if (_currentIndex == 1 || _currentIndex==2) {
      return [
        Tab(text: getCameraName(eCamera.FHAZ)),
        Tab(text: getCameraName(eCamera.RHAZ)),
        Tab(text: getCameraName(eCamera.NAVCAM)),
        Tab(text: getCameraName(eCamera.PANCAM)),
        Tab(text: getCameraName(eCamera.MINITES)),
      ];
    }
  }

  Future<List<NasaImage>> _getPhotos() async {
    if (_currentIndex == 0) {
      return mockData.getListOfPhotos(eRoverName.ROVER_CURIOSITY, 365, _selectedCamera, 1);
    } else if (_currentIndex == 1) {
      return mockData.getListOfPhotos(eRoverName.ROVER_OPPORTUNITY, 365, _selectedCamera, 1);
    } else if (_currentIndex == 2) {
      return mockData.getListOfPhotos(eRoverName.ROVER_SPIRIT, 365, _selectedCamera, 1);
    } else {
      return [];
    }
  }

  void _onTopTabTapped(int index) {
    setState(() {
      if (_currentIndex == 0) {
        if (index == 0) {
          _selectedCamera = eCamera.FHAZ;
        } else if (index == 1) {
          _selectedCamera = eCamera.RHAZ;
        } else if (index == 2) {
          _selectedCamera = eCamera.MAST;
        } else if (index == 3) {
          _selectedCamera = eCamera.CHEMCAM;
        } else if (index == 4) {
          _selectedCamera = eCamera.MAHLI;
        } else if (index == 5) {
          _selectedCamera = eCamera.MARDI;
        } else if (index == 6) {
          _selectedCamera = eCamera.NAVCAM;
        }
      } else if (_currentIndex == 1 || _currentIndex==2) {
        if (index == 0) {
          _selectedCamera = eCamera.FHAZ;
        } else if (index == 1) {
          _selectedCamera = eCamera.RHAZ;
        } else if (index == 2) {
          _selectedCamera = eCamera.NAVCAM;
        } else if (index == 3) {
          _selectedCamera = eCamera.PANCAM;
        } else if (index == 4) {
          _selectedCamera = eCamera.MINITES;
        }
      }
    });
  }
}
