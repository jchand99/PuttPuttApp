import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:puttputtapp/pages/create_edit_scorecard.dart';
import 'package:puttputtapp/pages/scorecard.dart';
import 'package:puttputtapp/util/nav.dart';
import 'package:share/share.dart';

import 'login.dart';

class HomePage extends StatefulWidget {
  HomePage(this._firebaseUser, {Key key}) : super(key: key);

  final User _firebaseUser;
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isEditMode = false;
  String _id;

  void _removeCard(BuildContext context, String name, String scorecardId) {
    showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
              title: Text("Delete Scorecard"),
              content: Text("Do you want to delete \"$name\""),
              actions: <Widget>[
                TextButton(
                  child: Text("No"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  child: Text("Yes"),
                  onPressed: () {
                    Navigator.of(context).pop();
                    FirebaseFirestore.instance
                        .collection('users')
                        .doc(widget._firebaseUser.uid)
                        .collection('scorecards')
                        .doc(scorecardId)
                        .delete();
                  },
                )
              ]);
        });
  }

  void _createScoreCard(BuildContext context) async {
    // Grab the document containing the scorecard count
    var doc = await FirebaseFirestore.instance
        .collection('users')
        .doc(widget._firebaseUser.uid)
        .get();
    var count = doc['scorecard_count'];
    // Create an id for the scorecard to be created as
    _id = 'scorecard_$count';

    // Push to the CreateEditScorecardPage widget
    Nav.push(
        context,
        CreateEditScorecardPage(
          'Create Scorecard',
          widget._firebaseUser,
          _id,
          editMode: false,
        ));
  }

  void _editScoreCards() {
    setState(() {
      isEditMode = true;
    });
  }

  void _editingDone() {
    setState(() {
      isEditMode = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> actList = [
      !isEditMode
          ? TextButton(
              child: Text('Edit', style: TextStyle(color: Colors.white)),
              onPressed: _editScoreCards,
            )
          : TextButton(
              child: Text('Done', style: TextStyle(color: Colors.white)),
              onPressed: _editingDone,
            )
    ];
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              child: Text('Menu'),
            ),
            ListTile(
              leading: Icon(Icons.share_outlined),
              title: Text('Share'),
              onTap: () async {
                final RenderBox box = context.findRenderObject() as RenderBox;
                final String url =
                    'https://play.google.com/store/apps/details?id=com.vcu.puttputtpalooza';
                await Share.share(url,
                    sharePositionOrigin:
                        box.localToGlobal(Offset.zero) & box.size);
              },
            ),
            ListTile(
              leading: Icon(Icons.login_outlined),
              title: Text('Logout'),
              onTap: () {
                FirebaseAuth.instance.signOut();
                Nav.pushAndReplace(context, LoginPage());
              },
            )
          ],
        ),
      ),
      appBar: AppBar(
        title: Center(
          child: Text('Scorecards'),
        ),
        actions: actList,
      ),
      body: _body(context),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _createScoreCard(context),
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _body(BuildContext context) {
    // Create a streambuilder for the list of scorecards
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('users')
          .doc(widget._firebaseUser.uid)
          .collection('scorecards')
          .snapshots(),
      builder: (context, snapshot) {
        // If the connection is still ongoing then return a progress indicator
        if (snapshot.connectionState == ConnectionState.waiting)
          return Center(child: CircularProgressIndicator());

        // if the snapshot data is null then something is wrong with the connection
        if (snapshot.data == null)
          return Center(
              child: Text('Something is wrong with the internet connection!'));

        // If the number of scorecards that exist in the database is 0
        // then display the help text
        if (snapshot.data.docs.length == 0)
          return Center(
            child: Text(
                'Hello ${widget._firebaseUser.email}.\n\n Press the add button in the bottom right corner to add a Scorecard'),
          );

        // Else return the listview of all the scorecards
        return ListView.separated(
          padding: const EdgeInsets.all(16),
          itemCount: snapshot.data.docs.length,
          separatorBuilder: (context, index) => Divider(
            color: Colors.white,
          ),
          itemBuilder: (context, index) {
            var data = snapshot.data.docs[index];

            return Card(
              elevation: 2,
              child: ListTile(
                title: Text(data['name']),
                trailing: Icon(Icons.arrow_forward_ios_rounded),
                leading: isEditMode
                    ? IconButton(
                        icon: Icon(Icons.highlight_remove_outlined,
                            color: Colors.red),
                        onPressed: () => _removeCard(
                            context, data['name'], data.id),
                      )
                    : null,
                onTap: () => Nav.push(
                    context,
                    ScorecardPage(
                        data['name'], 'scorecard_$index', data['par_enabled'])),
              ),
            );
          },
        );
      },
    );
  }
}
