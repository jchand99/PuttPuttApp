import 'package:flutter/material.dart';
import 'package:puttputtapp/pages/scorecard.dart';
import 'package:puttputtapp/util/nav.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List _cards = [];
  bool removeCards = false;
  int _scoreCardAmt = 0;

  void _removeCard(int index) {
    setState(() {
      _cards.removeAt(index);
      _scoreCardAmt--;
    });
  }

  void _addCard() {
    setState(() {
      _scoreCardAmt++;
      _cards.add({'cardName': "ScoreCard $_scoreCardAmt"});
    });
  }

  void _editScoreCards() {
    setState(() {
      removeCards = true;
    });
  }

  void _editingDone() {
    setState(() {
      removeCards = false;
    });
  }

  List getActList() {
    List<Widget> actList = [];
    if (removeCards) {
      actList = [
        IconButton(
          constraints: BoxConstraints.expand(width: 49),
          icon: Text('Done'),
          onPressed: _editingDone,
        )
      ];
    } else {
      actList = [
        IconButton(
          icon: Text('Edit'),
          onPressed: _editScoreCards,
        )
      ];
    }
    return actList;
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> actList = getActList();
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {},
        ),
        title: Center(
          child: Text('Scorecards'),
        ),
        actions: actList,
      ),
      body: _body(context),
      floatingActionButton: FloatingActionButton(
        onPressed: _addCard,
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _body(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: _cards.length,
      itemBuilder: (context, index) {
        return _buildScoreCard(context, index);
      },
      separatorBuilder: (context, index) => Divider(
        color: Colors.white,
      ),
    );
  }

  Widget _buildScoreCard(BuildContext context, index) {
    if (removeCards == false) {
      return Card(
        elevation: 10,
        child: ListTile(
          title: Text(_cards[index]['cardName']),
          trailing: Icon(Icons.arrow_forward_ios_rounded),
          onTap: () =>
              Nav.push(context, ScorecardPage(_cards[index]['cardName'])),
        ),
      );
    } else {
      return Card(
          elevation: 10,
          child: ListTile(
            title: Text(_cards[index]['cardName']),
            leading: IconButton(
                icon: Icon(Icons.highlight_remove_outlined),
                onPressed: () {
                  _removeCard(index);
                }),
          ));
    }
  }
}
