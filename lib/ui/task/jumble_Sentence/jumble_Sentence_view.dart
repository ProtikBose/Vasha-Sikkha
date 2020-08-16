import 'package:Dimik/ScopedModel/mainmodel.dart';
import 'package:Dimik/config.dart';
import 'package:Dimik/data/controller/jumbled_sentence.dart';
import 'package:Dimik/ui/login/circularProgression.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import '../jumble_Sentence/jumble_Sentence_stats.dart';
import 'dart:math';
import 'package:Dimik/databaseChange/jumbleSentence.dart';
import 'package:scoped_model/scoped_model.dart';
import '../../../ScopedModel/jumbled_model.dart';
import 'package:Dimik/ScopedModel/mainmodel.dart';
import 'dart:async';
import 'dart:io' as io;

class jumbleSentenceView extends StatefulWidget {
  /*final List<String> cards=['___________ is the largest sea beach in the world',
  'Batman lives in ______ city',
  'Time and ____ wait for none'];*/

  List<jumbleSentence> cards = new List();
  String topic;
  //FillTheGapsView({this.cards});

  @override
  State<StatefulWidget> createState() {
    return _jumbleSentenceViewState(cards: cards, topic: topic);
  }
}

class _jumbleSentenceViewState extends State<jumbleSentenceView>
    with TickerProviderStateMixin {
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  AnimationController animationController;
  AnimationController animationCounter;
  Animation<Offset> _moveOutOfTheScreen;
  Animation<double> _rotate;
  CurvedAnimation curvedAnimation;
  bool isLoading = false;
  // List<String> cards ;
  List<jumbleSentence> cards = new List();
  //Map<Map<String,String>,String> mp=new Map();
  String topic;
  int index, length;
  bool isPressed;
  int iterative = 1;
  int _value = 0;
  int solved = 0;
  String value = "";
  _jumbleSentenceViewState({this.cards, this.topic});
  //List<jumbleSentence> val;
  JumbledController fbc;

  int temp = 0;
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

  // void getQuestion() {
  //   val = new List();

  //   String question = "full night is dark of terror and the hey bro";
  //   List<String> questionPart = question.split(' ');
  //   String correctAns = "hey bro the night is dark and full of terror";
  //   List<String> correctPart = correctAns.split(' ');
  //   jumbleSentence jS =
  //       new jumbleSentence(question, questionPart, correctAns, correctPart);
  //   val.add(jS);
  // }

  @override
  void initState() {
    super.initState();

    index = 0;
    isPressed = false;
    isLoading = true;
    //isLoading = false;
    //getQuestions();

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

  void hardCode(MainModel model) {
    //model.setJumbledSentences = new List();
    model.setVal = new List();
    String question = "";
    List<String> questionPart = [" the world","the world","the world"
            " is the largest sea"," is the largest sea",
            "Cox's Bazar",
            " beach in"];
    String correctAns = "Cox's Bazar is the largest sea beach in the world";
    List<String> correctPart = [" the world","the world","the world"
            " is the largest sea"," is the largest sea",
            "Cox's Bazar",
            " beach in"];

    model.getVal.add(new jumbleSentence(
        question, questionPart, correctAns, correctPart, 1, 2));

    String question1 = "";
    List<String> questionPart1 = [ " rather",
            " die than",
            "I would",
            " telling lie"];
    String correctAns1 = "I would rather die than telling lie";
    List<String> correctPart1 = [ " rather",
            " die than",
            "I would",
            " telling lie"];
    model.getVal.add(new jumbleSentence(
        question1, questionPart1, correctAns1, correctPart1, 2, 2));

        
    String question3 = "";
    List<String> questionPart3 = [ " let the",
            " man be born",
            "Kill the boy"];
    String correctAns3= "Kill the boy let the man be born";
    List<String> correctPart3= [ " let the",
            " man be born",
            "Kill the boy"];
    model.getVal.add(new jumbleSentence(
        question3, questionPart3, correctAns3, correctPart3, 2, 2));

    String question4 = "";
    List<String> questionPart4 = [ " the largest",
            "Sundarbans is",
            " mangrove forest"];
    String correctAns4= "Sundarbans is the largest mangrove forest";
    List<String> correctPart4= [ " the largest",
            "Sundarbans is",
            " mangrove forest"];
    model.getVal.add(new jumbleSentence(
        question4, questionPart4, correctAns4, correctPart4, 2, 2));

    String question5 = "";
    List<String> questionPart5 = [  " healer",
            " a great",
            "Time is"];
    String correctAns5= "Time is a great healer";
    List<String> correctPart5= [  " healer",
            " a great",
            "Time is"];
    model.getVal.add(new jumbleSentence(
        question5, questionPart5, correctAns5, correctPart5, 2, 2));

    length = model.getVal.length;
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
            model.jumbledSolution = new List();
            model.jumbledTempStore = new List();
            getQuestions(model);
            //hardCode(model);
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
                      //right: 20,
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
                      top: 144,
                      bottom: 143,
                      left: 20,
                      right: 20,
                      child: cardMovement(context, model)),

                  Positioned(
                    top: 675,
                    //bottom: 0,
                    left: 20,
                    width: 345,
                    height: 63,
                    child: RaisedButton(
                      onPressed: () {
                        isPressed = true;
                        if (timerString != "0:00") {
                          animationController.forward().whenComplete(() {
                            setState(() {
                              iterative++;
                              animationController.reset();
                              if (isLoading == false)
                                //FbGap removedCard = val.removeAt(0);
                                model.getVal.removeAt(0);

                              //model.val.removeAt(0);
                              //cards.add(removedCard);
                              isPressed = false;

                              if (iterative > length) {
                                iterative--;
                                animationCounter.stop();
                                //animationCounter.
                                dialogBoxShown();
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
                            top: 18,
                            bottom: 28,
                            left: 122.5,
                            child: Text(
                              "Get next",
                              style: TextStyle(
                                fontSize: 15,
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
      //             child: FillTheGapsStats(card, getAnswer, isLoading))));
      //   }
      // }).toList());
      return ProgressHUD(
        child: Container(),
        inAsyncCall: true,
        opacity: 0.0,
      );
    } else {
      return Stack(
          children: model.getVal.reversed.map((car) {
        if (model.getVal.indexOf(car) < length) {
          return (Transform.translate(
              offset: moveValue(car, model),
              child: Transform.rotate(
                  angle: rotateValue(car, model),
                  child: jumbleSentenceStats(car, _scaffoldKey))));
          //child: jumbleSentenceStats(car, getAnswer, isLoading))));
        }
      }).toList());
    }
  }

  Future<bool> dialogBoxShown() {
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text(" Do you want to continue?"),
              actions: <Widget>[
                FlatButton(
                  child: Text("Yes"),
                  onPressed: () => Navigator.of(context)
                      .pushReplacementNamed("/jumbledSentence"),
                ),
                FlatButton(
                  child: Text("No"),
                  //onPressed: () => Navigator.pop(context, false),
                  onPressed: () {
                    //dispose();
                    //fbc.deleteTopic();
                    Navigator.of(context).pushReplacementNamed("/home");
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
                  onPressed: () => Navigator.of(context)
                      .pushReplacementNamed("/jumbledSentence"),
                ),
                FlatButton(
                  child: Text("No"),
                  onPressed: () {
                    // dispose();
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
    if (model.getVal.indexOf(card) == 0 && isPressed)
      return _moveOutOfTheScreen.value;
    return Offset(0.0, 0.0);
  }

  double rotateValue(card, MainModel model) {
    if (model.getVal.indexOf(card) == 0 && isPressed) return _rotate.value;
    return 0.0;
  }

  void getQuestions(MainModel model) async {
    fbc = new JumbledController();
    //fbc.deleteTopic();
    //int i=int.parse(topic);
    //print(topic);
    //print(i);
    //fbc.deleteTopic();
    //print("In getQuestions: topic="+topic);
    //fbc.getSMList(TOKEN, topic).then((qsList) {
    fbc.getSMList(model.user.token, 1).then((qsList) {
      setState(() {
        //print("In then");
        animationCounter.reverse(
            from: animationCounter.value == 0 ? 1 : animationCounter.value);

        //_options = new Map<String, String>();
        model.setVal = new List();
        String question;
        //List<String>questionPart=question.split(' ');
        String correctAns;

        //jumbleSentence jS=new jumbleSentence(question, questionPart, correctAns, correctPart);
        //val.add(jS);
        List<String> options = new List();
        // List<String> correctAns = new List();

        for (int i = 0; i < qsList.length; i++) {
          // List<String> correctAns = new List();
          options = qsList.elementAt(i).segments;
          correctAns = qsList.elementAt(i).englishSentence;
          List<String> correctPart = correctAns.split(' ');
          model.getVal.add(new jumbleSentence(
              "",
              options,
              correctAns,
              correctPart,
              qsList.elementAt(i).taskId,
              qsList.elementAt(i).specificTaskId));
          print(model.getVal.elementAt(i).question);
          print(model.getVal.elementAt(i).getQuestionPart.toString());
          print(model.getVal.elementAt(i).getCorrectSentence.toString());
          if (i == qsList.length - 1) isLoading = false;
        }

        length = model.getVal.length;
      });
    });
  }
}
