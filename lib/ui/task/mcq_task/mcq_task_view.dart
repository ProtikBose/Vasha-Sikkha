import 'package:Dimik/config.dart';
import 'package:Dimik/data/controller/fb.dart';
import 'package:Dimik/data/controller/mcq.dart';
import 'package:Dimik/ui/login/circularProgression.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import '../mcq_task/mcq_task_stats.dart';
import 'dart:math';
import 'package:Dimik/databaseChange/mcqData.dart';
import 'package:Dimik/ScopedModel/mainmodel.dart';
import 'package:scoped_model/scoped_model.dart';
import 'dart:async';
import 'dart:io' as io;

class MCQView extends StatefulWidget {
  /*final List<String> cards=['___________ is the largest sea beach in the world',
  'Batman lives in ______ city',
  'Time and ____ wait for none'];*/

  List<MCQDataBase> cards = new List();
  String topic;
  @override
  State<StatefulWidget> createState() {
    return _MCQViewState(cards: cards, topic: topic);
  }
}

class _MCQViewState extends State<MCQView> with TickerProviderStateMixin {
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  AnimationController animationController;
  AnimationController animationCounter;
  Animation<Offset> _moveOutOfTheScreen;
  Animation<double> _rotate;
  CurvedAnimation curvedAnimation;
  bool isLoading = true;
  // List<String> cards ;
  List<MCQDataBase> cards = new List();
  //Map<Map<String,String>,String> mp=new Map();
  String topic;
  int temp = 0;
  int index, length;
  bool isPressed;
  int iterative = 1;
  int _value = 0;
  int solved = 0;
  String value = "";
  _MCQViewState({this.cards, this.topic});
  List<MCQDataBase> val;
  MCQController fbc;

  int status = 0;
  String get timerString {
    Duration duration;
    if (isLoading == false) {
      duration = animationCounter.duration * animationCounter.value;
      _value = duration.inSeconds;
      String temp =
          '${duration.inMinutes % 60}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
      //if(temp=="0:00") dialogBoxShown();
      return temp;
    }

    return "";
  }

  void getQuestionsHardCode(MainModel model) {
    model.setMCQVal = new List();
    isLoading = false;
    //isLoading = true;
    List<String> optionTemp = ["Rajshahi", "Dhaka", "Dhaka", "Chittagong"];
    List<String> correctTemp = ["Dhaka", "Dhaka"];
    MCQDataBase mcq = new MCQDataBase(
        "What is the capital city of Bangladesh ?",
        optionTemp,
        correctTemp,
        1,
        2,
        "Dhaka and Dhaka is the capital city of Bangladesh");
    model.getMCQVal.add(mcq);

    List<String> optionTemp1 = ["Kuakata", "Cox's Bazar", "Both", "None"];
    List<String> correctTemp1 = ["Cox's Bazar"];
    MCQDataBase mcq1 = new MCQDataBase(
        "What is the largest sea beach of Bangladesh ?",
        optionTemp1,
        correctTemp1,
        2,
        1,
        "Cox's Bazar is the largest sea beach of Bangladesh");
    model.getMCQVal.add(mcq1);

    List<String> optionTemp2 = ["Africa", "Australia", "Asia", "Europe"];
    List<String> correctTemp2 = ["Asia"];
    MCQDataBase mcq2 = new MCQDataBase(
        "On which continent is Bangladesh located ?",
        optionTemp2,
        correctTemp2,
        3,
        1,
        "Bangladesh is located in Asia");
    model.getMCQVal.add(mcq2);

    List<String> optionTemp3 = ["Sylhet", "Dhaka", "Chittagong", "Khulna"];
    List<String> correctTemp3 = ["Sylhet"];
    MCQDataBase mcq3 = new MCQDataBase(
        "Which district of Bangladesh was part of Assam ?",
        optionTemp3,
        correctTemp3,
        3,
        2,
        "Sylhet was part of Assam");
    model.getMCQVal.add(mcq3);

    List<String> optionTemp4 = [
      "Dhaka Shangshad",
      "Jatiyo Shangshad",
      "Bangladesh Shangshad",
      "None"
    ];
    List<String> correctTemp4 = ["Jatiyo Shangshad"];
    MCQDataBase mcq4 = new MCQDataBase(
        "What is the name of national parliament of Bangladesh ?",
        optionTemp4,
        correctTemp4,
        4,
        1,
        "Easy Question");
    model.getMCQVal.add(mcq4);

    length = model.getMCQVal.length;
  }

  @override
  void initState() {
    super.initState();

    index = 0;
    isPressed = false;
    isLoading = true;

    //getQuestions();
    //getQuestionsHardCode();
    length = 5;
    animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    animationCounter =
        AnimationController(vsync: this, duration: Duration(seconds: 90));

    curvedAnimation =
        CurvedAnimation(parent: animationController, curve: Curves.easeOut);
    _moveOutOfTheScreen =
        new Tween<Offset>(begin: Offset(0.0, 0.0), end: Offset(-500.0, 200.0))
            .animate(curvedAnimation)
              ..addListener(() {
                setState(() {
                  //animationController.reset();
                });
              });
    _rotate = new Tween<double>(begin: 0, end: -1).animate(curvedAnimation);
    animationCounter.reverse(
        from: animationCounter.value == 0.0
            ? 1.0
            : animationCounter.value); //..addListener(() {
    //   setState(() {});
    // });
    // dataEntry();
    animationCounter.addListener(() {
      if (timerString == "0:00") {
        print("timer stopped");
        TimedialogBoxShown();
      }
    });
  }

  @override
  void dispose() {
    //InsertData.delete();
    super.dispose();
    //fbc.deleteTopic();
  }

  void getAnswer(bool value) {
    Color color = Colors.red;
    String text = "Wrong Answer!";

    if (value == true && timerString != "0:00") {
      color = Colors.green;
      solved++;

      text = "Correct Answer!";
    }

    if (timerString != "0:00") {
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              color: //Color.fromARGB(3, 0, 255, 0),
                  color.withOpacity(0.3),
              height: 100,
              child: Center(
                  child: Text(
                text,
                style: TextStyle(fontSize: 30, color: color),
              )),
            );
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    //if(status==1) TimedialogBoxShown();

    // animationCounter.reverse(
    //     from: animationCounter.value == 0.0 ? 1.0 : animationCounter.value);
    //if(status==1) TimedialogBoxShown();
    // innerLoop();
    // while(isLoading);
    return Scaffold(
        key: _scaffoldKey,
        backgroundColor: Color.fromRGBO(242, 242, 242, 1),
        body: ScopedModelDescendant<MainModel>(
            builder: (BuildContext context, Widget child, MainModel model) {
          topic = ModalRoute.of(context).settings.arguments;
          //topic=ModalRoute.of(context).settings.arguments;
          if (temp == 0) {
            model.fbSolution = new List();
            model.fbTempStore = new List();
            model.fbTempSolution = new List();
            getQuestions(model);
            //getQuestionsHardCode(model);
            temp++;
          }
          return WillPopScope(
              onWillPop: _onWillPopPressed,
              child: Stack(
                children: <Widget>[
                  Positioned(
                      top: 49,
                      //bottom: 650,
                      left: 20,
                      //right: 20,s
                      width: 194,
                      height: 49,
                      child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(29.5)),
                          child: Stack(
                            children: <Widget>[
                              Positioned(
                                left: 5,
                                width: 10,
                                top: -2,
                                child: IconButton(
                                  icon: Icon(Icons.arrow_back_ios),
                                  onPressed: () {
                                    _onWillPopPressed();
                                  },
                                ),
                              ),
                              Positioned(
                                left: 52,
                                right: 76,
                                top: 14,
                                bottom: 13,
                                child: Text("Remaining",
                                    style: TextStyle(
                                        color: Color(0xFF2E303E),
                                        fontSize: 12)),
                              ),
                              Positioned(
                                  left: 136,
                                  right: 26,
                                  top: 14,
                                  bottom: 13,
                                  child: AnimatedBuilder(
                                      animation: animationCounter,
                                      builder: (_, Widget child) {
                                        return Text(
                                          timerString,
                                          style: TextStyle(
                                              color: Color(0xFFE27777),
                                              fontSize: 12),
                                        );
                                      }))
                            ],
                          ))),

                  Positioned(
                      top: 49,
                      //bottom: 650,
                      left: 243,
                      //right: 20,
                      width: 97,
                      height: 49,
                      child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(29.5)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(iterative.toString()),
                              Text("/",
                                  style: TextStyle(
                                      color: Color.fromARGB(51, 46, 48, 62))),
                              Text(length.toString())
                            ],
                          ))),

                  // Positioned(
                  //   top: 144,
                  //   bottom: 143,
                  //   left: 20,
                  //   right: 20,
                  //   child:TaskStats()

                  // ),
                  Positioned(
                      top: MediaQuery.of(context).size.height * (80 / 453),
                      bottom: MediaQuery.of(context).size.height * (80 / 453),
                      left: MediaQuery.of(context).size.width * (15 / 320),
                      right: MediaQuery.of(context).size.width * (15 / 320),
                      child: cardMovement(context, model)),

                  Positioned(
                    top: MediaQuery.of(context).size.height * (400 / 453),
                    //bottom: 0,
                    left: MediaQuery.of(context).size.width * (15 / 320),
                    right: MediaQuery.of(context).size.width * (15 / 320),
                    //width: MediaQuery.of(context).size.width*(400/453),
                    height: MediaQuery.of(context).size.height * (38 / 453),
                    child: RaisedButton(
                      onPressed: () {
                        isPressed = true;
                        if (timerString != "0:00") {
                          animationController.forward().whenComplete(() {
                            setState(() {
                              iterative++;
                              animationController.reset();
                              if (isLoading == false)
                                MCQDataBase removedCard =
                                    model.getMCQVal.removeAt(0);
                              //cards.add(removedCard);
                              isPressed = false;

                              if (iterative > length) {
                                iterative--;
                                animationCounter.stop();
                                //animationCounter.
                                dialogBoxShown(model);
                              }
                            });
                          });
                        } else {
                          TimedialogBoxShown();
                        }
                      },
                      child: Stack(
                        children: <Widget>[
                          Positioned(
                            top: MediaQuery.of(context).size.height * (7 / 320),
                            bottom:
                                MediaQuery.of(context).size.height * (5 / 320),
                            left:
                                MediaQuery.of(context).size.width * (90 / 320),
                            child: Text(
                              "Get next",
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            ),
                          )
                        ],
                      ),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(23)),
                      textColor: Colors.white,
                      //highlightColor: Colors.red,
                      color: Color(0xFF8577E2),
                      //elevation: 1,
                      //highlightElevation: 0.5,
                    ),
                  )
                ],
              ));
        }));
  }

  Widget cardMovement(BuildContext context, MainModel model) {
    if (isLoading) {
      // return Stack(
      //     children: cards.reversed.map((card) {
      //   if (cards.indexOf(card) < length) {
      //     return (Transform.translate(
      //         offset: moveValue(card),
      //         child: Transform.rotate(
      //             angle: rotateValue(card),
      //             child: MCQStats(card, getAnswer, isLoading))));
      //   }
      // }).toList());
      return ProgressHUD(
        child: Container(),
        inAsyncCall: true,
        opacity: 0.0,
      );
    } else {
      return Stack(
          children: model.getMCQVal.reversed.map((car) {
        if (model.getMCQVal.indexOf(car) < length) {
          return (Transform.translate(
              offset: moveValue(car, model),
              child: Transform.rotate(
                  angle: rotateValue(car, model),
                  child: MCQStats(car, _scaffoldKey))));
        }
      }).toList());
    }
  }

  Future<bool> dialogBoxShown(MainModel model) {
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text(" Do you want to continue?"),
              actions: <Widget>[
                FlatButton(
                  child: Text("Yes"),
                  onPressed: () =>
                      Navigator.of(context).pushReplacementNamed("/mcqTask"),
                ),
                FlatButton(
                  child: Text("No"),
                  //onPressed: () => Navigator.pop(context, false),
                  onPressed: () {
                    //dispose();
                    //fbc.deleteTopic();
                    //Navigator.of(context).pushReplacementNamed("/home");
                    model.setMCQSolved = solved;
                    Navigator.pushReplacementNamed(context, '/home',
                        arguments: 'mcq');
                  },
                )
              ],
            ));
  }

  Future<bool> TimedialogBoxShown() {
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text("Sorry !!!! Your time is up .  " +
                  "Do you want to continue?"),
              actions: <Widget>[
                FlatButton(
                  child: Text("Yes"),
                  onPressed: () =>
                      Navigator.of(context).pushReplacementNamed("/mcqTask"),
                ),
                FlatButton(
                  child: Text("No"),
                  onPressed: () {
                    //dispose();
                    //fbc.deleteTopic();
                    Navigator.of(context).pushReplacementNamed("/home");
                  },
                )
              ],
            ));
  }

  Future<bool> _onWillPopPressed() {
    animationCounter.stop();
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text("Do You Really Want To Exit?"),
              actions: <Widget>[
                FlatButton(
                  child: Text("Yes"),
                  onPressed: () =>
                      Navigator.of(context).pushReplacementNamed("/home"),
                ),
                FlatButton(
                  child: Text("No"),
                  onPressed: () {
                    animationCounter.reverse(
                        from: animationCounter.value == 0.0
                            ? 1.0
                            : animationCounter.value);
                    Navigator.pop(context, false);
                  },
                )
              ],
            ));
  }

  Offset moveValue(card, MainModel model) {
    if (model.getMCQVal.indexOf(card) == 0 && isPressed)
      return _moveOutOfTheScreen.value;
    return Offset(0.0, 0.0);
  }

  double rotateValue(card, MainModel model) {
    if (model.getMCQVal.indexOf(card) == 0 && isPressed) return _rotate.value;
    return 0.0;
  }

  void getQuestions(MainModel model) async {
    fbc = new MCQController();
    //fbc.deleteTopic();
    //int i=int.parse(topic);
    //print(topic);
    //print(i);
    //fbc.deleteTopic();
    fbc.getMCQList(TOKEN, 1).then((qsList) {
      setState(() {
        //print("In then");
        animationCounter.reverse(
            from: animationCounter.value == 0 ? 1 : animationCounter.value);

        //_options = new Map<String, String>();
        model.setMCQVal = new List();
        List<String> options = new List();
        // List<String> correctAns = new List();

        for (int i = 0; i < qsList.length; i++) {
          List<String> correctAns = new List();
          options = qsList.elementAt(i).options;
          correctAns.add(qsList.elementAt(i).answer[0]);
          model.getMCQVal.add(new MCQDataBase(
              qsList.elementAt(i).question,
              options,
              correctAns,
              qsList.elementAt(i).taskId,
              qsList.elementAt(i).specificTaskId,
              qsList.elementAt(i).explanation));
          print(model.getMCQVal.elementAt(i).question);
          print(model.getMCQVal.elementAt(i).option.toString());
          print(model.getMCQVal.elementAt(i).getCorrect.toString());
          if (i == qsList.length - 1) isLoading = false;
        }

        length = model.getMCQVal.length;
      });
    });
  }
}
