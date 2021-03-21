import 'package:flutter/material.dart';
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
  final TextEditingController _pass = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: _buildColumn(context)),
    );
  }

  Widget _buildColumn(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          height: 200,
          width: 200,
          margin: EdgeInsets.only(top: 100),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(200),
          ),
          child: Center(
            child: Icon(Icons.sports_golf_rounded, size: 200),
          ),
        ),
        _buildLoginForm(context),
        // Container(
        //     margin: const EdgeInsets.only(top: 20),
        //     padding: const EdgeInsets.all(12),
        //     child: TextField(
        //       decoration: InputDecoration(
        //         border: OutlineInputBorder(),
        //         labelText: '@ Email',
        //         filled: true,
        //         fillColor: Colors.white,
        //       ),
        //     )),
        // Container(
        //     padding: const EdgeInsets.all(12),
        //     child: TextField(
        //       decoration: InputDecoration(
        //         border: OutlineInputBorder(),
        //         prefixIcon: Icon(Icons.lock_outline_rounded),
        //         labelText: 'Password',
        //         filled: true,
        //         fillColor: Colors.white,
        //       ),
        //     )),
        // Container(
        //     height: 50,
        //     width: 250,
        //     margin: const EdgeInsets.only(top: 40),
        //     decoration: BoxDecoration(
        //         color: Theme.of(context).primaryColor,
        //         borderRadius: BorderRadius.circular(15)),
        //     child: ElevatedButton(
        //       onPressed: () {
        //         Nav.push(context, HomePage());
        //       },
        //       child: Text(
        //         'Sign In!',
        //         style: TextStyle(color: Colors.white, fontSize: 24),
        //       ),
        //     )),
        // Container(
        //     height: 50,
        //     width: 250,
        //     child: TextButton(
        //       onPressed: () {
        //         Nav.push(context, SignUpPage());
        //       },
        //       child: Text(
        //         'Sign up!',
        //         style: TextStyle(color: Colors.green[700], fontSize: 24),
        //       ),
        //     ))
      ],
    );
  }

  Widget _buildLoginForm(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(12),
              child: TextFormField(
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
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: TextFormField(
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
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 12, 12, 0),
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
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
              child: TextButton(
                onPressed: () {
                  Nav.push(context, SignUpPage());
                },
                child: Text(
                  'Sign Up!',
                  style: TextStyle(color: Colors.green[700], fontSize: 24),
                ),
              ),
            )
          ],
        ));
  }
}
