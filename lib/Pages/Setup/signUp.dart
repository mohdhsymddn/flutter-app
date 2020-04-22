import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gamuda_app/Pages/Setup/signIn.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  String _email, _password;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up'),
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
                  onPressed: signUp,
                  child: Text('Sign Up'),
                  color: Colors.blue,
                  textColor: Colors.white,
                  elevation: 5.0,
                )
              ],
            ),
          )),
    );
  }

  Future<void> signUp() async {
    final formState = _formKey.currentState;
    if (formState.validate()) {
      formState.save();
      try {
        FirebaseUser user = (await FirebaseAuth.instance
                .createUserWithEmailAndPassword(
                    email: _email, password: _password))
            .user;
        user.sendEmailVerification();
        // display for the user that we sent an email
        Navigator.of(context).pop();
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => LoginPage()));
      } catch (e) {
        print(e.message);
      }
    }
  }
}
