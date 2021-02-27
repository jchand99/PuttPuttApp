import 'package:flutter/material.dart';
import 'package:puttputtapp/pages/scorecard.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("PuttPutt"),
      ),
      body: _body(context),
    );
  }

  Column _body(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTitle(context),
        Expanded(
          child: _buildListView(context),
        ),
      ],
    );
  }

  Padding _buildTitle(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        'Scorecards',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 40,
        ),
      ),
    );
  }

  ListView _buildListView(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.all(8.0),
      itemCount: 5,
      itemBuilder: (context, index) {
        return Container(
          color: Colors.blue[200],
          child: ListTile(
            title: Text('Scorecard $index'),
            trailing: Icon(Icons.arrow_forward_ios_rounded),
            onTap: () => Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => ScorecardPage())),
          ),
        );
      },
      separatorBuilder: (context, index) => const Divider(
        color: Colors.white,
      ),
    );
  }
}
