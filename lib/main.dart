import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'bloc/auth_bloc.dart';
import 'views/login.dart';

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
