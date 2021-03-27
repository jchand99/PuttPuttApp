import 'package:flutter/material.dart';
import 'package:puttputtapp/pages/color_select.dart';
import 'package:puttputtapp/pages/home.dart';
import 'package:puttputtapp/pages/scorecard.dart';
import 'package:puttputtapp/pages/create_edit_scorecard.dart';
import 'dart:math';
import 'package:puttputtapp/util/nav.dart';

class CreateEditScorecardPage extends StatefulWidget {
  CreateEditScorecardPage(this._title, {Key key}) : super(key: key);

  final String _title;

  @override
  _CreateEditScorecardPageState createState() =>
      _CreateEditScorecardPageState();
}

class _CreateEditScorecardPageState extends State<CreateEditScorecardPage> {
  @override
  Widget build(BuildContext context) {
    if (_namesCount == 0) {
      _addCard();
      _addCard();
      _addCard();
      _addCard();
    }
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            iconSize: 30,
            icon: Text("Save", style: new TextStyle(fontSize: 14)),
            onPressed: () =>
                Nav.pushAndReplace(context, ScorecardPage("Scorecard")),
          )
        ],
        title: Center(
          child: Text('${widget._title} Scorecard'),
        ),
      ),
      body: _buildScrollPage(context),
    );
  }

  Widget _buildScrollPage(BuildContext context) {
    /*  return SingleChildScrollView(
        child: ConstrainedBox(
            constraints: BoxConstraints(), child: _buildColumn(context)));*/
    return _buildColumn(context);
  }

  Column _buildColumn(BuildContext context) {
    return Column(children: <Widget>[
      Container(
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          // decoration: BoxDecoration(
          //   boxShadow: [
          //     BoxShadow(
          //       color: Colors.grey[200],
          //       spreadRadius: 1,
          //       blurRadius: 1,
          //       offset: Offset(0, 1), // changes position of shadow
          //     ),
          //   ],
          // ),
          //color: Colors.white,
          child: _buildName(context)),
      Expanded(child: _buildPlayers(context)),
      //_buildButtons(context),
    ]);
  }

  bool par = false;

  Widget _buildName(BuildContext context) {
    if (!par) {
      return Column(children: <Widget>[
        //Text('Course Name', textAlign: TextAlign.left, style: new TextStyle(fontSize: 16)),
        Container(
          padding: const EdgeInsets.all(12.0),
          child: TextField(
              decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Course Name',
            filled: true,
            fillColor: Colors.grey[200],
          )),
        ),
        Container(
          padding: const EdgeInsets.only(
            left: 12,
            top: 0,
            right: 12,
            bottom: 0,
          ),
          child: SwitchListTile(
            title: const Text('Par', style: TextStyle(fontSize: 16)),
            value: par,
            onChanged: (bool value) {
              setState(() {
                par = value;
              });
            },
            secondary: const Icon(Icons.flag_outlined),
          ),
        ),
        Row(
          //crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                left: 26,
                top: 0,
                right: 26,
                bottom: 0,
              ),
              child: Align(
                child: Text(
                  'Players',
                  style: TextStyle(fontSize: 16),
                ),
                alignment: Alignment.centerLeft,
              ),
            ),
            Expanded(
                child: Padding(
              padding: const EdgeInsets.only(
                left: 26,
                top: 12,
                right: 26,
                bottom: 16,
              ),
              child: Align(
                  child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _addCard();
                        });
                      },
                      child: Text("+", style: TextStyle(fontSize: 16))),
                  alignment: Alignment.centerRight),
            ))
          ],
        )
      ]);
    } else {
      return Column(children: <Widget>[
        //Text('Course Name', textAlign: TextAlign.left, style: new TextStyle(fontSize: 16)),
        Container(
          padding: const EdgeInsets.all(12.0),
          child: TextField(
              decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Course Name',
            filled: true,
            fillColor: Colors.grey[200],
          )),
        ),
        Container(
          padding: const EdgeInsets.only(
            left: 12,
            top: 0,
            right: 12,
            bottom: 0,
          ),
          child: SwitchListTile(
            title: const Text('Par', style: TextStyle(fontSize: 16)),
            value: par,
            onChanged: (bool value) {
              setState(() {
                par = value;
              });
            },
            secondary: const Icon(Icons.flag_outlined),
          ),
        ),
        Row(
          //crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                left: 26,
                top: 0,
                right: 26,
                bottom: 0,
              ),
              child: Align(
                child: Text(
                  'Players',
                  style: TextStyle(fontSize: 16),
                ),
                alignment: Alignment.centerLeft,
              ),
            ),
            Expanded(
                child: Padding(
              padding: const EdgeInsets.only(
                left: 26,
                top: 12,
                right: 26,
                bottom: 16,
              ),
              child: Align(
                  child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _addCard();
                        });
                      },
                      child: Text("+", style: TextStyle(fontSize: 16))),
                  alignment: Alignment.centerRight),
            ))
          ],
        )
      ]);
    }
  }

  Widget _buildPlayers(BuildContext context) {
    return Container(
      //height: _namesCount.toDouble() * 95,
      child: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: _names.length,
        itemBuilder: (context, index) {
          return _buildPlayerName(context, index);
        },
        separatorBuilder: (context, index) => Divider(
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildButtons(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(children: <Widget>[
        ElevatedButton(
            onPressed: () {
              setState(() {
                _addCard();
              });
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Add Player", style: TextStyle(fontSize: 18)),
            )),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
              onPressed: () => Nav.push(context, HomePage()),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Save", style: TextStyle(fontSize: 18)),
              )),
        )
      ]),
    );
  }

  List _names = [];
  bool removeCards = false;
  int _namesCount = 0;

  void _removeCard(int index) {
    if (_namesCount > 1) {
      setState(() {
        _names.removeAt(index);
        _namesCount--;
      });
    } else {
      print("Must have at least one player!");
    }
  }

  void _addCard() {
    _namesCount++;
    _names.add({'player': "Player $_namesCount"});
  }

  Widget _buildPlayerName(BuildContext context, index) {
    if (_namesCount == 1) {
      return Card(
          elevation: 10,
          child: ListTile(
              title: //Text(_names[index]['player']),
                  Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Container(
                  //height: 4,
                  child: TextField(
                    style: TextStyle(
                      fontSize: 18,
                    ),
                    decoration: InputDecoration(
                        filled: false, labelText: (_names[index]['player'])),
                  ),
                ),
              ),
              leading: _ballColor(context, index)));
    } else {
      return Card(
          elevation: 10,
          child: ListTile(
            title: //Text(_names[index]['player']),
                Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Container(
                //height: 4,
                child: TextField(
                  style: TextStyle(
                    fontSize: 18,
                  ),
                  decoration: InputDecoration(
                      filled: false, labelText: (_names[index]['player'])),
                ),
              ),
            ),
            leading: _ballColor(context, index),
            trailing: IconButton(
                icon: Icon(Icons.highlight_remove_outlined),
                onPressed: () {
                  _removeCard(index);
                }),
          ));
    }
  }

  Widget _ballColor(BuildContext context, index) {
    return Stack(alignment: AlignmentDirectional.center, children: <Widget>[
      Icon(
        Icons.circle,
        size: 32,
        color:
            Color((Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0),
      ),
      IconButton(
        icon: Icon(Icons.edit, color: Colors.black, size: 22),
        onPressed: () =>
            Nav.push(context, ColorSelectPage(_names[index]['player'])),
      ),
    ]);
  }
}
