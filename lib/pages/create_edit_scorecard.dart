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
            icon: Text("Save", style: new TextStyle(fontSize: 10)),
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
      _buildName(context),
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
            fillColor: Colors.white,
          )),
        ),
        Container(
          padding: const EdgeInsets.all(12.0),
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
              padding: const EdgeInsets.all(24.0),
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
              padding: const EdgeInsets.all(24.0),
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
            fillColor: Colors.white,
          )),
        ),
        Container(
          padding: const EdgeInsets.all(12.0),
          child: SwitchListTile(
            title: const Text('Par'),
            value: par,
            onChanged: (bool value) {
              setState(() {
                par = value;
              });
            },
            secondary: const Icon(Icons.flag_rounded),
          ),
        ),
        Row(
          //crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.all(24.0),
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
              padding: const EdgeInsets.all(24.0),
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
                padding: const EdgeInsets.all(2.0),
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
              padding: const EdgeInsets.all(2.0),
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
    return IconButton(
      icon: Icon(
        Icons.circle,
        color:
            Color((Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0),
      ),
      onPressed: () =>
          Nav.push(context, ColorSelectPage(_names[index]['player'])),
    );
  }
}
