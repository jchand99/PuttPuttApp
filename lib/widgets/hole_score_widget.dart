import 'package:flutter/material.dart';

class HoleScore extends StatefulWidget {
  HoleScore(this._player, {Key key}) : super(key: key);

  final Text _player;
  @override
  _HoleScoreState createState() => _HoleScoreState();
}

class _HoleScoreState extends State<HoleScore> {
  List<Color> colors = [
    Colors.black,
    Colors.black,
    Colors.black,
    Colors.black,
    Colors.black,
    Colors.black,
    Colors.black
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 80,
      child: Card(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        child: Column(
          children: [
            Text(widget._player.data, style: TextStyle(fontSize: 20)),
            Container(
                //margin: EdgeInsets.only(bottom: 10.0, left: 5),
                child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: () {
                    setState(() {
                      colors.fillRange(0, 7, Colors.black);
                      colors[0] = Colors.red;
                    });
                  },
                  splashColor: Colors.amber,
                  child: Container(
                    padding: EdgeInsets.all(5),
                    margin: EdgeInsets.only(right: 5),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: colors[0], width: 1.5)),
                    child: Text(
                      '1',
                      style: TextStyle(color: colors[0]),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      colors.fillRange(0, 7, Colors.black);
                      colors[1] = Colors.red;
                    });
                  },
                  splashColor: Colors.amber,
                  child: Container(
                    padding: EdgeInsets.all(5),
                    margin: EdgeInsets.only(right: 5),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: colors[1], width: 1.5)),
                    child: Text(
                      '2',
                      style: TextStyle(color: colors[1]),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      colors.fillRange(0, 7, Colors.black);
                      colors[2] = Colors.red;
                    });
                  },
                  splashColor: Colors.amber,
                  child: Container(
                    padding: EdgeInsets.all(5),
                    margin: EdgeInsets.only(right: 5),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: colors[2], width: 1.5)),
                    child: Text(
                      '3',
                      style: TextStyle(color: colors[2]),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      colors.fillRange(0, 7, Colors.black);
                      colors[3] = Colors.red;
                    });
                  },
                  splashColor: Colors.amber,
                  child: Container(
                    padding: EdgeInsets.all(5),
                    margin: EdgeInsets.only(right: 5),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: colors[3], width: 1.5)),
                    child: Text(
                      '4',
                      style: TextStyle(color: colors[3]),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      colors.fillRange(0, 7, Colors.black);
                      colors[4] = Colors.red;
                    });
                  },
                  splashColor: Colors.amber,
                  child: Container(
                    padding: EdgeInsets.all(5),
                    margin: EdgeInsets.only(right: 5),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: colors[4], width: 1.5)),
                    child: Text(
                      '5',
                      style: TextStyle(color: colors[4]),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      colors.fillRange(0, 7, Colors.black);
                      colors[5] = Colors.red;
                    });
                  },
                  splashColor: Colors.amber,
                  child: Container(
                    padding: EdgeInsets.all(5),
                    margin: EdgeInsets.only(right: 5),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: colors[5], width: 1.5)),
                    child: Text(
                      '6',
                      style: TextStyle(color: colors[5]),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      colors.fillRange(0, 7, Colors.black);
                      colors[6] = Colors.red;
                    });
                  },
                  splashColor: Colors.amber,
                  child: Container(
                    width: 25,
                    padding: EdgeInsets.all(6),
                    margin: EdgeInsets.only(right: 5),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: colors[6], width: 1.5)),
                    child: Center(
                      child: TextField(
                        onTap: () {
                          setState(() {
                            colors.fillRange(0, 7, Colors.black);
                            colors[6] = Colors.red;
                          });
                        },
                        decoration: InputDecoration(border: InputBorder.none),
                        style: TextStyle(color: Colors.red),
                        keyboardType: TextInputType.number,
                      ),
                    ),
                  ),
                ),
              ],
            )),
          ],
        ),
      ),
    );
  }
}
