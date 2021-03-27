import 'dart:math';

import 'package:flutter/material.dart';

class ColorSelectPage extends StatefulWidget {
  ColorSelectPage(this._name, {Key key}) : super(key: key);

  final String _name;

  @override
  _ColorSelectPageState createState() => _ColorSelectPageState();
}

Color _playerColor = Colors.red;

class _ColorSelectPageState extends State<ColorSelectPage> {
  String _name;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text('$_name'),
        ),
      ),
      body: Column(
        children: [
          _topCard(context),
          _ballColors(context),
        ],
      ),
    );
  }

  @override
  void initState() {
    _name = widget._name;
    super.initState();
  }

  Widget _ballColors(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Card(
        elevation: 10,
        child: ListTile(
            title: Column(
          children: [
            _rowSpacer(context),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _ballColor(context, Colors.red),
                _ballColor(context, Colors.orange),
                _ballColor(context, Colors.yellow),
                _ballColor(context, Colors.lightGreen),
              ],
            ),
            _rowSpacer(context),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _ballColor(context, Colors.green),
                _ballColor(context, Colors.blue),
                _ballColor(context, Colors.indigo),
                _ballColor(context, Colors.purple),
              ],
            ),
            _rowSpacer(context),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _ballColor(context, Colors.black),
                _ballColor(context, Colors.white),
                _ballColor(context, Colors.pink[250]),
                _ballColor(context, Colors.brown),
              ],
            ),
            _rowSpacer(context),
          ],
        )),
      ),
    );
  }

  Widget _topCard(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Card(
          elevation: 10,
          child: ListTile(
              title: //Text(_names[index]['player']),
                  Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Container(
                        //height: 4,
                        child: Text('$_name', style: TextStyle(fontSize: 18)),
                      )),
              leading: _ballColor(context, _playerColor))),
    );
  }

  Widget _rowSpacer(BuildContext context) {
    return SizedBox(height: 16);
  }

  Widget _ballColor(BuildContext context, Color color) {
    return IconButton(
      icon: Icon(
        Icons.circle,
        color: color,
        //size: 32,
      ),
      onPressed: () {
        setState(() {
          _playerColor = color;
        });
      },
    );
  }
}
