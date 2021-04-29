import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:puttputtapp/util/color_picker.dart';
import 'package:puttputtapp/util/nav.dart';

class ColorSelectPage extends StatefulWidget {
  ColorSelectPage(this._playerName, this._scorecard_id,
      {Key key, this.onChanged})
      : super(key: key);

  final String _playerName;
  final String _scorecard_id;
  final ValueChanged<String> onChanged;

  @override
  _ColorSelectPageState createState() => _ColorSelectPageState();
}

class _ColorSelectPageState extends State<ColorSelectPage> {
  Color _playerColor = Colors.red;
  String _name;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
              child: Text('Save', style: TextStyle(color: Colors.white)),
              onPressed: () {
                widget.onChanged(ColorPicker.getStringFromColor(_playerColor));
                Nav.pop(context);
              })
        ],
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          widget.onChanged(ColorPicker.getStringFromColor(_playerColor));
          Nav.pop(context);
        },
        child: const Icon(Icons.check),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _name = widget._playerName;
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
                _ballColor(context, Colors.pink),
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
