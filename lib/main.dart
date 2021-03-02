import 'package:flutter/material.dart';
import 'package:puttputtapp/pages/scorecard.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: ScorecardPage("My Putt Putt Place"),
    );
  }
}
