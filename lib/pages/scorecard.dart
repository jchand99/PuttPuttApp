import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:puttputtapp/pages/create_edit_scorecard.dart';
import 'package:puttputtapp/pages/hole.dart';
import 'package:puttputtapp/util/color_picker.dart';
import 'package:puttputtapp/util/nav.dart';
import 'package:puttputtapp/widgets/hole_card_widget.dart';
import 'package:puttputtapp/widgets/player_score_widget.dart';

class ScorecardPage extends StatefulWidget {
  ScorecardPage(this._title, this._scorecard_id, this._par, {Key key})
      : super(key: key);

  final String _title;
  final String _scorecard_id;
  final bool _par;

  @override
  _ScorecardPageState createState() => _ScorecardPageState();
}

class _ScorecardPageState extends State<ScorecardPage> {
  final random = Random();

  String _title;

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
              Icon(Icons.golf_course),
              Text(
                _title,
                style: TextStyle(fontSize: 18),
              ),
            ],
          ),
        ),
        actions: [
          IconButton(
              icon: Icon(Icons.settings),
              onPressed: () => Nav.push(
                    context,
                    CreateEditScorecardPage('Edit',
                        FirebaseAuth.instance.currentUser, widget._scorecard_id,
                        editMode: true),
                  ))
        ],
      ),
      body: _body(context),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 125.0),
        child: FloatingActionButton(
          onPressed: () async {
            // Grab the document for the scorecard this hole belongs to
            var holeCountDoc = await FirebaseFirestore.instance
                .collection('users')
                .doc(FirebaseAuth.instance.currentUser.uid)
                .collection('scorecards')
                .doc(widget._scorecard_id)
                .get();

            // Grab the hole count
            var holeCount = holeCountDoc['hole_count'];
            // Create an id for the hole
            var id = 'hole_$holeCount';

            // Create a list of player objects containing all the necessary
            // information about each player
            List players = [];
            for (int i = 0; i < holeCountDoc['players'].length; i++) {
              players.add({
                'name': holeCountDoc['players'][i]['name'],
                'strokes': 0,
              });
            }

            // Create a new hole document in the 'holes' collection
            // with the list of players and the par value defaulted to
            // zero
            FirebaseFirestore.instance
                .collection('users')
                .doc(FirebaseAuth.instance.currentUser.uid)
                .collection('scorecards')
                .doc(widget._scorecard_id)
                .collection('holes')
                .doc(id)
                .set({
              'players': players,
              'par': 0,
            });

            // update the hole count by 1
            FirebaseFirestore.instance
                .collection('users')
                .doc(FirebaseAuth.instance.currentUser.uid)
                .collection('scorecards')
                .doc(widget._scorecard_id)
                .update({
              'hole_count': holeCount++,
            });

            // Push them to the new hole page
            Nav.push(context,
                HolePage(holeCount, widget._scorecard_id, holeCountDoc));
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
    // Create a stream builder for the list of holes in the database
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser.uid)
          .collection('scorecards')
          .doc(widget._scorecard_id)
          .collection('holes')
          .snapshots(),
      builder: (context, snapshot) {
        // If the connection is still going then return a progress indicator
        if (snapshot.connectionState == ConnectionState.waiting)
          return Center(child: CircularProgressIndicator());

        // If the snapshots data is null then something is wrong with the connection
        if (snapshot.data == null)
          return Center(
              child: Text('Something is wrong with the internet connection!'));

        // if the length of the documents is 0 then show help text
        if (snapshot.data.docs.length == 0)
          return Center(
              child: Text(
            'Press the \'+\' in the bottom right hand corner to start a hole!',
          ));

        // Else return the list of holes from the database
        return ListView.builder(
          itemBuilder: (context, index) {
            var doc = snapshot.data.docs[index];
            return widget._par
                ? HoleCard(index + 1, widget._scorecard_id, doc,
                    par: doc['par'])
                : HoleCard(index + 1, widget._scorecard_id, doc);
          },
          itemCount: snapshot.data.docs.length,
        );
      },
    );
  }

  Widget _totals(BuildContext buildContext) {
    // Create a streambuilder for the current scorecard
    return StreamBuilder<DocumentSnapshot>(
      stream: FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser.uid)
          .collection('scorecards')
          .doc(widget._scorecard_id)
          .snapshots(),
      builder: (context, snapshot) {
        // If the connection is still going then return a progress indicator
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container(
            color: Theme.of(buildContext).primaryColor,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        // If the data is null then something is wrong with the connection
        if (snapshot.data == null) {
          return Container(
            color: Theme.of(buildContext).primaryColor,
            child: Center(
              child: Text('There are no players for this scorecard!',
                  style: TextStyle(color: Colors.red)),
            ),
          );
        }

        // Else grab the players array and display the players with their scores
        // and colors for the total scores
        var players = snapshot.data['players'];
        return Container(
          color: Theme.of(buildContext).primaryColor,
          padding: const EdgeInsets.all(8.0),
          height: 105,
          width: double.infinity,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return PlayerScore(
                Text('${players[index]['name']}'),
                Text('${players[index]['total_score']}'),
                ColorPicker.getColorFromString(players[index]['color']),
              );
            },
            itemCount: players.length,
            separatorBuilder: (context, index) => const VerticalDivider(
              color: Color.fromRGBO(0, 0, 0, 0),
              width: 30,
            ),
          ),
        );
      },
    );
  }
}
