import 'package:Dimik/ScopedModel/mainmodel.dart';
import 'package:Dimik/models/task_history.dart';
import 'package:Dimik/models/tf.dart';
import 'package:flutter/material.dart';
import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:scoped_model/scoped_model.dart';

class TrueFalseCard extends StatefulWidget {
  final TF tf;
  GlobalKey<ScaffoldState> scaffoldKey;
  final PageController controller;
  final int current;
  final int index;

  TrueFalseCard({
    @required this.index,
    @required this.tf,
    @required this.controller,
    @required this.current,
    @required this.scaffoldKey,
  });

  @override
  State<StatefulWidget> createState() {
    return TrueFalseCardState();
  }
}

class TrueFalseCardState extends State<TrueFalseCard> {
  final _kDuration = const Duration(milliseconds: 300);
  final _kCurve = Curves.decelerate;
  bool _disabled_true_button = false;
  bool _disabled_false_button = false;
  bool _sent_verdict = false;
  AudioPlayer audioPlayer;
  bool answered_1 = false;
  bool answered_2 = false;

  @override
  void initState() {
    super.initState();
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
        if (!_sent_verdict) {
          model.postVerdict(widget.tf, 1);
          _sent_verdict = true;
        }
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
                    widget.tf.explanation,
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
                      if (model.current == model.tasklen) {
                        Navigator.pushReplacementNamed(context, '/gameover',
                            arguments: 'mixtask');
                      } else
                        model.current = model.current + 1;

                      widget.controller
                          .nextPage(curve: _kCurve, duration: _kDuration);
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
        if (!_sent_verdict) {
          model.postVerdict(widget.tf, 0);
          _sent_verdict = true;
        }
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
                    widget.tf.explanation,
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
                      if (widget.current == model.tasklen) {
                        Navigator.pushReplacementNamed(context, '/gameover',
                            arguments: 'mixtask');
                      } else
                        model.current = model.current + 1;

                      widget.controller
                          .nextPage(curve: _kCurve, duration: _kDuration);
                    },
                  ),
                ),
              ],
            ));
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant(
      builder: (BuildContext context, Widget child, MainModel model) {
        return Container(
            child: Stack(
              children: <Widget>[
                Positioned(
                  top: 115,
                  left: 20,
                  right: 20,
                  child:
                      Text(widget.tf.question, style: TextStyle(fontSize: 18)),
                ),
                Positioned(
                  top: 245,
                  left: 95,
                  right: 95,
                  child: Container(
                    height: (50.0 / 740.0) * MediaQuery.of(context).size.height,
                    width: (130.0 / 360.0) * MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: !_disabled_true_button
                          ? Colors.grey.withOpacity(0.1)
                          : (widget.tf.answer == 1)
                              ? ((answered_1 == true)
                                  ? Color.fromRGBO(83, 195, 111, 1)
                                  : Color.fromRGBO(83, 195, 111, 1))
                              : ((answered_1 == true)
                                  ? Color.fromRGBO(255, 131, 131, 1)
                                  : Colors.grey.withOpacity(0.1)),
                      /*&& answered_1 == true)
                              ? Color.fromRGBO(255, 131, 131, 1)
                              : Color.fromRGBO(83, 195, 111, 1),*/
                      borderRadius:
                          new BorderRadius.all(const Radius.circular(23)),
                    ),
                    child: FlatButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(23.0)),
                      onPressed: () {
                        answered_1 = true;
                        if (!_disabled_false_button && !_disabled_true_button) {
                          if (widget.tf.answer == 1) {
                            CorrectAnswer();
                            model.incrementTFScore();
                            Task_History tf = new Task_History(
                                task: widget.tf,
                                correctIndex: 1,
                                inputIndex: 1);
                            model.addTaskHistory(tf);
                          } else {
                            WrongAnswer();
                            model.decrementTFScore();
                            Task_History tf = new Task_History(
                                task: widget.tf,
                                correctIndex: 0,
                                inputIndex: 1);
                            model.addTaskHistory(tf);
                          }

                          setState(() {
                            _disabled_false_button = true;
                            _disabled_true_button = true;
                          });
                        }
                      },
                      child: Text(
                        'True',
                        style: TextStyle(
                            color: _disabled_true_button
                                ? Colors.white
                                : Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.w100),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 330,
                  left: 95,
                  right: 95,
                  child: Container(
                    height: (50.0 / 740.0) * MediaQuery.of(context).size.height,
                    width: (130.0 / 360.0) * MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: !_disabled_false_button
                          ? Colors.grey.withOpacity(0.1)
                          : (widget.tf.answer == 0)
                              ? ((answered_2 == true)
                                  ? Color.fromRGBO(83, 195, 111, 1)
                                  : Color.fromRGBO(83, 195, 111, 1))
                              : ((answered_2 == true)
                                  ? Color.fromRGBO(255, 131, 131, 1)
                                  : Colors.grey.withOpacity(0.1)),
                      borderRadius:
                          new BorderRadius.all(const Radius.circular(23)),
                    ),
                    child: FlatButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(23.0)),
                      onPressed: () {
                        answered_2 = true;
                        if (!_disabled_false_button && !_disabled_true_button) {
                          if (widget.tf.answer == 0) {
                            CorrectAnswer();
                            model.incrementTFScore();
                            Task_History tf = new Task_History(
                                task: widget.tf,
                                correctIndex: 0,
                                inputIndex: 0);
                            model.addTaskHistory(tf);
                          } else {
                            WrongAnswer();
                            model.decrementTFScore();
                            Task_History tf = new Task_History(
                                task: widget.tf,
                                correctIndex: 1,
                                inputIndex: 0);
                            model.addTaskHistory(tf);
                          }

                          setState(() {
                            _disabled_false_button = true;
                            _disabled_true_button = true;
                          });
                        }
                      },
                      child: Text(
                        'False',
                        style: TextStyle(
                            color: _disabled_false_button
                                ? Colors.white
                                : Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.w100),
                      ),
                    ),
                  ),
                )
              ],
            ),
            margin: EdgeInsets.all(20),
            height: (453.0 / 740.0) * MediaQuery.of(context).size.height,
            width: (320.0 / 360.0) * MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: new BorderRadius.all(const Radius.circular(30)),
            ));
      },
    );
  }
}
