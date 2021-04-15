import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:puttputtapp/util/nav.dart';
import 'package:puttputtapp/widgets/hole_score_widget.dart';

class HolePage extends StatefulWidget {
  HolePage(this._holeNumber, this._scorecard_id, this._holeDoc, {Key key})
      : super(key: key);

  final int _holeNumber;
  final String _scorecard_id;
  final DocumentSnapshot _holeDoc;
  @override
  _HolePageState createState() => _HolePageState();
}

class _HolePageState extends State<HolePage> {
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
            onPressed: () async {
              // Updates the total score for all the players in the game.
              var holes = await FirebaseFirestore.instance
                  .collection('users')
                  .doc(FirebaseAuth.instance.currentUser.uid)
                  .collection('scorecards')
                  .doc(widget._scorecard_id)
                  .collection('holes')
                  .get();
              var scorecard = await FirebaseFirestore.instance
                  .collection('users')
                  .doc(FirebaseAuth.instance.currentUser.uid)
                  .collection('scorecards')
                  .doc(widget._scorecard_id)
                  .get();

              var scorecardPlayers = scorecard['players'];

              for (int playerIndex = 0;
                  playerIndex < scorecardPlayers.length;
                  playerIndex++) {
                int totalScore = 0;
                for (int holeIndex = 0;
                    holeIndex < holes.docs.length;
                    holeIndex++) {
                  totalScore +=
                      holes.docs[holeIndex]['players'][playerIndex]['strokes'];
                }

                scorecardPlayers[playerIndex]['total_score'] = totalScore;
                FirebaseFirestore.instance
                    .collection('users')
                    .doc(FirebaseAuth.instance.currentUser.uid)
                    .collection('scorecards')
                    .doc(widget._scorecard_id)
                    .update({'players': scorecardPlayers});
              }

              Nav.pop(context);
            },
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

  Widget _newBody(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(64.0),
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.black, width: 3)),
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
              // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text('Par: ', style: TextStyle(fontSize: 20)),
                Container(
                  width: 40,
                  height: 40,
                  child: TextField(
                    maxLength: 1,
                    onChanged: (value) {
                      if (value == '') return;
                      // Update the par value for this hole in the database
                      FirebaseFirestore.instance
                          .collection('users')
                          .doc(FirebaseAuth.instance.currentUser.uid)
                          .collection('scorecards')
                          .doc(widget._scorecard_id)
                          .collection('holes')
                          .doc('hole_${widget._holeNumber - 1}')
                          .update({'par': int.parse(value)});
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      counterText: '',
                      contentPadding: const EdgeInsets.only(left: 16),
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

  Widget _listView(BuildContext context) {
    return ListView.builder(
      itemCount: widget._holeDoc['players'].length,
      itemBuilder: (context, index) {
        return HoleScore(index, Text(widget._holeDoc['players'][index]['name']),
            widget._holeNumber, widget._scorecard_id);
      },
    );
  }
}
