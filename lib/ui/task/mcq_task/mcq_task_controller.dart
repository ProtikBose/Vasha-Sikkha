import 'package:Dimik/databaseChange/mcqData.dart';
import 'package:Dimik/models/mcq.dart';
import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:Dimik/ScopedModel/mainmodel.dart';

class controllerClass extends StatefulWidget {
  //Map<Map<String, String>, String> title = new Map();
  MCQDataBase title;
  //final Function getFunc;
  //final bool isLoaded;
  GlobalKey<ScaffoldState> scaffoldKey;
  //String value = "Solved";
  controllerClass({this.title, this.scaffoldKey});
  @override
  State<StatefulWidget> createState() {
    return controllerCLassState(title: title, scaffoldKey: scaffoldKey);
  }
}

class controllerCLassState extends State<controllerClass> {
  MCQDataBase title;
  AudioPlayer audioPlayer;
  int countVal;
  MCQ mcq;
  bool _sent_verdict = false;
  //final Function getFunc;
  //final bool isLoaded;
  GlobalKey<ScaffoldState> scaffoldKey;
  controllerCLassState({this.title, this.scaffoldKey});
  String question = "";
  String options;
  List<String> correctAns = new List();
  String option1, option2, option3, option4;

  //Color colo1,colo2,colo3,color4;
  Color colo1 = Colors.white;
  Color colo2 = Colors.white;
  Color colo3 = Colors.white;
  Color colo4 = Colors.white;
  Color Red = Color(0xFFFF8383);
  Color Green = Color(0xFF53C36F);

  //bool isButtonDIsabled=true;
  List<bool> isButtonDIsabled = new List();
  TextEditingController txt = new TextEditingController();

  void makingTheFormation() {
    question = title.question;
    //print(question);

    for (int i = 0; i < title.correctAns.length; i++)
      correctAns.add(title.correctAns.elementAt(i));
    for (int i = 0; i < 4; i++) isButtonDIsabled.add(false);
    //print(correctAns);

    option1 = title.getOption.elementAt(0);
    option2 = title.getOption.elementAt(1);
    option3 = title.getOption.elementAt(2);
    option4 = title.getOption.elementAt(3);
  }

  // void _onPressedButton(String value, int buttonNum) {
  //   if (value == correctAns && isButtonDIsabled) {
  //     String temp = "colo" + (buttonNum+1).toString();
  //     if (temp == "colo1") {
  //       setState(() {
  //         colo1 = Green;
  //       });
  //     } else if (temp == "colo2") {
  //       setState(() {
  //         colo2 = Green;
  //       });
  //     } else if (temp == "colo3") {
  //       setState(() {
  //         colo3 = Green;
  //       });
  //     } else if (temp == "colo4") {
  //       setState(() {
  //         colo4 = Green;
  //       });
  //     }
  //     isButtonDIsabled=false;
  //     print(temp);
  //     print("correctAns " + correctAns);
  //     print(value);
  //     //runCard();

  //     widget.getFunc(true);
  //   }
  //   else{
  //     String temp = "colo" + buttonNum;

  //     if (temp == "colo1" && isButtonDIsabled) {
  //       setState(() {
  //         colo1 = Red;
  //         question=value;
  //       });
  //     } else if (temp == "colo2" && isButtonDIsabled) {
  //       setState(() {
  //         colo2 = Red;
  //         question=value;
  //       });
  //     } else if (temp == "colo3" && isButtonDIsabled) {
  //       setState(() {
  //         colo3 = Red;
  //         question=value;
  //       });
  //     } else if (temp == "colo4" && isButtonDIsabled) {
  //       setState(() {
  //         colo4 = Red;
  //         question=value;
  //       });
  //     }
  //     print(option1);
  //     print(option2);
  //     print(option3);
  //     print(option4);
  //     print(correctAns);

  //     if (correctAns == option1 && isButtonDIsabled) {
  //       setState(() {
  //         colo1 = Green;
  //       });
  //     } else if (correctAns == option2 && isButtonDIsabled) {
  //       setState(() {
  //         colo2 = Green;
  //       });
  //     } else if (correctAns == option3 && isButtonDIsabled) {
  //       setState(() {
  //         colo3 = Green;
  //       });
  //     } else if (correctAns == option4 && isButtonDIsabled) {
  //       setState(() {
  //         colo4 = Green;
  //       });

  //     }
  //     isButtonDIsabled=false;
  //    widget.getFunc(false);

  //   }
  //   //ChangeText();
  // }

  void _onPressedButton(String value, int buttonNum, MainModel model) {
    if (correctAns.contains(value) && !isButtonDIsabled[buttonNum]) {
      String temp = "colo" + (buttonNum + 1).toString();
      if (temp == "colo1") {
        setState(() {
          colo1 = Green;
        });
      } else if (temp == "colo2") {
        setState(() {
          colo2 = Green;
        });
      } else if (temp == "colo3") {
        setState(() {
          colo3 = Green;
        });
      } else if (temp == "colo4") {
        setState(() {
          colo4 = Green;
        });
      }
      isButtonDIsabled[buttonNum] = true;
      //widget.getFunc(true);
      getAnswer(true, model, value);
    } else if (!correctAns.contains(value) && !isButtonDIsabled[buttonNum]) {
      String temp = "colo" + (buttonNum + 1).toString();

      if (temp == "colo1" && !isButtonDIsabled[buttonNum]) {
        setState(() {
          colo1 = Red;
          question = value;
        });
      } else if (temp == "colo2" && !isButtonDIsabled[buttonNum]) {
        setState(() {
          colo2 = Red;
          question = value;
        });
      } else if (temp == "colo3" && !isButtonDIsabled[buttonNum]) {
        setState(() {
          colo3 = Red;
          question = value;
        });
      } else if (temp == "colo4" && !isButtonDIsabled[buttonNum]) {
        setState(() {
          colo4 = Red;
          question = value;
        });
      }
      isButtonDIsabled[buttonNum] = true;
      //widget.getFunc(false);
      getAnswer(false, model, value);
    }
  }

  Future successAudio() async {
    audioPlayer = await AudioCache().play("audios/success.mp3");
  }

  Future errorAudio() async {
    audioPlayer = await AudioCache().play("audios/error.mp3");
  }

  void CorrectAnswer(/*int i,String corVal*/ String value) {
    setState(() {
      //disableAll();
      //quesPart[i]=corVal;
      //flag[i]=true;
    });
    successAudio();
    widget.scaffoldKey.currentState
        .showBottomSheet<Null>((BuildContext context) {
      return ScopedModelDescendant<MainModel>(
          builder: (BuildContext context, Widget child, MainModel model) {
        if (!_sent_verdict && countVal == title.getCorrect.length) {
          model.postVerdict(mcq, 1);
          _sent_verdict = true;
        }
        model.mcqcorrect = model.mcqcorrect + 1;
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
                    //widget._pictureWord.explanation,
                    "\" " + value + " \"" + "  is correct !!!!",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontFamily: 'RobotoMono'),
                  ),
                ),
                Positioned(
                  top: MediaQuery.of(context).size.height * 0.10,
                  left: MediaQuery.of(context).size.width * 0.40,
                  child: FlatButton(
                    child: Text(
                      'Got It',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
              ],
            ));
      });
    });
  }

  void WrongAnswer(/*int i,String corVal*/ String value) {
    setState(() {
      //disableAll();
      //flag[i]=false;
    });
    errorAudio();
    widget.scaffoldKey.currentState
        .showBottomSheet<Null>((BuildContext context) {
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
                  //widget._pictureWord.explanation,
                  "\" " + value + " \"" + "  is wrong !!!!",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontFamily: 'RobotoMono'),
                ),
              ),
              Positioned(
                top: MediaQuery.of(context).size.height * 0.10,
                left: MediaQuery.of(context).size.width * 0.40,
                child: FlatButton(
                  child: Text(
                    'Got It',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ],
          ));
    });
  }

  void getAnswer(
      bool value, MainModel model, String val /*,int i,String corVal*/) {
    Color color = Colors.red;
    String text = "Wrong Answer!";

    if (value == true /*&& timerString != "0:00"*/) {
      color = Colors.green;
      // solved++;
      // quesPart[i]=corVal;
      model.fbcorrect = model.fbcorrect + 1;
      text = "Correct Answer!";
      countVal++;
      CorrectAnswer(/*i,corVal*/ val);
    } else {
      WrongAnswer(/*i,corVal*/ val);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    countVal = 0;
    mcq = new MCQ.fromParam(
        question: title.getQuestion,
        option: title.getOption,
        answer: title.getCorrect,
        taskName: "MCQ",
        taskId: title.taskID,
        specificTaskId: title.specifiTtaskID,
        explanation: title.explanationString);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    makingTheFormation();
    return ScopedModelDescendant<MainModel>(
        builder: (BuildContext context, Widget child, MainModel model) {
      return Card(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
        child: Stack(
          children: <Widget>[
            Positioned(
              top: MediaQuery.of(context).size.height * (40 / 453),
              left: MediaQuery.of(context).size.width * (20 / 320),
              right: MediaQuery.of(context).size.width * (.1 / 320),
              //width: 280,
              //height: 70,
              child: Text(
                "$question",
                style: TextStyle(
                    fontSize: 25,
                    //fontFamily: ,
                    letterSpacing: -0.654545),
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height * (139.63 / 453),
              left: MediaQuery.of(context).size.width * (20 / 320),
              width: MediaQuery.of(context).size.height * (54 / 320),
              height: MediaQuery.of(context).size.height * (30 / 320),
              child: RaisedButton(
                onPressed: () {
                  _onPressedButton(option1, 0, model);
                  setState(() {});
                },
                child: Text(
                  option1,
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(23)),
                //textColor: Colors.white,
                //highlightColor: Colors.red,
                color: colo1,
                elevation: 10,
                //highlightElevation: 0.5,
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height * (139.63 / 453),
              right: MediaQuery.of(context).size.width * (20 / 320),
              width: MediaQuery.of(context).size.height * (54 / 320),
              height: MediaQuery.of(context).size.height * (30 / 320),
              child: RaisedButton(
                onPressed: () {
                  _onPressedButton(option2, 1, model);
                },
                child: Text(
                  option2,
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(23)),
                //textColor: Colors.white,
                //highlightColor: Colors.red,
                color: colo2,
                elevation: 10,
                //highlightElevation: 0.5,
              ),
            ),
            Positioned(
              bottom: MediaQuery.of(context).size.height * (30 / 453),
              left: MediaQuery.of(context).size.width * (20 / 320),
              width: MediaQuery.of(context).size.height * (54 / 320),
              height: MediaQuery.of(context).size.height * (30 / 320),
              child: RaisedButton(
                onPressed: () {
                  _onPressedButton(option3, 2, model);
                },
                child: Text(
                  option3,
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(23)),
                //textColor: Colors.white,
                //highlightColor: Colors.red,
                color: colo3,
                elevation: 10,
                //highlightElevation: 0.5,
              ),
            ),
            Positioned(
              bottom: MediaQuery.of(context).size.height * (30 / 453),
              right: MediaQuery.of(context).size.width * (20 / 320),
              width: MediaQuery.of(context).size.height * (54 / 320),
              height: MediaQuery.of(context).size.height * (30 / 320),
              child: new RaisedButton(
                onPressed: () {
                  _onPressedButton(option4, 3, model);
                },
                child: Text(
                  option4,
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(23)),
                //textColor: Colors.white,
                //highlightColor: Colors.red,
                color: colo4,

                elevation: 10,
                //highlightElevation: 0.5,
              ),
            ),
          ],
        ),
      );
    });
  }
}
