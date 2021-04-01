import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HoleScore extends StatefulWidget {
  HoleScore(this._index, this._player, this._holeNumber, this._scorecard_id,
      {Key key})
      : super(key: key);

  final Text _player;
  final int _holeNumber;
  final String _scorecard_id;
  final int _index;
  @override
  _HoleScoreState createState() => _HoleScoreState();
}

class _HoleScoreState extends State<HoleScore> {
  List<Color> colors = [
    Colors.black,
    Colors.black,
    Colors.black,
    Colors.black,
    Colors.black,
    Colors.black,
    Colors.black
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 80,
      child: Card(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        child: Column(
          children: [
            Text(widget._player.data, style: TextStyle(fontSize: 20)),
            Container(
                //margin: EdgeInsets.only(bottom: 10.0, left: 5),
                child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: () {
                    setState(() {
                      colors.fillRange(0, 7, Colors.black);
                      colors[0] = Colors.red;
                      updateScore(widget._index, 1);
                    });
                  },
                  splashColor: Colors.amber,
                  child: Container(
                    padding: EdgeInsets.all(5),
                    margin: EdgeInsets.only(right: 5),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: colors[0], width: 1.5)),
                    child: Text(
                      '1',
                      style: TextStyle(color: colors[0]),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      colors.fillRange(0, 7, Colors.black);
                      colors[1] = Colors.red;
                      updateScore(widget._index, 2);
                    });
                  },
                  splashColor: Colors.amber,
                  child: Container(
                    padding: EdgeInsets.all(5),
                    margin: EdgeInsets.only(right: 5),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: colors[1], width: 1.5)),
                    child: Text(
                      '2',
                      style: TextStyle(color: colors[1]),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      colors.fillRange(0, 7, Colors.black);
                      colors[2] = Colors.red;
                      updateScore(widget._index, 3);
                    });
                  },
                  splashColor: Colors.amber,
                  child: Container(
                    padding: EdgeInsets.all(5),
                    margin: EdgeInsets.only(right: 5),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: colors[2], width: 1.5)),
                    child: Text(
                      '3',
                      style: TextStyle(color: colors[2]),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      colors.fillRange(0, 7, Colors.black);
                      colors[3] = Colors.red;
                      updateScore(widget._index, 4);
                    });
                  },
                  splashColor: Colors.amber,
                  child: Container(
                    padding: EdgeInsets.all(5),
                    margin: EdgeInsets.only(right: 5),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: colors[3], width: 1.5)),
                    child: Text(
                      '4',
                      style: TextStyle(color: colors[3]),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      colors.fillRange(0, 7, Colors.black);
                      colors[4] = Colors.red;
                      updateScore(widget._index, 5);
                    });
                  },
                  splashColor: Colors.amber,
                  child: Container(
                    padding: EdgeInsets.all(5),
                    margin: EdgeInsets.only(right: 5),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: colors[4], width: 1.5)),
                    child: Text(
                      '5',
                      style: TextStyle(color: colors[4]),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      colors.fillRange(0, 7, Colors.black);
                      colors[5] = Colors.red;
                      updateScore(widget._index, 6);
                    });
                  },
                  splashColor: Colors.amber,
                  child: Container(
                    padding: EdgeInsets.all(5),
                    margin: EdgeInsets.only(right: 5),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: colors[5], width: 1.5)),
                    child: Text(
                      '6',
                      style: TextStyle(color: colors[5]),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      colors.fillRange(0, 7, Colors.black);
                      colors[6] = Colors.red;
                    });
                  },
                  splashColor: Colors.amber,
                  child: Container(
                    width: 25,
                    padding: EdgeInsets.all(6),
                    margin: EdgeInsets.only(right: 5),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: colors[6], width: 1.5)),
                    child: Center(
                      child: TextField(
                        onTap: () {
                          setState(() {
                            colors.fillRange(0, 7, Colors.black);
                            colors[6] = Colors.red;
                          });
                        },
                        onChanged: (value) {
                          if (value == '') return;
                          updateScore(widget._index, int.parse(value));
                        },
                        decoration: InputDecoration(border: InputBorder.none),
                        style: TextStyle(color: Colors.red),
                        keyboardType: TextInputType.number,
                      ),
                    ),
                  ),
                ),
              ],
            )),
          ],
        ),
      ),
    );
  }

  void updateScore(int index, int value) async {
    // Grab the document with the players for that hole
    var doc = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser.uid)
        .collection('scorecards')
        .doc(widget._scorecard_id)
        .collection('holes')
        .doc('hole_${widget._holeNumber - 1}')
        .get();

    // Grab list of players
    var players = doc['players'];
    // Set the players stroke count
    players[index]['strokes'] = value;

    // Update the database to reflect the new stroke count
    FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser.uid)
        .collection('scorecards')
        .doc(widget._scorecard_id)
        .collection('holes')
        .doc('hole_${widget._holeNumber - 1}')
        .update({'players': players});
  }
}
