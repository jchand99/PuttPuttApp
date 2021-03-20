import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _buildColumn(context)
      ),
    );
  }

  Widget _buildColumn(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          height: 275,
          width: 250,
          padding: EdgeInsets.only(top: 100),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(200),
          ),
          child: Center(
            child: Icon(Icons.sports_golf_rounded, size: 200),
          ),
        ),
        Container(
            padding: const EdgeInsets.fromLTRB(12, 40, 12, 12),
            child: TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: '@ Email',
                filled: true,
                fillColor: Colors.white,
              ),
            )),
        Container(
            padding: const EdgeInsets.all(12),
            child: TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: ' Password',
                filled: true,
                fillColor: Colors.white,
              ),
            ))
      ],
    );
  }
}
