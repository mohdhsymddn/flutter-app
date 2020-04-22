import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gamuda_app/Pages/Setup/welcome.dart';

class Home extends StatelessWidget {
  const Home({Key key, this.user}) : super(key: key);
  final FirebaseUser user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Home ${user.email}'),
        ),
        body: Center(
          child: Container(
            child: new Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(' ${user.email} have successfully logged in!'),
                  SizedBox(
                    height: 15.0,
                  ),
                  OutlineButton(
                    borderSide: BorderSide(
                      color: Colors.red,
                      style: BorderStyle.solid,
                      width: 3.0
                    ),
                    child: Text('Sign out'),
                    onPressed: () {
                      FirebaseAuth.instance.signOut().then((value) {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => WelcomePage()));
                      }).catchError((e) {
                        print(e);
                      });
                  }),
                ]),
          ),
        )
        );
  }
}

//role checking

//  @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Home ${user.email}'),
//       ),
//       body: StreamBuilder<DocumentSnapshot>(
//         stream: Firestore.instance.collection('users').document(user.uid).snapshots(),
//         builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
//           if(snapshot.hasError) {
//             return Text('Error: ${snapshot.error}');
//           }
//           switch(snapshot.connectionState) {
//             case ConnectionState.waiting:
//               return Text('Loading ..');
//             default:
//               return checkRole(snapshot.data);
//           }
//         },
//       ),
//     );
//   }

//   Center checkRole(DocumentSnapshot snapshot) {
//     if(snapshot.data['role'] == 'admin') {
//       return adminPage(snapshot);
//     } else {
//       return userPage(snapshot);
//     }
//   }

//   Center adminPage(DocumentSnapshot snapshot) {
//     return Center(child: Text(snapshot.data['role'] + ' Page'));
//   }

//   Center userPage(DocumentSnapshot snapshot) {
//     return Center(child: Text(snapshot.data['role'] + ' Page'));
//   }
