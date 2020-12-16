import 'dart:async';

import 'package:dio/dio.dart';
import 'package:eyes_of_rovers/bloc/auth_bloc.dart';
import 'package:eyes_of_rovers/model/enum.dart';
import 'package:eyes_of_rovers/model/data.dart';
import 'package:eyes_of_rovers/model/model.dart';
import 'package:eyes_of_rovers/views/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:eyes_of_rovers/constants/Constants.dart' as CONSANTS;
import 'package:provider/provider.dart';
import 'login.dart';
import 'nasa_image_widget.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final String LOG_TAG = "OCULCAN - HomeState: ";
  Data data = Data();
  int _currentIndex = 0;
  int _currentSol = 365;
  eCamera _selectedCamera = eCamera.FHAZ;
  StreamSubscription<FirebaseUser> homeStateSubscription;
  StreamController<int> _solController = StreamController<int>();

  @override
  void initState() {
    AuthBloc authBloc = Provider.of<AuthBloc>(context, listen: false);
    homeStateSubscription = authBloc.currentUser.listen((user) {
      if (user == null) {
        Navigator.of(context)
            .pushReplacement(MaterialPageRoute(builder: (context) => Login()));
      }
    });
    _solController.stream.listen((newSol) {
      setState(() {
        _currentSol = newSol;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    homeStateSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    AuthBloc authbloc = Provider.of<AuthBloc>(context);
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
              if (snapshot.hasError) {
                var error = snapshot.error as DioError;
                return Center(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    (BigMessageWidget(Icons.error, error.message.toString())),
                  ],
                ));
              } else if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                    child: (BigMessageWidget(
                        Icons.hourglass_full, "Please wait...")));
              }
              debugPrint("$LOG_TAG snapshot: ${snapshot.toString()}");
              if (snapshot.data != null) {
                debugPrint(
                    "$LOG_TAG snapshot data is ${snapshot.data.toString()}");
                if ((snapshot.data as List<NasaImage>).isNotEmpty) {
                  return NasaImageWidget(
                      Key(_currentIndex.toString()), snapshot.data);
                } else {
                  return Center(
                      child: Column(
                    children: [
                      (BigMessageWidget(Icons.warning,
                          "Looks like there isn't a photo in this list. Try another filter or pick another sol below.")),
                      SolDayPicker(_solController, _currentSol)
                    ],
                  ));
                }
              } else {
                return Center(
                    child: (BigMessageWidget(Icons.error, "Snapshot is null")));
              }
            }),
        bottomNavigationBar: BottomNavigationBar(
          onTap: _onTabTapped,
          currentIndex: _currentIndex,
          // this will be set when a new tab is tapped
          items: [
            BottomNavigationBarItem(
              icon: Image.asset("assets/icons/icon_curiosity.png",color: Colors.grey,height: 25,),
              activeIcon: Image.asset("assets/icons/icon_curiosity.png", color: Colors.blue,height: 25,),
              title: new Text(CONSANTS.bottom_nav_bar_item_curiosity),
            ),
            BottomNavigationBarItem(
              icon: Image.asset("assets/icons/icon_opportunity.png",color:Colors.grey,height: 25,),
              activeIcon: Image.asset("assets/icons/icon_opportunity.png", color: Colors.blue,height: 25,),
              title: new Text(CONSANTS.bottom_nav_bar_item_opportunity),
            ),
            BottomNavigationBarItem(
                icon: Image.asset("assets/icons/icon_spirit.png",color: Colors.grey,height: 25,),
                activeIcon: Image.asset("assets/icons/icon_spirit.png", color: Colors.blue,height: 25,),
                title: Text(CONSANTS.bottom_nav_bar_item_spirit))
          ],
        ),
        drawer: Drawer(
          child: ListView(
            children: <Widget>[
               DrawerHeader(
                 decoration: BoxDecoration(
                   color:Theme.of(context).bottomAppBarColor),
                child: (StreamBuilder<FirebaseUser>(
                  stream: authbloc.currentUser,
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return CircularProgressIndicator();
                    } else {
                      return Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          CircleAvatar(
                            backgroundImage:
                                NetworkImage(snapshot.data.photoUrl +'?width=400&height=400'),
                            radius: 50,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(snapshot.data.displayName,
                            ),
                          )
                        ],
                      );
                    }
                  },
                )),
              ),
              ListTile(
                leading: Icon(Icons.date_range),
                title: Text("Change current sol ($_currentSol)"),
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return Dialog(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0)),
                          child: Container(
                            height: 160,
                            child: (SolDayPicker(
                              _solController,
                              _currentSol,
                            )),
                          ),
                        );
                      });
                },
              ),
              ListTile(
                leading: Icon(Icons.exit_to_app),
                title: Text('Log Out'),
                onTap: () {
                  authbloc.logout();
                  Navigator.pop(context);
                },
              ),
            ],
          ),
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
    } else if (_currentIndex == 1 || _currentIndex == 2) {
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
      return data.getListOfPhotos(
          eRoverName.ROVER_CURIOSITY, _currentSol, _selectedCamera, 1);
    } else if (_currentIndex == 1) {
      return data.getListOfPhotos(
          eRoverName.ROVER_OPPORTUNITY, _currentSol, _selectedCamera, 1);
    } else if (_currentIndex == 2) {
      return data.getListOfPhotos(
          eRoverName.ROVER_SPIRIT, _currentSol, _selectedCamera, 1);
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
      } else if (_currentIndex == 1 || _currentIndex == 2) {
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
