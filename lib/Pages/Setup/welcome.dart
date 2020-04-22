import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:gamuda_app/Pages/Setup/signIn.dart';
import 'package:gamuda_app/Pages/Setup/signUp.dart';

import 'package:gamuda_app/Pages/home.dart';

import 'package:google_sign_in/google_sign_in.dart';

import 'package:flutter_twitter_login/flutter_twitter_login.dart';

class WelcomePage extends StatefulWidget {
  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  //google sign in
  GoogleSignIn googleAuth = new GoogleSignIn();

  //twitter credential
  var twitterCred = new TwitterLogin(
      consumerKey: 'dkAhJ5Y0HuD1DKJMzduxZWyfH',
      consumerSecret: 'niJO4MLcKcYuBX0hDmgSKAJxo7Scm6Y7lAZqvHHFge80777UL9');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Welcome to Tricks App'),
        ),
        body: Center(
          child: Container(
            padding: EdgeInsets.all(25.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                RaisedButton(
                  onPressed: navigateToSignIn,
                  child: Text('Sign in'),
                  color: Colors.blue,
                  textColor: Colors.white,
                  elevation: 5.0,
                ),
                SizedBox(height: 10.0),
                RaisedButton(
                  onPressed: navigateToSignUp,
                  child: Text('Sign up'),
                  color: Colors.blue,
                  textColor: Colors.white,
                  elevation: 5.0,
                ),
                SizedBox(height: 10.0),
                RaisedButton(
                  onPressed: facebookLogin,
                  child: Text('Facebook Login'),
                  color: Colors.blue,
                  textColor: Colors.white,
                  elevation: 5.0,
                ),
                SizedBox(height: 10.0),
                RaisedButton(
                  onPressed: twitterLogin,
                  child: Text('Twitter Login'),
                  color: Colors.blue,
                  textColor: Colors.white,
                  elevation: 5.0,
                ),
                SizedBox(height: 10.0),
                RaisedButton(
                  onPressed: googleLogin,
                  child: Text('Google Login'),
                  color: Colors.blue,
                  textColor: Colors.white,
                  elevation: 7.0,
                ),
              ],
            ),
          ),
        ));
  }

  void navigateToSignIn() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => LoginPage(), fullscreenDialog: false));
  }

  void navigateToSignUp() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => SignUpPage(), fullscreenDialog: false));
  }

  Future<void> facebookLogin() async {
    try {
      FacebookLogin facebookLogin = new FacebookLogin();
      final FacebookLoginResult facebookLoginResult =
          await facebookLogin.logIn(['email', 'public_profile']);
      FacebookAccessToken facebookAccessToken = facebookLoginResult.accessToken;
      AuthCredential authCredential = FacebookAuthProvider.getCredential(
          accessToken: facebookAccessToken.token);
      FirebaseUser user =
          (await FirebaseAuth.instance.signInWithCredential(authCredential))
              .user;
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => Home(user: user)));
    } catch (e) {
      print(e.message);
    }
  }

  Future<void> googleLogin() async {
    try {
      GoogleSignIn _googleSignIn = GoogleSignIn();
      FirebaseAuth _auth = FirebaseAuth.instance;
      GoogleSignInAccount googleUser = await _googleSignIn.signIn();
      GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final AuthCredential authCredential = GoogleAuthProvider.getCredential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      FirebaseUser user =
          (await _auth.signInWithCredential(authCredential)).user;
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => Home(user: user)));
    } catch (e) {
      print(e.message);
    }
  }

  Future<void> twitterLogin() async {
    try {
      TwitterLoginResult result = await twitterCred.authorize();
      switch (result.status) {
        case TwitterLoginStatus.loggedIn:
          final AuthCredential authCredential =
              TwitterAuthProvider.getCredential(
                  authToken: result.session.token,
                  authTokenSecret: result.session.secret);
          FirebaseUser user =
              (await FirebaseAuth.instance.signInWithCredential(authCredential))
                  .user;
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => Home(user: user)));
          break;
        case TwitterLoginStatus.cancelledByUser:
          break;
        case TwitterLoginStatus.error:
          break;
        default:
      }
    } catch (e) {
      print(e.message);
    }
  }
}
