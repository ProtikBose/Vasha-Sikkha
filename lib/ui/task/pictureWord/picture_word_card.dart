import 'package:Dimik/ScopedModel/mainmodel.dart';
import 'package:Dimik/models/pictureword.dart';
import 'package:Dimik/models/task_history.dart';
import 'package:Dimik/ui/task/pictureWord/picture_word_task.dart';
import 'package:flutter/material.dart';
import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:scoped_model/scoped_model.dart';

class PictureWordCard extends StatefulWidget {
  PictureWord _pictureWord;
  GlobalKey<ScaffoldState> scaffoldKey;
  final PageController controller;
  final int current;
  PictureWordCard(this._pictureWord,
      {this.scaffoldKey, this.controller, this.current});

  @override
  State<StatefulWidget> createState() {
    return PictureWordCardState();
  }
}

class PictureWordCardState extends State<PictureWordCard> {
  AudioPlayer audioPlayer;
  bool _sent_verdict = false;
  final _kDuration = const Duration(milliseconds: 300);
  final _kCurve = Curves.decelerate;
  int option1 = 1, option2 = 1, option3 = 1, option4 = 1;
  bool disable1 = false, disable2 = false, disable3 = false, disable4 = false;

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

  void disableAll() {
    disable1 = disable2 = disable3 = disable4 = true;
  }

  void CorrectAnswer() {
    setState(() {
      disableAll();
    });
    successAudio();
    widget.scaffoldKey.currentState
        .showBottomSheet<Null>((BuildContext context) {
      return ScopedModelDescendant(
          builder: (BuildContext context, Widget child, MainModel model) {
        if (!_sent_verdict) {
          model.postVerdict(widget._pictureWord, 1);
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
                    widget._pictureWord.explanation,
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

  void WrongAnswer() {
    setState(() {
      disableAll();
    });
    errorAudio();
    widget.scaffoldKey.currentState
        .showBottomSheet<Null>((BuildContext context) {
      return ScopedModelDescendant(
          builder: (BuildContext context, Widget child, MainModel model) {
        if (!_sent_verdict) {
          model.postVerdict(widget._pictureWord, 0);
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
                    widget._pictureWord.explanation,
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
          //margin: EdgeInsets.all(20),
          height: (453.0 / 740.0) * MediaQuery.of(context).size.height,
          width: (320.0 / 360.0) * MediaQuery.of(context).size.width,
          margin: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: new BorderRadius.all(const Radius.circular(30)),
          ),
          child: Stack(
            children: <Widget>[
              Positioned(
                top: 20,
                left: 20,
                right: 20,
                child: ClipRRect(
                    borderRadius: new BorderRadius.circular(30.0),
                    child: Image.asset(
                      widget._pictureWord.imgLink,
                      width:
                          MediaQuery.of(context).size.width * (270.0 / 360.0),
                      height:
                          MediaQuery.of(context).size.width * (300.0 / 455.0),
                      fit: BoxFit.cover,
                    )),
              ),
              Positioned(
                top: 300,
                left: 30,
                child: Container(
                  height: (50.0 / 740.0) * MediaQuery.of(context).size.height,
                  width: (100.0 / 360.0) * MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: option1 == 1
                          ? Colors.grey.withOpacity(0.1)
                          : option1 == 2
                              ? Color.fromRGBO(83, 195, 111, 1)
                              : Color.fromRGBO(255, 131, 131, 1),
                      borderRadius:
                          new BorderRadius.all(const Radius.circular(23)),
                      boxShadow: [
                        BoxShadow(
                            color: option1 == 1
                                ? Colors.grey.withOpacity(0.1)
                                : Colors.white.withOpacity(0.1),
                            spreadRadius: 1,
                            blurRadius: 5)
                      ]),
                  child: FlatButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(23.0)),
                    onPressed: () {
                      if (!disable1) {
                        if (widget._pictureWord.correctOption == 1) {
                          setState(() {
                            option1 = 2;
                            model.incrementPWScore();
                            CorrectAnswer();
                            Task_History tf = new Task_History(
                                task: widget._pictureWord,
                                correctIndex: 1,
                                inputIndex: 1);
                            model.addTaskHistory(tf);
                          });
                        } else {
                          setState(() {
                            option1 = 3;
                            if (widget._pictureWord.correctOption == 2) {
                              setState(() {
                                option2 = 2;
                                model.decrementPWScore();
                                WrongAnswer();
                                Task_History tf = new Task_History(
                                    task: widget._pictureWord,
                                    correctIndex: 2,
                                    inputIndex: 1);
                                model.addTaskHistory(tf);
                              });
                            }

                            if (widget._pictureWord.correctOption == 3) {
                              setState(() {
                                option3 = 2;
                                model.decrementPWScore();
                                WrongAnswer();
                                Task_History tf = new Task_History(
                                    task: widget._pictureWord,
                                    correctIndex: 3,
                                    inputIndex: 1);
                                model.addTaskHistory(tf);
                              });
                            }
                            if (widget._pictureWord.correctOption == 4) {
                              setState(() {
                                option4 = 2;
                                model.decrementPWScore();
                                WrongAnswer();
                                Task_History tf = new Task_History(
                                    task: widget._pictureWord,
                                    correctIndex: 4,
                                    inputIndex: 1);
                                model.addTaskHistory(tf);
                              });
                            }
                          });
                        }
                      }
                    },
                    child: Text(
                      widget._pictureWord.options[0],
                      style: TextStyle(
                          color: option1 == 1 ? Colors.black : Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.w100),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 300,
                right: 30,
                child: Container(
                  height: (50.0 / 740.0) * MediaQuery.of(context).size.height,
                  width: (100.0 / 360.0) * MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: option2 == 1
                          ? Colors.grey.withOpacity(0.1)
                          : option2 == 2
                              ? Color.fromRGBO(83, 195, 111, 1)
                              : Color.fromRGBO(255, 131, 131, 1),
                      borderRadius:
                          new BorderRadius.all(const Radius.circular(23)),
                      boxShadow: [
                        BoxShadow(
                            color: option2 == 1
                                ? Colors.grey.withOpacity(0.1)
                                : Colors.white.withOpacity(0.1),
                            spreadRadius: 1,
                            blurRadius: 5)
                      ]),
                  child: FlatButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(23.0)),
                    onPressed: () {
                      if (!disable2) {
                        if (widget._pictureWord.correctOption == 2) {
                          setState(() {
                            option2 = 2;
                            model.incrementPWScore();
                            CorrectAnswer();
                            Task_History tf = new Task_History(
                                task: widget._pictureWord,
                                correctIndex: 2,
                                inputIndex: 2);
                            model.addTaskHistory(tf);
                          });
                        } else {
                          setState(() {
                            option2 = 3;
                            if (widget._pictureWord.correctOption == 1) {
                              setState(() {
                                option1 = 2;
                                model.decrementPWScore();
                                WrongAnswer();
                                Task_History tf = new Task_History(
                                    task: widget._pictureWord,
                                    correctIndex: 1,
                                    inputIndex: 3);
                                model.addTaskHistory(tf);
                              });
                            }

                            if (widget._pictureWord.correctOption == 3) {
                              setState(() {
                                option3 = 2;
                                model.decrementPWScore();
                                WrongAnswer();
                                Task_History tf = new Task_History(
                                    task: widget._pictureWord,
                                    correctIndex: 3,
                                    inputIndex: 2);
                                model.addTaskHistory(tf);
                              });
                            }
                            if (widget._pictureWord.correctOption == 4) {
                              setState(() {
                                option4 = 2;
                                model.decrementPWScore();
                                WrongAnswer();
                                Task_History tf = new Task_History(
                                    task: widget._pictureWord,
                                    correctIndex: 4,
                                    inputIndex: 2);
                                model.addTaskHistory(tf);
                              });
                            }
                          });
                        }
                      }
                    },
                    child: Text(
                      widget._pictureWord.options[1],
                      style: TextStyle(
                          color: option2 == 1 ? Colors.black : Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.w100),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 395,
                left: 30,
                child: Container(
                  height: (50.0 / 740.0) * MediaQuery.of(context).size.height,
                  width: (100.0 / 360.0) * MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: option3 == 1
                          ? Colors.grey.withOpacity(0.1)
                          : option3 == 2
                              ? Color.fromRGBO(83, 195, 111, 1)
                              : Color.fromRGBO(255, 131, 131, 1),
                      borderRadius:
                          new BorderRadius.all(const Radius.circular(23)),
                      boxShadow: [
                        BoxShadow(
                            color: option3 == 1
                                ? Colors.grey.withOpacity(0.1)
                                : Colors.white.withOpacity(0.1),
                            spreadRadius: 1,
                            blurRadius: 5)
                      ]),
                  child: FlatButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(23.0)),
                    onPressed: () {
                      if (!disable3) {
                        if (widget._pictureWord.correctOption == 3) {
                          setState(() {
                            option3 = 2;
                            CorrectAnswer();
                            model.incrementPWScore();
                            Task_History tf = new Task_History(
                                task: widget._pictureWord,
                                correctIndex: 3,
                                inputIndex: 3);
                            model.addTaskHistory(tf);
                          });
                        } else {
                          setState(() {
                            option3 = 3;
                            if (widget._pictureWord.correctOption == 1) {
                              setState(() {
                                option1 = 2;
                                WrongAnswer();
                                model.decrementPWScore();
                                Task_History tf = new Task_History(
                                    task: widget._pictureWord,
                                    correctIndex: 1,
                                    inputIndex: 3);
                                model.addTaskHistory(tf);
                              });
                            }

                            if (widget._pictureWord.correctOption == 2) {
                              setState(() {
                                option2 = 2;
                                model.decrementPWScore();
                                WrongAnswer();
                                Task_History tf = new Task_History(
                                    task: widget._pictureWord,
                                    correctIndex: 2,
                                    inputIndex: 3);
                                model.addTaskHistory(tf);
                              });
                            }
                            if (widget._pictureWord.correctOption == 4) {
                              setState(() {
                                option4 = 2;
                                model.decrementPWScore();
                                WrongAnswer();
                                Task_History tf = new Task_History(
                                    task: widget._pictureWord,
                                    correctIndex: 4,
                                    inputIndex: 3);
                                model.addTaskHistory(tf);
                              });
                            }
                          });
                        }
                      }
                    },
                    child: Text(
                      widget._pictureWord.options[2],
                      style: TextStyle(
                          color: option3 == 1 ? Colors.black : Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.w100),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 395,
                right: 30,
                child: Container(
                  height: (50.0 / 740.0) * MediaQuery.of(context).size.height,
                  width: (100.0 / 360.0) * MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: option4 == 1
                          ? Colors.grey.withOpacity(0.1)
                          : option4 == 2
                              ? Color.fromRGBO(83, 195, 111, 1)
                              : Color.fromRGBO(255, 131, 131, 1),
                      borderRadius:
                          new BorderRadius.all(const Radius.circular(23)),
                      boxShadow: [
                        BoxShadow(
                            color: option4 == 1
                                ? Colors.grey.withOpacity(0.1)
                                : Colors.white.withOpacity(0.1),
                            spreadRadius: 1,
                            blurRadius: 5)
                      ]),
                  child: FlatButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(23.0)),
                    onPressed: () {
                      if (!disable4) {
                        if (widget._pictureWord.correctOption == 4) {
                          setState(() {
                            option4 = 2;
                            model.incrementPWScore();
                            CorrectAnswer();
                            Task_History tf = new Task_History(
                                task: widget._pictureWord,
                                correctIndex: 4,
                                inputIndex: 4);
                            model.addTaskHistory(tf);
                          });
                        } else {
                          setState(() {
                            option4 = 3;
                            if (widget._pictureWord.correctOption == 1) {
                              setState(() {
                                option1 = 2;
                                model.decrementPWScore();
                                WrongAnswer();
                                Task_History tf = new Task_History(
                                    task: widget._pictureWord,
                                    correctIndex: 1,
                                    inputIndex: 4);
                                model.addTaskHistory(tf);
                              });
                            }

                            if (widget._pictureWord.correctOption == 2) {
                              setState(() {
                                option2 = 2;
                                model.decrementPWScore();
                                WrongAnswer();
                                Task_History tf = new Task_History(
                                    task: widget._pictureWord,
                                    correctIndex: 2,
                                    inputIndex: 4);
                                model.addTaskHistory(tf);
                              });
                            }
                            if (widget._pictureWord.correctOption == 3) {
                              setState(() {
                                option3 = 2;
                                model.decrementPWScore();
                                WrongAnswer();
                                Task_History tf = new Task_History(
                                    task: widget._pictureWord,
                                    correctIndex: 3,
                                    inputIndex: 4);
                                model.addTaskHistory(tf);
                              });
                            }
                          });
                        }
                      }
                    },
                    child: Text(
                      widget._pictureWord.options[3],
                      style: TextStyle(
                          color: option4 == 1 ? Colors.black : Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.w100),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
