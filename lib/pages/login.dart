import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto/crypto.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:keyboard_visibility/keyboard_visibility.dart';
import 'package:puttputtapp/pages/home.dart';
import 'package:puttputtapp/pages/sign_up.dart';
import 'package:puttputtapp/util/nav.dart';
import 'package:email_validator/email_validator.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _pass = TextEditingController();

  double marginTop = 100;

  @override
  void initState() {
    KeyboardVisibilityNotification().addNewListener(
      onChange: (bool visible) {
        setState(() {
          marginTop = visible ? 0 : 100;
        });
      },
    );
    super.initState();
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    _email.dispose();
    _pass.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SingleChildScrollView(child: _buildColumn(context)));
  }

  Widget _buildColumn(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(top: marginTop),
          child: Center(
            child: Icon(Icons.sports_golf_rounded, size: 180),
          ),
        ),
        _buildLoginForm(context),
      ],
    );
  }

  Widget _buildLoginForm(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            Container(
                margin: EdgeInsets.all(12),
                child: Material(
                  elevation: 10,
                  color: Colors.transparent,
                  child: TextFormField(
                    controller: _email,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.email_outlined),
                        labelText: 'Email',
                        filled: true,
                        fillColor: Colors.white),
                    validator: (value) => EmailValidator.validate(value)
                        ? null
                        : "Please enter a valid email",
                  ),
                )),
            Container(
                margin: EdgeInsets.all(12),
                child: Material(
                  elevation: 10,
                  color: Colors.transparent,
                  child: TextFormField(
                      obscureText: true,
                      controller: _pass,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.lock_outline_rounded),
                          labelText: 'Password',
                          filled: true,
                          fillColor: Colors.white),
                      validator: (value) {
                        if (value.isEmpty) return "Please enter a password";
                        return null;
                      }),
                )),
            Container(
                margin: const EdgeInsets.fromLTRB(12, 12, 12, 0),
                child: Material(
                  elevation: 10,
                  color: Colors.transparent,
                  child: ElevatedButton(
                    onPressed: () => onSignInPressed(),
                    child: Text(
                      'Sign In!',
                      style: TextStyle(color: Colors.white, fontSize: 24),
                    ),
                  ),
                )),
            Container(
                margin: const EdgeInsets.fromLTRB(12, 12, 12, 12),
                child: Material(
                  elevation: 10,
                  color: Colors.transparent,
                  child: ElevatedButton(
                    onPressed: () {
                      Nav.push(context, SignUpPage());
                    },
                    child: Text(
                      'Sign Up!',
                      style: TextStyle(color: Colors.white, fontSize: 24),
                    ),
                  ),
                )),
            Container(
                margin: const EdgeInsets.fromLTRB(12, 12, 12, 12),
                child: Material(
                  elevation: 10,
                  color: Colors.transparent,
                  child: ElevatedButton(
                    onPressed: () async {
                      var credential =
                          await FirebaseAuth.instance.signInAnonymously();

                      // Reload the current credentials to be safe
                      var currentUser = credential.user..reload();

                      // Else send them to the HomePage widget
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => HomePage(
                            currentUser,
                          ),
                        ),
                      );

                      // Create the user in the users collection
                      // in the database
                      FirebaseFirestore.instance
                          .collection('users')
                          .doc(credential.user.uid)
                          .set({
                        'scorecard_count': 0,
                        // Any other data we want the user to have!
                      });

                      // reload the credentials to be safe
                      credential.user..reload();
                    },
                    child: Text(
                      'Login Anonymously!',
                      style: TextStyle(color: Colors.white, fontSize: 24),
                    ),
                  ),
                ))
          ],
        ));
  }

  onSignInPressed() async {
    // Validate all the input fields
    if (_formKey.currentState.validate()) {
      var instance = FirebaseAuth.instance;

      // Encode the password into a hash that will be sent
      // to the Auth database. We don't want send or store the password
      // as plaintext because thats a no no
      var bytes = utf8.encode(_pass.text);
      var hashed = sha1.convert(bytes);

      // Try signing in with the email and password provided
      // and catch the error if one exists
      var credential = await instance
          .signInWithEmailAndPassword(
              email: _email.text.trim(), password: '$hashed')
          .catchError((error) {
        if (error.code == 'wrong-password') {
          setState(() {
            // TODO: Incorrect password Error
          });
        } else if (error.code == 'user-not-found') {
          setState(() {
            // TODO: User not found Error
          });
        } else if (error.code == 'user-disabled') {
          print('User has been disabled!');
        }
      });

      // Reload the current credentials to be safe
      var currentUser = credential.user..reload();

      // If the user is verified then let them login
      // otherwise show them a prompt to verify their account
      // via email
      //
      // Note**: This is an optional feature. if we
      // don't want this anymore we can remove it
      if (currentUser != null && !currentUser.emailVerified) {
        showDialog(
          context: context,
          builder: (context) {
            if (Platform.isIOS)
              return CupertinoAlertDialog(
                title: Center(child: Text('Please verify email first!')),
                actions: [
                  CupertinoDialogAction(
                    child: Text('Okay'),
                    onPressed: () => Navigator.of(context).pop(),
                  )
                ],
              );
            else
              return AlertDialog(
                title: Center(child: Text('Please verify email first!')),
                actions: [
                  TextButton(
                    child: Text('Okay'),
                    onPressed: () => Navigator.of(context).pop(),
                  )
                ],
              );
          },
        );
      } else {
        // Else send them to the HomePage widget
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => HomePage(
              currentUser,
            ),
          ),
        );
      }
    }
  }
}
