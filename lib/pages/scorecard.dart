import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:puttputtapp/pages/create_edit_scorecard.dart';
import 'package:puttputtapp/pages/hole.dart';
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
  int _numberOfHoles = 0;

  List<Text> _players = [
    Text('Jacob'),
    Text('Alex'),
    Text('Roselyn'),
    Text('Jackson'),
  ];

  List<Text> _scores = [
    Text('0'),
    Text('0'),
    Text('0'),
    Text('0'),
  ];

  List<Text> _newScores = [
    Text('1'),
    Text('2'),
    Text('3'),
    Text('7'),
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
            onPressed: () => Nav.push(context, CreateEditScorecardPage('Edit')),
          )
        ],
      ),
      body: _body(context),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 125.0),
        child: FloatingActionButton(
          onPressed: () {
            // FIXME: Replace with regular code.
            Nav.push(context, HolePage(_numberOfHoles + 1));
            Future.delayed(const Duration(seconds: 3), () {
              setState(() {
                _numberOfHoles++;
                _scores = _newScores;
              });
            });
            // setState(() {
            //   _numberOfHoles++;
            // });
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [Icon(Icons.add)],
          ),
        ),
      ),
    );
  }

  Widget _body(BuildContext context) {
    return Column(
      children: [
        Expanded(child: _listView(context)),
        Container(
          padding: const EdgeInsets.only(bottom: 50),
          child: Center(
            child: Text("Tap the '+' to create a hole!"),
          ),
        ),
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
              _scores[index],
              Color.fromARGB(255, random.nextInt(255), random.nextInt(255),
                  random.nextInt(255)));
        },
        itemCount: _players.length,
        separatorBuilder: (context, index) => const VerticalDivider(
          color: Color.fromRGBO(0, 0, 0, 0),
          width: 35,
        ),
      ),
    );
  }
}
