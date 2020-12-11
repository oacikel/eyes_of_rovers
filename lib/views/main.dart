import 'package:flutter/material.dart';
import 'package:eyes_of_rovers/views/home_widget.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Eyes Of Rovers",
      home:Home(),
    );
  }
}