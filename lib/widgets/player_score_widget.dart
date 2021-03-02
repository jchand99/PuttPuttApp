import 'package:flutter/material.dart';

class PlayerScore extends StatefulWidget {
  PlayerScore(this._playerName, this._totalScore, this._color, {Key key})
      : super(key: key);

  final Text _playerName;
  final int _totalScore;
  final Color _color;

  @override
  _PlayerScoreState createState() => _PlayerScoreState();
}

class _PlayerScoreState extends State<PlayerScore> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: widget._color, width: 3)),
            child: Center(
              child: Text(
                '${widget._totalScore}',
                style: TextStyle(fontSize: 25, color: Colors.white),
              ),
            ),
          ),
          Text(
            widget._playerName.data,
            style: TextStyle(color: Colors.white),
          )
        ],
      ),
    );
  }
}
