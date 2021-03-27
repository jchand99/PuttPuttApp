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
    return Scaffold(
      body: SingleChildScrollView(
        child:_buildColumn(context)
      )
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
              )
            ),
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
                    }
                ),
              )                 
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(12, 12, 12, 0),
              child: Material(
                elevation: 10,
                color: Colors.transparent,
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      Nav.push(context, HomePage());
                    }
                  },
                  child: Text(
                    'Sign In!',
                    style: TextStyle(color: Colors.white, fontSize: 24),
                  ),
                ),
              )
            ),
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
              )
            )
          ],
        ));
  }
}
