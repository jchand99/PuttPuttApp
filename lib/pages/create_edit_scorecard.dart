import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:puttputtapp/pages/color_select.dart';
import 'package:puttputtapp/pages/home.dart';
import 'package:puttputtapp/pages/scorecard.dart';
import 'package:puttputtapp/pages/create_edit_scorecard.dart';
import 'package:puttputtapp/util/color_picker.dart';
import 'dart:math';
import 'package:puttputtapp/util/nav.dart';
import 'package:intl/intl.dart';

class CreateEditScorecardPage extends StatefulWidget {
  CreateEditScorecardPage(this._title, this._firebaseUser, this._id,
      {Key key, this.editMode})
      : super(key: key);

  final String _title;
  final User _firebaseUser;
  final String _id;
  final bool editMode;

  @override
  _CreateEditScorecardPageState createState() =>
      _CreateEditScorecardPageState();
}

class _CreateEditScorecardPageState extends State<CreateEditScorecardPage> {
  bool par = false;

  String _scorecardName =
      'Golf Game ' + DateFormat('MM/dd/yy').format(DateTime.now());

  List _players = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (_players.length < 1) {
      _createPlayer(context);
    }
    return !widget.editMode
        ? _buildNonEditMode(context)
        : _buildEditMode(context);
  }

  Widget _buildNonEditMode(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            child: Text("Save", style: TextStyle(color: Colors.white)),
            onPressed: () => onSave(),
          )
        ],
        title: Center(
          child: Text('${widget._title} Scorecard'),
        ),
      ),
      body: _buildScrollPage(context),
      floatingActionButton: FloatingActionButton(
        onPressed: () => onSave(),
        child: const Icon(Icons.check),
      ),
    );
  }

  Widget _buildEditMode(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            child: Text("Save", style: TextStyle(color: Colors.white)),
            onPressed: () => onSave(),
          )
        ],
        title: Center(
          child: Text('${widget._title} Scorecard'),
        ),
      ),
      body: _buildEditScrollPage(context),
    );
  }

  // TODO: Make it so they can actually make changes!
  // and generally just clean up this class somehow
  Widget _buildEditScrollPage(BuildContext context) {
    // Create streambuilder for specific scorecard
    return StreamBuilder<DocumentSnapshot>(
      stream: FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser.uid)
          .collection('scorecards')
          .doc(widget._id)
          .snapshots(),
      builder: (context, snapshot) {
        // If connection is still connecting, display circular indicator
        if (snapshot.connectionState == ConnectionState.waiting)
          return Center(child: CircularProgressIndicator());
        // if the snapshots data is null then something went wrong
        if (snapshot.data == null)
          return Center(
              child: Text(
                  'There must be an issue with your internet connection!'));

        _players = snapshot.data['players'];

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
              child: _buildUpperButtonLayoutEDIT(context, snapshot.data)),
          Expanded(child: _buildPlayerListEDIT(context, snapshot.data)),
        ]);
      },
    );
  }

  Widget _buildPlayerListEDIT(BuildContext context, data) {
    return Container(
      child: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: data['players'].length,
        itemBuilder: (context, index) {
          return Card(
              elevation: 10,
              child: ListTile(
                title: Container(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: TextField(
                    onChanged: (value) {
                      setState(() {
                        data['players'][index]['name'] = value;
                      });
                    },
                    style: TextStyle(
                      fontSize: 18,
                    ),
                    decoration: InputDecoration(
                        filled: false,
                        labelText: data['players'][index]['name']),
                  ),
                ),
                leading: _ballColorEDIT(context, index, data),
                trailing: data['players'].length != 1
                    ? IconButton(
                        icon: Icon(Icons.highlight_remove_outlined),
                        onPressed: () {
                          _removeCard(index);

                          FirebaseFirestore.instance
                              .collection('users')
                              .doc(FirebaseAuth.instance.currentUser.uid)
                              .collection('scorecards')
                              .doc(widget._id)
                              .update({'players': _players});
                        })
                    : SizedBox(
                        width: 0,
                        height: 0,
                      ),
              ));
        },
        separatorBuilder: (context, index) => Divider(
          color: Color.fromRGBO(0, 0, 0, 0),
        ),
      ),
    );
  }

  Widget _ballColorEDIT(BuildContext context, int index, data) {
    return Stack(alignment: AlignmentDirectional.center, children: <Widget>[
      Icon(
        Icons.circle,
        size: 32,
        color: ColorPicker.getColorFromString(data['players'][index]['color']),
      ),
      IconButton(
        icon: Icon(Icons.edit, color: Colors.black, size: 22),
        onPressed: () => Nav.pushFullScreenDialog(
            context,
            ColorSelectPage(
              data['players'][index]['name'],
              widget._id,
              onChanged: (value) {
                setState(() {
                  _players[index]['color'] = value;
                  data['players'][index]['color'] = value;

                  FirebaseFirestore.instance
                      .collection('users')
                      .doc(FirebaseAuth.instance.currentUser.uid)
                      .collection('scorecards')
                      .doc(widget._id)
                      .update({'players': _players});
                });
              },
            )),
      ),
    ]);
  }

  Widget _buildUpperButtonLayoutEDIT(BuildContext context, data) {
    return Column(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.all(12.0),
          child: TextField(
              onChanged: (value) {
                setState(() {
                  _scorecardName = value;
                });
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: data['name'],
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
          // child: SwitchListTile(
          //   title: const Text('Par', style: TextStyle(fontSize: 16)),
          //   value: data['par_enabled'],
          //   onChanged: (bool value) {
          //     setState(() {
          //       // TODO: Possible delete?
          //       par = value;
          //       FirebaseFirestore.instance
          //           .collection('users')
          //           .doc(FirebaseAuth.instance.currentUser.uid)
          //           .collection('scorecards')
          //           .doc(widget._id)
          //           .update({'par_enabled': value});
          //     });
          //   },
          //   secondary: !data['par_enabled']
          //       ? const Icon(Icons.flag_outlined)
          //       : const Icon(Icons.flag_rounded),
          // ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                        _createPlayer(context);

                        FirebaseFirestore.instance
                            .collection('users')
                            .doc(FirebaseAuth.instance.currentUser.uid)
                            .collection('scorecards')
                            .doc(widget._id)
                            .update({'players': _players});
                      },
                      child: Text("+", style: TextStyle(fontSize: 16))),
                  alignment: Alignment.centerRight),
            ))
          ],
        )
      ],
    );
  }

  Widget _buildScrollPage(BuildContext context) {
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
          child: _buildUpperButtonLayout(context)),
      Expanded(child: _buildPlayerList(context)),
    ]);
  }

  Widget _buildUpperButtonLayout(BuildContext context) {
    var now = new DateTime.now();
    var formatter = new DateFormat('MM/dd/yy');
    String formattedDate = formatter.format(now);
    return Column(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.all(12.0),
          child: TextFormField(
              initialValue: 'Golf Game ' + formattedDate,
              onChanged: (value) {
                setState(() {
                  _scorecardName = value;
                });
              },
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
          // child: SwitchListTile(
          //   title: const Text('Par', style: TextStyle(fontSize: 16)),
          //   value: par,
          //   onChanged: (bool value) {
          //     setState(() {
          //       par = value;
          //     });
          //   },
          //   secondary: !par
          //       ? const Icon(Icons.flag_outlined)
          //       : const Icon(Icons.flag_rounded),
          // ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                        _createPlayer(context);
                      },
                      child: Text("+", style: TextStyle(fontSize: 16))),
                  alignment: Alignment.centerRight),
            ))
          ],
        )
      ],
    );
  }

  Widget _buildPlayerList(BuildContext context) {
    return Container(
      child: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: _players.length,
        itemBuilder: (context, index) {
          return _buildPlayerCard(context, index);
        },
        separatorBuilder: (context, index) => Divider(
          color: Color.fromRGBO(0, 0, 0, 0),
        ),
      ),
    );
  }

  Widget _buildPlayerCard(BuildContext context, int index) {
    return Card(
        elevation: 10,
        child: ListTile(
          title: //Text(_names[index]['player']),
              Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Container(
              //height: 4,
              child: TextField(
                onChanged: (value) {
                  setState(() {
                    _players[index]['name'] = value;
                  });
                },
                style: TextStyle(
                  fontSize: 18,
                ),
                decoration: InputDecoration(
                    filled: false, labelText: 'Player ${index + 1}'),
              ),
            ),
          ),
          leading: _ballColor(context, index),
          trailing: _players.length != 1
              ? IconButton(
                  icon: Icon(Icons.highlight_remove_outlined),
                  onPressed: () {
                    _removeCard(index);
                  })
              : SizedBox(
                  width: 0,
                  height: 0,
                ),
        ));
  }

  Widget _ballColor(BuildContext context, int index) {
    return Stack(alignment: AlignmentDirectional.center, children: <Widget>[
      Icon(
        Icons.circle,
        size: 32,
        color: ColorPicker.getColorFromString(_players[index]['color']),
      ),
      IconButton(
        icon: Icon(Icons.edit, color: Colors.black, size: 22),
        onPressed: () => Nav.pushFullScreenDialog(
            context,
            ColorSelectPage(
              _players[index]['name'],
              widget._id,
              onChanged: (value) {
                setState(() {
                  _players[index]['color'] = value;
                });
              },
            )),
      ),
    ]);
  }

  onSave() async {
    if (!widget.editMode) {
      // Set the data on save button clicked
      // The data is sent to the database with the current scorecard id as
      // a json object
      FirebaseFirestore.instance
          .collection('users')
          .doc(widget._firebaseUser.uid)
          .collection('scorecards')
          .doc(widget._id)
          .set({
        'players': _players, // TODO: Array of player objects
        'par_enabled': par,
        'hole_count': 0,
        'name': _scorecardName,
      });

      // Grab the document that contains the scorecard count for this user
      var scorecardCountDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(widget._firebaseUser.uid)
          .get();

      // Get the scorecard count
      var count = scorecardCountDoc['scorecard_count'];

      // Increment the score by 1 (because they just made a new one)
      // and then update the value in the database
      FirebaseFirestore.instance
          .collection('users')
          .doc(widget._firebaseUser.uid)
          .update({'scorecard_count': count + 1});

      // Pop the page
      Nav.pop(context);
    } else {
      // EDIT MODE DETAILS
      // TODO: Push all chanegs to the database
    }
  }

  void _removeCard(int index) {
    if (_players.length > 1) {
      setState(() {
        _players.removeAt(index);
      });
    } else {
      print("Must have at least one player!");
    }
  }

  void _createPlayer(BuildContext context) {
    setState(() {
      _players.add({'name': '', 'color': '', 'total_score': 0});
    });
  }
}
