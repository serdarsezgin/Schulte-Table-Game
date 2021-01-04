import 'dart:async';

import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: MyGame(),
  ));
}

class MyGame extends StatefulWidget {
  @override
  _MyGameState createState() => _MyGameState();
}

class _MyGameState extends State<MyGame> {
  Color cellColor = Colors.grey;

  Text _getText(index) {
    Text text;
    text = Text('$index');

    return text;
  }

  void reset() {
    controller = 0;

    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        transitionDuration: Duration.zero,
        pageBuilder: (_, __, ___) => MyGame(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("FlutterGameAlpha"),
      ),
      body: Container(
        margin: EdgeInsets.only(top: 30),
        child: Column(
          children: [
            Expanded(
              child: GridView.count(
                crossAxisCount: 5,
                children: List.generate(25, (index) {
                  return MyTable(
                    index: index,
                    color: cellColor,
                    text: _getText(index + 1),
                  );
                })
                  ..shuffle(),
              ),
            ),
            Visibility(visible: bitirici, child: Text("Score:..$time")),
            Visibility(
                visible: bitirici, child: Text("Best Score:..$besttime")),
            Visibility(
                visible: true,
                child: RaisedButton(
                  onPressed: reset,
                  child: Text('Show Score'),
                )),
          ],
        ),
      ),
    );
  }
}

class MyTable extends StatefulWidget {
  final Color color;
  final Text text;
  final int index;

  MyTable({this.color, this.text, this.index});

  @override
  _MyWidgetState createState() => _MyWidgetState();
}

bool isVisible = false;
int controller = 0;
int time = 0;

bool bitirici = false;
int besttime = 999;

class _MyWidgetState extends State<MyTable> {
  Color cellColor = Colors.blueAccent;
  Text cellText = Text('white');

  BorderRadiusGeometry _borderRadius = BorderRadius.circular(3);

  Timer timer;

  startTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (t) {
      setState(() {
        time = time + 1;
      });
    });
  }

  cancelTimer() {
    return timer.cancel();
  }

  setBest() {
    setState(() {
      if (time < besttime) {
        besttime = time + 1;
      }
    });
  }

  @override
  void initState() {
    super.initState();
    cellColor = widget.color;
    cellText = widget.text;
  }

  _changeCell(index) {
    setState(() {
      if (index == controller) {
        cellColor = Colors.green;
        controller++;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (controller == 0) {
          time = 0;
          startTimer();
        }
        setState(() {
          _changeCell(widget.index);

          if (controller == 25) {
            setBest();
            bitirici = true;

            cancelTimer();
          }
        });
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 1.0),
        decoration: BoxDecoration(
          border: Border.all(width: 1, color: Colors.indigo),
          borderRadius: _borderRadius,
          color: cellColor,
        ),
        child: Center(
          child: cellText,
        ),
      ),
    );
  }
}
