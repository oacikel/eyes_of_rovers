import 'dart:async';

import 'package:eyes_of_rovers/blocks/auth_bloc.dart';
import 'package:eyes_of_rovers/views/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  StreamSubscription<FirebaseUser>loginStateSubscriotion;
  @override
  void initState() {
    AuthBloc authBloc =Provider.of<AuthBloc>(context,listen: false);
    loginStateSubscriotion=authBloc.currentUser.listen((user) {
      if(user!=null){
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder:(context)=>Home()));
      }
    });
  super.initState();
  }

  @override void dispose() {
    loginStateSubscriotion.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    AuthBloc authBloc =Provider.of<AuthBloc>(context);
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SignInButton(
              Buttons.Facebook,
              onPressed: ()=>authBloc.loginWithFacebook()
            )
          ],
        ),
      ),
    );
  }
}
