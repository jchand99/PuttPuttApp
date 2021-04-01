import 'package:flutter/material.dart';
import 'package:puttputtapp/util/nav.dart';
import 'package:puttputtapp/widgets/hole_score_widget.dart';

class HolePage extends StatefulWidget {
  HolePage(this._holeNumber, {Key key}) : super(key: key);

  final int _holeNumber;
  @override
  _HolePageState createState() => _HolePageState();
}

class _HolePageState extends State<HolePage> {
  List<Text> players = [
    Text('Jacob'),
    Text('Alex'),
    Text('Roselyn'),
    Text('Jackson'),
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
        actions: [
          TextButton(
            child: Text('Save', style: TextStyle(color: Colors.white)),
            onPressed: () => Nav.pop(context),
          )
        ],
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
      body: _newBody(context),
    );
  }

  Widget _newBody(BuildContext) {
    return Center(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(64.0),
            decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.90),
                shape: BoxShape.circle,
                border: Border.all(color: Colors.transparent, width: 3),
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 5))
                ]),
            child: Column(
              children: [
                Text('${widget._holeNumber}', style: TextStyle(fontSize: 50)),
                Icon(Icons.flag_outlined, size: 50)
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Par: ', style: TextStyle(fontSize: 20)),
                Container(
                  decoration: BoxDecoration(boxShadow: [
                    BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 1.5,
                        blurRadius: 7,
                        offset: Offset(0, 3))
                  ], color: Colors.grey[300]),
                  width: 40,
                  height: 40,
                  child: TextField(
                    onTap: () => print('Hello'),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ],
            ),
          ),
          Expanded(child: _listView(context)),
        ],
      ),
    );
  }

  Widget _body(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Center(
          child: Container(
            margin: const EdgeInsets.all(60.0),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black, width: 5),
              shape: BoxShape.circle,
              color: Colors.amber,
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '${widget._holeNumber}',
                    style: TextStyle(fontSize: 50.0),
                  ),
                  Icon(Icons.flag_outlined, size: 50.0)
                ],
              ),
            ),
          ),
        ),
        Container(
          color: Colors.red,
          // height: 10,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Par: '),
              TextField(),
            ],
          ),
        ),
        // Expanded(child: _listView(context))
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
