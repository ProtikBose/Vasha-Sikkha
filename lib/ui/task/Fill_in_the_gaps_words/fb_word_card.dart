import 'package:Dimik/ScopedModel/mainmodel.dart';
import 'package:Dimik/models/fb_word.dart';
import 'package:flutter/material.dart';
import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:scoped_model/scoped_model.dart';

class FBWordCard extends StatefulWidget {
  final FB_Word _fb_word;
  final GlobalKey<ScaffoldState> scaffoldKey;
  final PageController controller;
  int current;
  FBWordCard(this._fb_word, this.scaffoldKey, this.controller, this.current);

  @override
  State<StatefulWidget> createState() {
    return FBWordCardState();
  }
}

class FBWordCardState extends State<FBWordCard> {
  int total = 1;
  final _kDuration = const Duration(milliseconds: 300);
  final _kCurve = Curves.decelerate;
  int prev_correct = 0;
  int curr_correct = 0;
  bool _sent_verdict = false;
  AudioPlayer audioPlayer;
  bool _canVibrate = true;
  List<bool> drag_end = [];
  List<bool> accepted = [];

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < widget._fb_word.options.length; i++) {
      drag_end.add(false);
    }
    for (int i = 0; i < widget._fb_word.answer.length; i++) {
      accepted.add(false);
    }
  }

  Future successAudio() async {
    audioPlayer = await AudioCache().play("audios/success.mp3");
  }

  Future errorAudio() async {
    audioPlayer = await AudioCache().play("audios/error.mp3");
  }

  void CorrectAnswer() {
    successAudio();
    widget.scaffoldKey.currentState
        .showBottomSheet<Null>((BuildContext context) {
      return ScopedModelDescendant(
          builder: (BuildContext context, Widget child, MainModel model) {
        return Container(
            decoration: BoxDecoration(
                color: Color.fromRGBO(83, 195, 111, 1),
                borderRadius: BorderRadius.only(
                    topLeft: const Radius.circular(30),
                    topRight: const Radius.circular(30))),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.20,
            child: Stack(
              children: <Widget>[
                Positioned(
                  top: 20,
                  left: 20,
                  child: Text(
                    widget._fb_word.explanation,
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
                      if (curr_correct == widget._fb_word.answer.length) {
                        if (!_sent_verdict) {
                          model.postVerdict(widget._fb_word, 1);
                          _sent_verdict = true;
                        }
                        model.incrementFBWScore();
                        if (widget.current == model.tasklen) {
                          Navigator.pushReplacementNamed(context, '/gameover',
                              arguments: 'mixtask');
                        } else
                          model.current = model.current + 1;

                        widget.controller
                            .nextPage(curve: _kCurve, duration: _kDuration);
                      }
                    },
                  ),
                ),
              ],
            ));
      });
    });
  }

  void WrongAnswer() {
    errorAudio();
    widget.scaffoldKey.currentState
        .showBottomSheet<Null>((BuildContext context) {
      return ScopedModelDescendant(
          builder: (BuildContext context, Widget child, MainModel model) {
        model.decrementFBWScore();
        return Container(
            decoration: BoxDecoration(
                color: Color.fromRGBO(255, 131, 131, 1),
                borderRadius: BorderRadius.only(
                    topLeft: const Radius.circular(30),
                    topRight: const Radius.circular(30))),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.20,
            child: Stack(
              children: <Widget>[
                Positioned(
                  top: 20,
                  left: 20,
                  child: Text(
                    widget._fb_word.explanation,
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
            ));
      });
    });
  }

  Widget getDragTarget(String answer, int index) {
    return ScopedModelDescendant(
        builder: (BuildContext context, Widget child, MainModel model) {
      return DragTarget(
        builder: (context, List<String> candidateData, rejectedData) {
          return accepted[index]
              ? Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.grey, width: 2),
                      borderRadius:
                          new BorderRadius.all(const Radius.circular(20))),
                  height: 60,
                  width: 50,
                  child: Center(
                    child: Text(
                      answer,
                      style: TextStyle(fontSize: 18),
                    ),
                  ))
              : Container(
                  decoration: BoxDecoration(
                      color: Colors.grey,
                      border: Border.all(color: Colors.grey, width: 2),
                      borderRadius:
                          new BorderRadius.all(const Radius.circular(20))),
                  height: 60,
                  width: 50,
                  child: Center(
                    child: Text(
                      '',
                      style: TextStyle(fontSize: 18),
                    ),
                  ));
        },
        onWillAccept: (data) {
          return true;
        },
        onAccept: (data) {
          if (answer == data) {
            curr_correct++;
            CorrectAnswer();
            accepted[index] = true;
          } else {
            WrongAnswer();
          }
        },
      );
    });
  }

  Widget getDraggable(String data, int index) {
    return ScopedModelDescendant(
        builder: (BuildContext context, Widget child, MainModel model) {
      return Draggable(
          child: !drag_end[index]
              ? new Container(
                  decoration: new BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.redAccent, width: 2),
                      borderRadius:
                          new BorderRadius.all(const Radius.circular(20))),
                  height: 70,
                  width: 60,
                  child: Center(
                    child: Text(
                      data,
                      style: TextStyle(color: Colors.black),
                    ),
                  ))
              : Container(),
          feedback: Container(
              decoration: new BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.redAccent, width: 2),
                  borderRadius:
                      new BorderRadius.all(const Radius.circular(20))),
              width: 60,
              height: 70,
              child: RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius:
                          new BorderRadius.all(const Radius.circular(20))),
                  onPressed: () {},
                  child: Text(
                    data,
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
          onDragCompleted: () {
            setState(() {
              for (int i = 0; i < widget._fb_word.answer.length; i++) {
                if (widget._fb_word.answer[i] == data) {
                  if (curr_correct - prev_correct == 1) {
                    drag_end[index] = true;
                    prev_correct++;
                  } else {
                    break;
                  }
                }
              }
            });
          },
          data: data);
    });
  }

  List<Widget> incorrectWord() {
    String word = widget._fb_word.incompleteWord;
    int levels = (word.length / 5.00).floor().toInt();
    List<int> side = [];
    for (int i = 0; i < levels; i++) {
      side.add(5);
    }
    side.add(word.length.toInt() % 5);
    int count = 0;
    List<Widget> wids = [];
    double top = 0, left = 0;
    int correct_count = 0;
    for (int i = 0; i < side.length; i++) {
      left = 0;
      for (int j = 0; j < side[i]; j++) {
        wids.add(new Positioned(
          top: top,
          left: left,
          child: word[count] == '#'
              ? getDragTarget(
                  widget._fb_word.answer[correct_count++], correct_count - 1)
              : Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.grey, width: 2),
                      borderRadius:
                          new BorderRadius.all(const Radius.circular(20))),
                  height: 60,
                  width: 50,
                  child: Center(
                    child: Text(
                      word[count],
                      style: TextStyle(fontSize: 18),
                    ),
                  )),
        ));
        left += 60;
        count++;
      }
      top += 70;
    }

    return wids;
  }

  List<Widget> generateOptions() {
    int levels = (widget._fb_word.options.length / 3.00).floor().toInt();
    List<int> side = [];
    for (int i = 0; i < levels; i++) {
      side.add(3);
    }
    side.add(widget._fb_word.options.length.toInt() % 3);
    levels++;

    int count = 0;

    List<Widget> wids = [];

    double top = 0, left = 0;
    for (int i = 0; i < side.length; i++) {
      left = 20;
      for (int j = 0; j < side[i]; j++) {
        String data = widget._fb_word.options[count];
        wids.add(new Positioned(
          top: top,
          left: left,
          child: getDraggable(data, count),
        ));
        count++;
        left += 90;
      }
      top += 90;
    }

    return wids;
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant(
      builder: (BuildContext context, Widget child, MainModel model) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: new BorderRadius.all(const Radius.circular(30)),
          ),
          height: MediaQuery.of(context).size.height * (455.0 / 740.0),
          width: MediaQuery.of(context).size.width * (320.0 / 360.0),
          child: Stack(
            children: <Widget>[
              Positioned(
                child: Container(
                    //color: Colors.black,
                    height: 200,
                    width: MediaQuery.of(context).size.width * (280.0 / 360.0),
                    child: Stack(
                      children: incorrectWord(),
                    )),
                top: 40,
                left: 25,
              ),
              Positioned(
                child: Container(
                    //color: Colors.black,
                    height: 200,
                    width: MediaQuery.of(context).size.width * (280.0 / 360.0),
                    child: Stack(
                      children: generateOptions(),
                    )),
                top: 240,
                left: 25,
              )
            ],
          ),
        );
      },
    );
  }
}
