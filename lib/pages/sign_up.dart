import 'package:flutter/material.dart';
import 'package:puttputtapp/util/nav.dart';
import 'package:email_validator/email_validator.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _pass = TextEditingController();
  final TextEditingController _confirmPass = TextEditingController();

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
          margin: EdgeInsets.only(top: 75),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(200),
          ),
          child: Center(
            child: Icon(Icons.sports_golf_rounded, size: 200),
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
              padding: const EdgeInsets.all(12),
              child: TextFormField(
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
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                    Nav.pop(context);
                  }
                },
                child: Text(
                  'Submit',
                  style: TextStyle(color: Colors.white, fontSize: 24),
                ),
              ),
            )
          ],
        ));
  }
}
