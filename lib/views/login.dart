import 'dart:async';

import 'package:eyes_of_rovers/bloc/auth_bloc.dart';
import 'package:eyes_of_rovers/views/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  StreamSubscription<FirebaseUser>loginStateSubscriotion;
  bool isLoading=false;



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
        child: _handleFacebookButtonWidget(authBloc)
        ),
      );
    }

  Widget _handleFacebookButtonWidget(AuthBloc authBloc){

    if(isLoading){
      return (Text("Please wait..."));
    }else{
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SignInButton(
              Buttons.Facebook,
              onPressed: ()=>{
                setState(() {
                  isLoading=true;
                }),
                authBloc.loginWithFacebook().then((value) => updateLoading(value))
              }
          ),
        ],
      );
    }
  }
  
  void updateLoading(bool a){
    setState(() {
      isLoading=a;
    });
  }

}

