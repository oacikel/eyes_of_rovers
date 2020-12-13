import 'package:eyes_of_rovers/services/service_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';

class AuthBloc{
  final String LOG_TAG ="OCULCAN - AuthBloc: ";
  final authService =AuthService();
  final facebookLogin=FacebookLogin();

  Stream<FirebaseUser> get currentUser => authService.currentUser;

  loginWithFacebook()async{
    debugPrint("${LOG_TAG}Starting login via Facebook");

    final result =await facebookLogin.logIn(
      permissions: [
        FacebookPermission.publicProfile,
        FacebookPermission.email,
      ]
    );
    switch(result.status){

      case FacebookLoginStatus.Success:
        debugPrint("${LOG_TAG}Login worked");
        //Get Token
        final FacebookAccessToken facebookToken =result.accessToken;
        //Convert to Auth Credential
        final AuthCredential credential =
        FacebookAuthProvider.getCredential(accessToken: facebookToken.token);

        //User credential to signin with firebase
        

        break;
      case FacebookLoginStatus.Cancel:
        debugPrint("${LOG_TAG}User canceled");
        break;
      case FacebookLoginStatus.Error:
        debugPrint("${LOG_TAG}Error while logging in");
        break;
    }
  }
}
