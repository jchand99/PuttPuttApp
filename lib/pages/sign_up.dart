import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:keyboard_visibility/keyboard_visibility.dart';
import 'package:puttputtapp/util/nav.dart';
import 'package:crypto/crypto.dart';
import 'package:email_validator/email_validator.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _pass = TextEditingController();
  final TextEditingController _confirmPass = TextEditingController();

  double marginTop = 75;

  @override
  void initState() {
    KeyboardVisibilityNotification().addNewListener(
      onChange: (bool visible) {
        setState(() {
          marginTop = visible ? 0 : 75;
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
    _confirmPass.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: _buildColumn(context),
      ),
    );
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
        _buildRegistrationForm(context),
      ],
    );
  }

  Widget _buildRegistrationForm(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            Container(
                margin: EdgeInsets.all(12),
                child: Material(
                  elevation: 2,
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
                  elevation: 2,
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
                        if (!value.contains(new RegExp(
                            r'^(?=[a-z])*(?=[0-9])*(?=[A-Z])*(?=[@#$%^&-+=()])*(?=\\S+$)*.{8,20}$'))) {
                          return '- Password must contain a number.\n- Password must contain a special character.\n- Password must contain an upper and lowercase letter.\n- Password must be between 8 and 20 characters long.';
                        }
                        return null;
                      }),
                )),
            Container(
                margin: EdgeInsets.all(12),
                child: Material(
                  elevation: 2,
                  color: Colors.transparent,
                  child: TextFormField(
                      obscureText: true,
                      controller: _confirmPass,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.lock_outline_rounded),
                          labelText: 'Confirm Password',
                          filled: true,
                          fillColor: Colors.white),
                      validator: (value) {
                        if (value.isEmpty) return "Please enter a password";
                        if (value != _pass.text) return "Passwords don't match";
                        return null;
                      }),
                )),
            Container(
                margin: const EdgeInsets.fromLTRB(12, 12, 12, 0),
                child: Material(
                  elevation: 2,
                  color: Colors.transparent,
                  child: ElevatedButton(
                    onPressed: () => onSignUpPressed(),
                    child: Text(
                      'Submit',
                      style: TextStyle(color: Colors.white, fontSize: 24),
                    ),
                  ),
                )),
          ],
        ));
  }

  onSignUpPressed() async {
    // Validate all text fields
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();

      // Encrypt the password because storing plaintext is a no no
      var bytes = utf8.encode(_pass.text);
      var hashed = sha1.convert(bytes);

      var instance = FirebaseAuth.instance;

      // Create a user with email and password login details
      // catching any errors that may occur
      var credential = await instance
          .createUserWithEmailAndPassword(
              email: _email.text.trim(), password: '$hashed')
          .catchError((error) {
        if (error.code == 'email-already-in-use') {
          showDialog(
            context: context,
            builder: (context) {
              if (Platform.isIOS)
                return CupertinoAlertDialog(
                  title: Text(
                      'The email ${_email.text.trim()} is already in use!\nTry using a different email.'),
                  actions: [
                    CupertinoDialogAction(
                      child: Text('Okay'),
                      onPressed: () => Navigator.of(context).pop(),
                    )
                  ],
                );
              else
                return AlertDialog(
                  title: Text(
                      'The email ${_email.text.trim()} is already in use!\nTry using a different email.'),
                  actions: [
                    TextButton(
                      child: Text('Okay'),
                      onPressed: () => Navigator.of(context).pop(),
                    )
                  ],
                );
            },
          );
        }
      });

      // If credentials went through fine (the user was created successfully)
      // then send verification email
      if (credential != null) {
        credential.user.sendEmailVerification();

        // Create the user in the users collection
        // in the database
        FirebaseFirestore.instance
            .collection('users')
            .doc(credential.user.uid)
            .set({
          'scorecardCount': 0,
          // Any other data we want the user to have!
        });

        // reload the credentials to be safe
        credential.user..reload();

        // pop to the login page
        Nav.pop(context);
      }
    }
  }
}
