import 'package:flutter/material.dart';
import 'package:puttputtapp/util/nav.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
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
        Container(
            margin: const EdgeInsets.only(top: 20),
            padding: const EdgeInsets.all(12),
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
                prefixIcon: Icon(Icons.lock_outline_rounded),
                labelText: 'Password',
                filled: true,
                fillColor: Colors.white,
              ),
            )),
        Container(
          padding: const EdgeInsets.all(12),
          child: TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.lock_outline_rounded),
              labelText: 'Confirm Password',
              filled: true,
              fillColor: Colors.white,
            ),
        )),
        Container(
            height: 50,
            width: 250,
            margin: const EdgeInsets.only(top: 40),
            decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(15)),
            child: ElevatedButton(
              onPressed: () {
                Nav.pop(context);
              },
              child: Text(
                'Submit',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            )),
      ],
    );
  }
}
