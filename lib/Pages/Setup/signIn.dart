import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gamuda_app/Pages/home.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String _email, _password;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign In'),
      ),
      body: Form(
          key: _formKey,
          child: Container(
            padding: EdgeInsets.all(25.0),
            child: Column(
              children: <Widget>[
                TextFormField(
                  validator: (input) {
                    if (input.isEmpty) {
                      return 'Please type an email';
                    }
                  },
                  onSaved: (input) => _email = input,
                  decoration: InputDecoration(labelText: 'Email'),
                ),
                TextFormField(
                  validator: (input) {
                    if (input.length < 6) {
                      return 'Your password needs to be atleast 6 characters';
                    }
                  },
                  onSaved: (input) => _password = input,
                  decoration: InputDecoration(labelText: 'Password'),
                  obscureText: true,
                ),
                SizedBox(height: 10.0),
                RaisedButton(
                  onPressed: signIn,
                  child: Text('Sign In'),
                  color: Colors.blue,
                  textColor: Colors.white,
                  elevation: 5.0,
                )
              ],
            ),
          )),
    );
  }

  Future<void> signIn() async {
    final formState = _formKey.currentState;
    if (formState.validate()) {
      formState.save();
      try {
        FirebaseUser user = (await FirebaseAuth.instance
                .signInWithEmailAndPassword(email: _email, password: _password))
            .user;
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Home(user: user)));
      } catch (e) {
        print(e.message);
      }
    }
  }
}
