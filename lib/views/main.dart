import 'package:eyes_of_rovers/blocks/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'login.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (context)=> AuthBloc(),
      child: MaterialApp(
        title: "Eyes Of Rovers",
        home:Login(),
      ),
    );
  }
}
