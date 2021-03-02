import 'package:flutter/material.dart';

class ScorecardPage extends StatefulWidget {
  final String scoreCard;
  const ScorecardPage(this.scoreCard);

  @override
  _ScorecardPageState createState() => _ScorecardPageState();
}

class _ScorecardPageState extends State<ScorecardPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.scoreCard),
      ),
      body: _body(context),
    );
  }

  Widget _body(BuildContext context) {
    return ListView.separated(
      itemCount: 4,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text('Hole $index'),
        );
      },
      separatorBuilder: (context, index) => const Divider(
        color: Colors.white,
      ),
    );
  }
}
