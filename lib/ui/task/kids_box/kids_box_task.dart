import 'dart:async';

import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class KidsBox extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return KidsBoxState();
  }
}

class KidsBoxState extends State<KidsBox> {
  int _start = 60;

  AudioPlayer audioPlayer;
  List<String> options = ['Well', 'Badly', 'Quickly'];
  static GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  Widget HeaderTiles(String value) {
    return Container(
      height: 55,
      width: 145,
      child: Center(
        child: Text(
          value,
          style: TextStyle(color: Colors.black),
        ),
      ),
      color: Colors.white,
    );
  }

  Widget progressDetails() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        Container(
          height: 100 * (MediaQuery.of(context).size.height / 720.0),
          width: 60 * (MediaQuery.of(context).size.width / 360.0),
          alignment: FractionalOffset.center,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: new BorderRadius.all(const Radius.circular(29.5)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              GestureDetector(
                child: Icon(Icons.arrow_back_ios),
                onTap: () {
                  Dialog dialog = Dialog(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0)),
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: new LinearGradient(
                            colors: <Color>[
                              Color.fromRGBO(0, 193, 134, 1),
                              Color.fromRGBO(128, 109, 222, 1)
                            ],
                            begin: FractionalOffset.topLeft,
                            end: FractionalOffset.bottomRight),
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      height:
                          180.0 * (MediaQuery.of(context).size.height / 740.0),
                      width:
                          170.0 * (MediaQuery.of(context).size.width / 360.0),
                      child: Stack(
                        children: <Widget>[
                          Positioned(
                            top: 19,
                            left: 15,
                            child: Text(
                              'Close',
                              style: TextStyle(
                                  color: Colors.white.withOpacity(0.25),
                                  fontSize: 78),
                            ),
                          ),
                          Positioned(
                            top: 90 *
                                (MediaQuery.of(context).size.height / 740.0),
                            left: 20 *
                                (MediaQuery.of(context).size.width / 360.0),
                            right: 54 *
                                (MediaQuery.of(context).size.width / 360.0),
                            child: Text(
                              'are you sure you want to exit?',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 14),
                            ),
                          ),
                          Positioned(
                              top: 45 *
                                  (MediaQuery.of(context).size.height / 740.0),
                              left: 125 *
                                  (MediaQuery.of(context).size.width / 360.0),
                              child: FlatButton(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(23.0)),
                                child: Text(
                                  'Yes',
                                  style: TextStyle(color: Colors.white),
                                ),
                                onPressed: () {
                                  Navigator.pop(context);
                                  Navigator.pop(context);
                                },
                              )),
                          Positioned(
                              top: 95 *
                                  (MediaQuery.of(context).size.height / 740.0),
                              left: 125 *
                                  (MediaQuery.of(context).size.width / 360.0),
                              child: FlatButton(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(23.0)),
                                child: Text(
                                  'No',
                                  style: TextStyle(color: Colors.white),
                                ),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ))
                        ],
                      ),
                    ),
                  );
                  showDialog(
                      context: context,
                      builder: (BuildContext context) => dialog);
                },
              ),
              GestureDetector(
                child: Text('Hint'),
                onTap: () {
                  Dialog d = new Dialog(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0)),
                    backgroundColor: Colors.amberAccent.withOpacity(0.5),
                    child: Container(
                        height: 300,
                        width: 200,
                        child: Center(
                          child: Text(
                            'Hints',
                            style: TextStyle(color: Colors.white),
                          ),
                        )),
                  );
                  showDialog(
                      context: context, builder: (BuildContext context) => d);
                },
              )
            ],
          ),
        ),
        SizedBox(
          width: 30 * (MediaQuery.of(context).size.width / 360.0),
        ),
      ],
    );
  }

  void CorrectAnswer() {
    successAudio();
    Dialog dialog = new Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
      backgroundColor: Color.fromRGBO(83, 195, 111, 1),
      child: Container(
          width: MediaQuery.of(context).size.width * .50,
          height: MediaQuery.of(context).size.height * .30,
          child: Stack(
            children: <Widget>[
              Positioned(
                top: 20,
                left: 20,
                child: Text(
                  "Explaination Slot",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              Positioned(
                top: MediaQuery.of(context).size.height * 0.10,
                left: MediaQuery.of(context).size.width * 0.40,
                child: FlatButton(
                  child: Text(
                    'Got It',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ],
          )),
    );
    showDialog(context: context, builder: (BuildContext context) => dialog);
  }

  void WrongAnswer() {
    errorAudio();
    Dialog dialog = new Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
      backgroundColor: Color.fromRGBO(255, 131, 131, 1),
      child: Container(
          width: MediaQuery.of(context).size.width * .50,
          height: MediaQuery.of(context).size.height * .30,
          child: Stack(
            children: <Widget>[
              Positioned(
                top: 20,
                left: 20,
                child: Text(
                  "Explaination Slot",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              Positioned(
                top: MediaQuery.of(context).size.height * 0.10,
                left: MediaQuery.of(context).size.width * 0.40,
                child: FlatButton(
                  child: Text(
                    'Got It',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ],
          )),
    );
    showDialog(context: context, builder: (BuildContext context) => dialog);
  }

  Future successAudio() async {
    audioPlayer = await AudioCache().play("audios/success.mp3");
  }

  Future errorAudio() async {
    audioPlayer = await AudioCache().play("audios/error.mp3");
  }

  List<Widget> generateTableRow(List<int> color, List<String> targets) {
    List<Widget> widgets = new List<Widget>();
    for (int i = 0; i < 3; i++) {
      bool accepted = false;
      String correct;
      if (color[i] == 0) {
        widgets.add(Positioned(
          child: Container(
              decoration: new BoxDecoration(
                border: new Border.all(color: Colors.grey.withOpacity(0.25)),
                color: Colors.grey,
              ),
              height: 55,
              width: 145),
          left: (145 * i).toDouble(),
        ));
      } else {
        widgets.add(Positioned(
          child: DragTarget(
            builder: (context, List<String> candidateData, rejectedData) {
              return accepted
                  ? Container(
                      decoration: new BoxDecoration(
                        border: new Border.all(
                            color: Colors.grey.withOpacity(0.25)),
                        color: Color.fromRGBO(83, 195, 111, 1),
                      ),
                      height: 55,
                      width: 145,
                      child: Center(
                        child: Text(
                          correct,
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    )
                  : Container(
                      decoration: new BoxDecoration(
                        border: new Border.all(
                            color: Colors.grey.withOpacity(0.25)),
                        color: Colors.white,
                      ),
                      height: 55,
                      width: 145);
            },
            onWillAccept: (data) {
              return !accepted;
            },
            onAccept: (data) {
              if (targets[i] == data) {
                CorrectAnswer();
                correct = data;
                accepted = true;
              } else {
                WrongAnswer();
              }
            },
          ),
          left: (145 * i).toDouble(),
        ));
      }
    }

    return widgets;
  }

  List<Widget> generateOptions() {
    List<Widget> widgets = new List<Widget>();

    for (int i = 0; i < 3; i++) {
      Container container = new Container(
          decoration: new BoxDecoration(
              border: new Border.all(color: Colors.grey.withOpacity(0.25)),
              color: Colors.white),
          height: 55,
          width: 145,
          child: Center(
            child: Text(
              options[i],
              style: TextStyle(color: Colors.black),
            ),
          ));
      widgets.add(Positioned(
        child: Draggable(
          child: container,
          feedback: Container(
              width: 145,
              height: 55,
              child: RaisedButton(
                  onPressed: () {},
                  child: Text(
                    options[i],
                    style: TextStyle(
                      fontSize: 15, /*color: Color(0x2E303E)*/
                    ),
                    textAlign: TextAlign.center,
                  ),
                  //textColor: Colors.white,
                  //highlightColor: Colors.red,
                  color: Colors.white,
                  elevation: 0
                  //highlightElevation: 0.5,
                  )),
          childWhenDragging: Container(),
          data: options[i],
        ),
        left: (145 * i).toDouble(),
      ));
    }

    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        backgroundColor: Color.fromRGBO(247, 248, 249, 1),
        body: Center(
          child: Stack(
            children: <Widget>[
              Positioned(
                top: 40,
                left: 20,
                child: progressDetails(),
              ),
              Positioned(
                top: 115,
                left: 65,
                child: HeaderTiles('Spondon'),
              ),
              Positioned(
                top: 170,
                left: 65,
                child: HeaderTiles('Imtiaz'),
              ),
              Positioned(
                top: 225,
                left: 65,
                child: HeaderTiles('Tusar'),
              ),
              Positioned(
                top: 60,
                left: 210,
                child: HeaderTiles('Play'),
              ),
              Positioned(
                top: 60,
                left: 355,
                child: HeaderTiles('Sing'),
              ),
              Positioned(
                top: 60,
                left: 500,
                child: HeaderTiles('Dance'),
              ),
              Positioned(
                top: 115,
                left: 210,
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                      maxHeight: 55, maxWidth: 145 * 3.toDouble()),
                  child: Stack(
                    children:
                        generateTableRow([1, 0, 1], ['Badly', '', 'Quickly']),
                  ),
                ),
              ),
              Positioned(
                top: 170,
                left: 210,
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                      maxHeight: 55, maxWidth: 145 * 3.toDouble()),
                  child: Stack(
                    children:
                        generateTableRow([0, 1, 1], ['', 'Quickly', 'Well']),
                  ),
                ),
              ),
              Positioned(
                top: 225,
                left: 210,
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                      maxHeight: 55, maxWidth: 145 * 3.toDouble()),
                  child: Stack(
                    children:
                        generateTableRow([1, 1, 0], ['Badly', 'Well', '']),
                  ),
                ),
              ),
              Positioned(
                top: 300,
                left: 210,
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                      maxHeight: 55, maxWidth: 145 * 3.toDouble()),
                  child: Stack(
                    children: generateOptions(),
                  ),
                ),
              ),
              Positioned(
                right: (0.0 / 740.0) * MediaQuery.of(context).size.height,
                top: (50.0 / 360.0) * MediaQuery.of(context).size.width,
                bottom: (50.0 / 360.0) * MediaQuery.of(context).size.width,
                child: Container(
                  height: (40.0 / 740.0) * MediaQuery.of(context).size.height,
                  width: (30.0 / 360.0) * MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(133, 119, 226, 1),
                    borderRadius: new BorderRadius.only(
                        topLeft: const Radius.circular(30),
                        bottomLeft: const Radius.circular(30)),
                  ),
                  child: FlatButton(
                    onPressed: () {},
                    child: Text(
                      'Get Next',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 11,
                          fontWeight: FontWeight.w100),
                    ),
                  ),
                ),
              )
            ],
          ),
        ));
  }

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
  }

  @override
  dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.dispose();
  }
}
