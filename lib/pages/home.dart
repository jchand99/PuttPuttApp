import 'package:flutter/material.dart';
import 'package:puttputtapp/pages/scorecard.dart';
import 'package:puttputtapp/pages/create_edit_scorecard.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: _fab(context),
        //backgroundColor: Colors.grey[200],
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            'Manage Scorecards',
          ),
        ),
        body: _buildColumn(context));
  }
}

Widget _buildColumn(BuildContext context) {
  return Column(children: <Widget>[
    Align(
        alignment: Alignment.topLeft,
        child: Container(
            padding: EdgeInsets.all(20),
            child: Text(
              'My Scorecards',
              textAlign: TextAlign.left,
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ))),
    Expanded(child: _listView(context)),
    //_listView(context),
  ]);
}

ListView _listView(BuildContext context) {
  return ListView.separated(
      padding: const EdgeInsets.all(8),
      itemBuilder: (BuildContext context, int index) {
        return ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(32),
              bottomLeft: Radius.circular(32),
            ),
            child: ListTile(
                //contentPadding: EdgeInsets.all(0),
                trailing: Icon(Icons.arrow_forward_ios),
                tileColor: Colors.white,
                title: Center(child: Text('Scorecard $index')),
                onTap: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) =>
                        ScorecardPage("My Putt Putt Place")))));
      },
      separatorBuilder: (BuildContext context, int index) => const Divider(),
      itemCount: 5);
}

FloatingActionButton _fab(BuildContext context) {
  return FloatingActionButton(
    child: Icon(Icons.add, color: Colors.white),
    onPressed: () => Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => CreateEditScorecardPage())),
  );
}
