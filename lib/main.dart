import 'package:flutter/material.dart';
import 'package:puttputtapp/pages/login.dart';
import 'package:puttputtapp/pages/scorecard.dart';
import 'pages/home.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  var firebaseApp = Firebase.initializeApp();
  runApp(MyApp(firebaseApp));
}

class MyApp extends StatelessWidget {
  MyApp(this._firebaseApp);

  final Future<FirebaseApp> _firebaseApp;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _firebaseApp,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return _buildApp(
              context,
              Center(
                child: Text('Error loading Firebase!'),
              ));
        }

        if (snapshot.connectionState == ConnectionState.done) {
          var currentUser = FirebaseAuth.instance.currentUser;
          if (currentUser == null) {
            return _buildApp(context, LoginPage());
          } else {
            return _buildApp(context, HomePage(currentUser));
          }
        }

        return _buildApp(
            context,
            Container(
              color: Colors.white,
              child: Center(child: CircularProgressIndicator()),
            ));
      },
    );
  }

  Widget _buildApp(BuildContext context, Widget body) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
        primaryColor: Colors.green[700],
        accentColor: Colors.green[700],
        scaffoldBackgroundColor: Colors.grey[300],
        fontFamily: 'Lexend',
      ),
      home: body,
    );
  }
}
