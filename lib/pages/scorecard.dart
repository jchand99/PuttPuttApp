import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:puttputtapp/pages/create_edit_scorecard.dart';
import 'package:puttputtapp/util/nav.dart';
import 'package:puttputtapp/widgets/hole_card_widget.dart';
import 'package:puttputtapp/widgets/player_score_widget.dart';

class ScorecardPage extends StatefulWidget {
  ScorecardPage(this._title, {Key key}) : super(key: key);

  final String _title;

  @override
  _ScorecardPageState createState() => _ScorecardPageState();
}

class _ScorecardPageState extends State<ScorecardPage> {
  final random = Random();

  String _title;
  int _numberOfHoles = 10;

  List<Text> _players = [
    Text('Jacob'),
    Text('Alex'),
    Text('Roselyn'),
    Text('Jackson'),
    Text('Bob'),
    Text('Phil'),
    Text('Phrank'),
  ];

  List<Text> _scores = [
    Text('7'),
    Text('3'),
    Text('4'),
    Text('5'),
    Text('4'),
    Text('2'),
    Text('9')
  ];

  @override
  void initState() {
    _title = widget._title;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          child: Row(
            children: [
              Icon(Icons.golf_course_sharp),
              SizedBox(
                width: 8.0,
              ),
              Text(_title),
            ],
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () => Nav.push(context, CreateEditScorecardPage()),
          )
        ],
      ),
      body: _body(context),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 125.0),
        child: FloatingActionButton(
          // TODO: Eventually this will be a function that creates
          // a new hole in the server and updates the future builder
          // adding the new hole card to the list.
          onPressed: () {
            setState(() {
              _numberOfHoles++;
            });
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [Icon(Icons.golf_course), Icon(Icons.add)],
          ),
        ),
      ),
    );
  }

  Widget _body(BuildContext context) {
    return Column(
      children: [
        Expanded(child: _listView(context)),
        _totals(context),
      ],
    );
  }

  Widget _listView(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return HoleCard(index + 1, _players, _scores, par: 6);
      },
      itemCount: _numberOfHoles,
    );
  }

  Widget _totals(BuildContext buildContext) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(buildContext).primaryColor,
      ),
      padding: const EdgeInsets.all(8.0),
      height: 105,
      width: double.infinity,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return PlayerScore(
              _players[index],
              random.nextInt(35),
              Color.fromARGB(255, random.nextInt(255), random.nextInt(255),
                  random.nextInt(255)));
        },
        itemCount: _players.length,
        separatorBuilder: (context, index) => const VerticalDivider(
          color: Colors.green,
          width: 35,
        ),
      ),
    );
  }
}
