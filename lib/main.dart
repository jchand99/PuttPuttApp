import 'package:flutter/material.dart';
import 'package:puttputtapp/pages/login.dart';

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
        primaryColor: Colors.green[700],
        accentColor: Colors.green[700],
        scaffoldBackgroundColor: Colors.grey[300],
      ),
      home: LoginPage(),
    );
  }
}
