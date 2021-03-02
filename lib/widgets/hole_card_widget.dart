import 'package:flutter/material.dart';
import 'package:puttputtapp/util/nav.dart';
import 'package:puttputtapp/pages/hole.dart';

class HoleCard extends StatefulWidget {
  HoleCard(this._holeNumber, this._players, this._scores, {this.par, Key key})
      : super(key: key);

  final int _holeNumber;
  final int par;
  final List<Text> _players;
  final List<Text> _scores;

  @override
  _HoleCardState createState() => _HoleCardState();
}

class _HoleCardState extends State<HoleCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () => Nav.push(context, HolePage()),
        splashColor: Theme.of(context).accentColor,
        child: Container(
          padding: const EdgeInsets.all(8.0),
          child: IntrinsicHeight(
            child: Row(
              children: [
                _leftIconAndPar(context),
                VerticalDivider(
                  color: Colors.black,
                  thickness: 1,
                ),
                Expanded(child: _listOfPlayerNames(context)),
                _listOfPlayerScores(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _leftIconAndPar(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.only(left: 16.0, right: 16.0),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Colors.black, width: 3),
          ),
          child: Column(
            children: [
              Text(
                '${widget._holeNumber}',
                style: TextStyle(fontSize: 25),
              ),
              Icon(Icons.flag_outlined),
            ],
          ),
        ),
        widget.par != 0 && widget.par != null
            ? Text(
                'Par: ${widget.par}',
                style: TextStyle(fontSize: 15),
              )
            : SizedBox(width: 0.0, height: 0.0),
      ],
    );
  }

  Widget _listOfPlayerNames(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: widget._players,
      ),
    );
  }

  Widget _listOfPlayerScores(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: widget._scores,
      ),
    );
  }
}
