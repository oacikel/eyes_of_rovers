import 'package:eyes_of_rovers/blocks/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:provider/provider.dart';

class Login extends StatelessWidget {
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
