import 'package:Dimik/ScopedModel/jumbled_model.dart';
import 'package:Dimik/models/jumbled_sentence.dart';
import 'package:Dimik/ui/task/jumble_Sentence/jumbleSentenceButtonDrag.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'dart:async';
import '../jumble_Sentence/jumbleSentenceDrag.dart';
import 'package:Dimik/databaseChange/jumbleSentence.dart';
import 'package:Dimik/ScopedModel/mainmodel.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';

class dragableFGJum extends StatefulWidget {
  bool isDisAbled = false;
  jumbleSentence title;
  GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  //final Function getFunc;
  //final bool isLoaded;
  //dragableFG({this.title, this.getFunc, this.isLoaded});
  dragableFGJum({this.title, this.scaffoldKey});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return dragableFGStats(title: title, scaffoldKey: scaffoldKey);
  }
}

class dragableFGStats extends State<dragableFGJum> {
  jumbleSentence title;
  AudioPlayer audioPlayer;
  Jumbled jumbled;
  bool _sent_verdict=false;
  //final Function getFunc;
  GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  dragableFGStats({this.title, this.scaffoldKey});
  Color buttonColor = Colors.white;
  List<String> quesPart = new List();
  //String question = "String String String # String String # String String";
  String question;
  //int partition = 5;

  // List<String> Option = [
  //   'Honululu',
  //   'Madagaskar',
  //   'South Africa',
  //   'Bangladesh',
  //   'West Indies',
  //   'Pakistan'
  // ];
  List<String> Option = new List();
  List<String> questionPart = new List();
  List<String> correctPart = new List();
  //List<String> CorrectAns = new List();
  String correctSentence;
  List<int> correctButtonPosition = new List();
  List<String> correct = new List();
  String tempString = "";
  List<bool> flag = new List();
  List<bool> flagGaps = new List();
  int length;

  void getElement() {
    //question = title.getQuestion;
    Option = title.getQuestionPart;
    questionPart = title.getQuestionPart;
    correctPart = title.getCorrect;
    length = correctPart.length;
    print("Solution : " + title.correctSentence);
    //Option = title.getCorrect;
    for (int i = 0; i < length; i++) correctButtonPosition.add(0);
    for (int i = 0; i < length; i++) quesPart.add("__________");
    for (int i = 0; i < length; i++) flag.add(false);
    for (int i = 0; i < length; i++) flagGaps.add(false);
    //for(int i=0;i<question)
    //CorrectAns = title.getCorrect;
    correctSentence = title.getCorrectSentence;
  }

  void makeCorrectPositionSaved(int pos) {
    correctButtonPosition[pos] = 1;
    print("in");
    print(pos);
    //drawButton(context);
  }

  void showBottleSheet() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            color: Color.fromARGB(3, 0, 255, 0),
            //Colors.withOpacity(0.3),
            height: 100,
            child: Center(
                child: Text(
              "check",
              style: TextStyle(fontSize: 30, color: Colors.red),
            )),
          );
        });
  }

  // void questionPartitioning() {
  //   List<String> temp = new List();
  //   int i = 0;

  //   while (i < question.length) {
  //     if (question[i] != '#') {
  //       String t = "";
  //       while (question[i] != '#') {
  //         t += question[i];
  //         i++;
  //         if (i >= question.length) break;
  //         //print(t);
  //       }
  //       temp.add(t);
  //     } else {
  //       temp.add('#');
  //       i++;
  //     }
  //   }

  //   int tempCount = 0;
  //   for (int i = 0; i < Option.length; i++) {
  //     if (Option.elementAt(i).length > tempCount) {
  //       tempCount = Option.elementAt(i).length;
  //     }
  //   }

  //   for (int i = 0; i < temp.length; i++) {
  //     if (temp.elementAt(i).contains("#")) {
  //       String str = "";
  //       for (int j = 0; j < tempCount; j++) {
  //         str += '_';
  //       }
  //       for (int j = 0; j < tempCount; j++) {
  //         str += '_';
  //       }
  //       quesPart.add(str);
  //       //print(temp.elementAt(i));
  //     } else {
  //       quesPart.add(temp.elementAt(i));
  //       //print(temp.elementAt(i));
  //     }
  //   }
  // }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getElement();

    for (int i = 0; i < length; i++) {
      correct.add("");
    }
    jumbled = new Jumbled.fromParam(
        question: title.getQuestion,
        option: title.getQuestionPart,
        answer: title.getCorrectSentence,
        taskName: "Jumbled Sentence",
        taskId: title.taskID,
        specificTaskId: title.specifiTtaskID,
        );
    //questionPartitioning();
  }

  void checkSolution(MainModel model) {
    int flag = 0;
    String str = "";
    for (int i = 0; i < length; i++) {
      // if(correct[i]==correctPart[i]){
      //   continue;
      // }
      // else flag=1;
      str = str + correct[i];
      str = str.replaceAll(" ", "");
      str = str.toLowerCase();
    }
    String str2 = title.getCorrectSentence.replaceAll(" ", "");
    str2 = str2.toLowerCase();
    print("String One : " + str);
    print("String Two : " + str2);
    if (str == str2) {
      flag = 0;
    } else
      flag = 1;

    if (flag == 1)
      getAnswer(false, model);
    else
      getAnswer(true, model);
  }

  void captureCorrect(String str, int pos, MainModel model) {
    correct[pos] = str;
    print(correct[pos]);
    print(correctPart[pos]);
    print(pos);
    //showBottleSheet();
    int flag1 = 0, flag2 = 0;
    for (int i = 0; i < length; i++) {
      if (correct[i] == "") flag1 = 1;
    }
    if (flag1 == 0) {
      checkSolution(model);
    }
  }

  Future successAudio() async {
    audioPlayer = await AudioCache().play("audios/success.mp3");
  }

  Future errorAudio() async {
    audioPlayer = await AudioCache().play("audios/error.mp3");
  }

  void CorrectAnswer(/*int i,String corVal*/) {
    setState(() {
      //disableAll();
      //quesPart[i]=corVal;
      //flag[i]=true;
      for (int i = 0; i < length; i++) flag[i] = true;
      for (int i = 0; i < length; i++) flagGaps[i] = true;
      for (int i = 0; i < length; i++) quesPart[i] = correct[i];
    });
    successAudio();
    widget.scaffoldKey.currentState
        .showBottomSheet<Null>((BuildContext context) {
          return ScopedModelDescendant<MainModel>(
          builder: (BuildContext context, Widget child, MainModel model) {
            if (!_sent_verdict ) {
          model.postVerdict(jumbled, 1);
          _sent_verdict = true;
        }
          model.jumbledcorrect=model.jumbledcorrect+1;
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
                  
                      title.correctSentence ,
                      
                      
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
                    Navigator.of(context).pop();
                  },
                ),
              ),
            ],
          ));});
    });
  }

  void WrongAnswer(/*int i,String corVal*/) {
    setState(() {
      //disableAll();
      //flag[i]=false;
      for (int i = 0; i < length; i++) flag[i] = true;
      for (int i = 0; i < length; i++) flagGaps[i] = true;
      for (int i = 0; i < length; i++) quesPart[i] = correct[i];
    });
    errorAudio();
    widget.scaffoldKey.currentState
        .showBottomSheet<Null>((BuildContext context) {
      return ScopedModelDescendant<MainModel>(
          builder: (BuildContext context, Widget child, MainModel model) {
            
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
                    
                        title.correctSentence 
                        ,
                        
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
    });
  }

  void getAnswer(bool value, MainModel model) {
    Color color = Colors.red;
    String text = "Wrong Answer!";

    if (value == true /*&& timerString != "0:00"*/) {
      color = Colors.green;
      //solved++;
      model.jumbledcorrect = model.jumbledcorrect + 1;
      text = "Correct Answer!";
      CorrectAnswer();
    } else {
      WrongAnswer();
    }

    // if (timerString != "0:00") {
    //   showModalBottomSheet(
    //       context: context,
    //       builder: (context) {
    //         return Container(
    //           color: //Color.fromARGB(3, 0, 255, 0),
    //               color.withOpacity(0.3),
    //           height: 100,
    //           child: Center(
    //               child: Text(
    //             text,
    //             style: TextStyle(fontSize: 30, color: color),
    //           )),
    //         );
    //       });
    // }
  }

  //List<String> CorrectAns = ['Madagaskar', 'South Africa'];

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    // if (widget.isLoaded == true) {
    //   return CircularProgressIndicator(
    //     strokeWidth: 3.0,
    //     valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
    //   );
    // }
    return ScopedModelDescendant<MainModel>(
        builder: (BuildContext context, Widget widget, MainModel model) {
      if (model.getIsLoaded == true) {
        return CircularProgressIndicator(
          strokeWidth: 3.0,
          valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
        );
      }

      return Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
          child: Stack(
            children: <Widget>[
              Positioned(
                  //left: 200,
                  //top: 10,
                  top: MediaQuery.of(context).size.height*(40/746),
                  //bottom: 270,
                  left: MediaQuery.of(context).size.width*.01,
                  right: MediaQuery.of(context).size.width*.01,
                  child: Container(
                      padding: EdgeInsets.only(left: 30, right: 20),
                      width: MediaQuery.of(context).size.width,
                      child: Wrap(
                        // spacing: 8.0,
                        //runSpacing: 4.0,
                        //children: drawQuestion(context)

                        children: drawQuestion(context),
                      )
                      //Text("data")

                      )),
              Positioned(
                  top: MediaQuery.of(context).size.height*(200/746),
                  left: MediaQuery.of(context).size.width*.01,
                  right: MediaQuery.of(context).size.width*.001,
                  child: Container(
                    padding: EdgeInsets.only(left: 30, right: 30, top: 70),
                    width: MediaQuery.of(context).size.width,
                    child: Wrap(
                      spacing: 8.0,
                      runSpacing: 4.0,
                      children: drawButton(context),
                    ),
                  ))
            ],
          ));
    });
  }

  Color colorChange(int pos) {
    List<Color> colorList = [Colors.white, Colors.green, Colors.red];
    return colorList.elementAt(pos);
  }

  List<Widget> drawQuestion(BuildContext context) {
    //getElement();
    //questionPartitioning();
    List<Widget> tiles = new List();

    for (int i = 0; i < correctPart.length; i++) {
      tiles.add(
        DragGapsView(quesPart[i], i, 0, getAnswer, captureCorrect, flagGaps[i]),
      );
    }

    return List<Widget>.generate(quesPart.length, (i) {
      return tiles.elementAt(i);
    });
  }

  List<Widget> drawButton(BuildContext context) {
    List<Widget> tiles = new List();

    for (int i = 0; i < length; i++) {
      tiles.add(DragGapsButtonView(Option.elementAt(i), flag[i]));
    }

    return List<Widget>.generate(length, (i) {
      return tiles.elementAt(i);
    });
  }
}
