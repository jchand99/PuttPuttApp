import 'package:flutter/material.dart';
import 'package:puttputtapp/util/nav.dart';
import 'package:puttputtapp/widgets/hole_score_widget.dart';

class HolePage extends StatefulWidget {
  @override
  _HolePageState createState() => _HolePageState();
}

class _HolePageState extends State<HolePage> {
  List<Text> players = [
    Text('Jacob'),
    Text('Alex'),
    Text('Roselyn'),
    Text('Jackson'),
    Text('Bob'),
    Text('Phil'),
    Text('Phrank'),
  ];

  List<Color> colors = [
    Colors.black,
    Colors.black,
    Colors.black,
    Colors.black,
    Colors.black,
    Colors.black,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          child: Row(
            children: [
              Icon(Icons.golf_course_outlined),
              SizedBox(width: 8.0),
              Text('Golf Course Name')
            ],
          ),
        ),
      ),
      body: _body(context),
    );
  }

  Widget _body(BuildContext context) {
    return Column(
      children: [
        Container(
            height: 250,
            alignment: Alignment.center,
            margin: const EdgeInsets.all(60.0),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 5),
                shape: BoxShape.circle),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '2',
                  style: TextStyle(fontSize: 50.0),
                ),
                Icon(Icons.flag_outlined, size: 50.0)
              ],
            )),
        Expanded(child: _listView(context))
      ],
    );
  }

  Widget _listView(BuildContext context) {
    return ListView.builder(
      itemCount: players.length,
      itemBuilder: (context, index) {
        return HoleScore(players[index]);
      },
    );
  }
}
