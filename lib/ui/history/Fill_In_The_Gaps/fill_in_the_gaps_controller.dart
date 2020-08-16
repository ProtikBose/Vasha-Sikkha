import 'package:flutter/material.dart';
import 'dart:async';
//import '../Fill_in_the_gaps/draggableFbButton.dart';
import 'package:Dimik/databaseChange/FBGapData.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:Dimik/ScopedModel/mainmodel.dart';

class dragableFG extends StatefulWidget {
  bool isDisAbled = false;
  FbGap title;
  final Function getFunc;
  final bool isLoaded;
  int positionNumber;
  dragableFG({this.title, this.getFunc, this.isLoaded, this.positionNumber});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return dragableFGStats(
        title: title, getFunc: getFunc, positionNumber: positionNumber);
  }
}

class dragableFGStats extends State<dragableFG> {
  FbGap title;
  List<String> solutionSolvedCorrectly = new List();
  int positionNumber;
  final Function getFunc;
  dragableFGStats({this.title, this.getFunc, this.positionNumber});
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
  List<String> CorrectAns = new List();
  List<int> correctButtonPosition = new List();

  void getElement() {
    question = title.getQuestion;
    Option = title.getOption;
    for (int i = 0; i < Option.length; i++) correctButtonPosition.add(0);
    CorrectAns = title.getCorrect;
  }

  void makeCorrectPositionSaved(int pos) {
    correctButtonPosition[pos] = 1;
    print("in");
    print(pos);
    solutionSolvedCorrectly.add(Option[pos]);
    //print("Check kortesi :"+Option[pos]);
    //drawButton(context);
  }

  void questionPartitioning() {
    List<String> temp = new List();
    int i = 0;

    while (i < question.length) {
      if (question[i] != '#') {
        String t = "";
        while (question[i] != '#') {
          t += question[i];
          i++;
          if (i >= question.length) break;
          //print(t);
        }
        temp.add(t);
      } else {
        temp.add('#');
        i++;
      }
    }

    int tempCount = 0;
    for (int i = 0; i < Option.length; i++) {
      if (Option.elementAt(i).length > tempCount) {
        tempCount = Option.elementAt(i).length;
      }
    }

    for (int i = 0; i < temp.length; i++) {
      if (temp.elementAt(i).contains("#")) {
        String str = "";
        for (int j = 0; j < tempCount; j++) {
          str += '_';
        }
        for (int j = 0; j < tempCount; j++) {
          str += '_';
        }
        quesPart.add(str);
        //print(temp.elementAt(i));
      } else {
        quesPart.add(temp.elementAt(i));
        //print(temp.elementAt(i));
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getElement();
    questionPartitioning();
  }

  //List<String> CorrectAns = ['Madagaskar', 'South Africa'];

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    if (widget.isLoaded == true) {
      return CircularProgressIndicator(
        strokeWidth: 3.0,
        valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
      );
    }
    return ScopedModelDescendant<MainModel>(
        builder: (BuildContext context, Widget child, MainModel model) {
      return Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
          child: Stack(
            children: <Widget>[
              Positioned(
                  top: MediaQuery.of(context).size.height * (40 / 453),
                  //bottom: 270,
                  left: MediaQuery.of(context).size.width * (7 / 320),
                  right: MediaQuery.of(context).size.width * (.1 / 320),
                  child: Container(
                      padding: EdgeInsets.only(
                          left: MediaQuery.of(context).size.width * (18 / 320),
                          right:
                              MediaQuery.of(context).size.width * (18 / 320)),
                      width: MediaQuery.of(context).size.width,
                      child: Wrap(
                        // spacing: 8.0,
                        //runSpacing: 4.0,
                        //children: drawQuestion(context)

                        children: drawQuestion(context, model),
                      )
                      //Text("data")

                      )),
              Positioned(
                  top: MediaQuery.of(context).size.width * (150 / 453),
                  left: MediaQuery.of(context).size.width * (.1 / 320),
                  right: MediaQuery.of(context).size.width * (.1 / 320),
                  child: Container(
                    padding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width * (15 / 320),
                        right: MediaQuery.of(context).size.width * (15 / 320),
                        top: MediaQuery.of(context).size.height *
                            (300 / Option.length / 320)),
                    child: Wrap(
                      spacing: 8.0,
                      runSpacing: 4.0,
                      children: drawButton(context, model),
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

  List<Widget> drawQuestion(BuildContext context, MainModel model) {
    //getElement();
    //questionPartitioning();
    List<Widget> tiles = new List();
    List<int> gapsNumber = new List();
    List<Key> keyList = new List();
    Map<int, String> answerPos = new Map();

    for (int i = 0; i < CorrectAns.length; i++) {
      keyList.add(UniqueKey());
    }
    int pos = 0;
    print("Question part " + quesPart.length.toString());
    for (int i = 0; i < quesPart.length; i++) {
      if (quesPart.elementAt(i).contains('_')) {
        gapsNumber.add(1);
        answerPos[i] = CorrectAns.elementAt(pos);
        pos++;
      } else {
        gapsNumber.add(0);
      }
    }

    List<List<Color>> colorList = new List();

    for (int i = 0; i < quesPart.length; i++) {
      if (quesPart.elementAt(i).contains('_')) {
        // tiles.add(DragGapsView(quesPart.elementAt(i) + " ", answerPos[i], 0,
        //     getFunc, makeCorrectPositionSaved));
        if (model.fbSolution[positionNumber].option.contains(answerPos[i])) {
          tiles.add(Container(
              // child: FlatButton(
              //     onPressed: () {},
              //     color: Colors.green,

              //     //key: UniqueKey(),
              //     padding: EdgeInsets.only(left: 0.5, bottom: 100),

              //     //width: widget._text.length,
              //     child: Text(
              //       answerPos[i],
              //       //textAlign: TextAlign.left,
              //       style: TextStyle(
              //         fontSize: 15,
              //       ),
              //       //textAlign: TextAlign.left,
              //     ),
              //     shape: RoundedRectangleBorder(
              //         borderRadius: BorderRadius.circular(23)))
              padding: EdgeInsets.only(top: 5),
              child: Wrap(children: <Widget>[
                Wrap(
                  children: <Widget>[
                    Text(
                      answerPos[i],
                      style: TextStyle(
                          fontSize: 22,
                          color: Colors.green,
                          decoration: TextDecoration.underline),
                    )
                  ],
                )
              ])));
        } else {
          tiles.add(Container(
            padding: EdgeInsets.only(top: 5),
            // child: FlatButton(
            //     onPressed: () {},
            //     color: Colors.red,

            //     //key: UniqueKey(),
            //     padding: EdgeInsets.only(left: 0.5),

            //     //width: widget._text.length,
            //     child: Text(
            //       answerPos[i],
            //       //textAlign: TextAlign.left,
            //       style: TextStyle(
            //         fontSize: 15,
            //       ),
            //       //textAlign: TextAlign.left,
            //     ),
            //     shape: RoundedRectangleBorder(
            //         borderRadius: BorderRadius.circular(23)))
            child: Wrap(children: <Widget>[
              Wrap(
                children: <Widget>[
                  Text(
                    answerPos[i],
                    style: TextStyle(
                        fontSize: 22,
                        color: Colors.red,
                        decoration: TextDecoration.underline),
                  )
                ],
              )
            ]),
          ));
        }
      } else {
        tiles.add(new Container(
            padding: EdgeInsets.only(top: 5),
            //width: MediaQuery.of(context).size.width,
            child: Wrap(children: <Widget>[
              Wrap(
                children: <Widget>[
                  Text(
                    quesPart.elementAt(i),
                    style: TextStyle(fontSize: 22),
                  )
                ],
              )
            ])));
      }
    }
    return List<Widget>.generate(quesPart.length, (i) {
      return tiles.elementAt(i);
    });
  }

  List<Widget> drawButton(BuildContext context, MainModel model) {
    List<Widget> tiles = new List();

    for (int i = 0; i < Option.length; i++) {
      if (model.fbSolution[positionNumber].option.contains(Option[i])) {
        tiles.add(
          RaisedButton(
              onPressed: () {},
              //disabledColor: Colors.green,
              child: Text(
                Option.elementAt(i),
                style: TextStyle(
                  fontSize: 15, /*color: Color(0x2E303E)*/
                ),
                textAlign: TextAlign.center,
              ),
              //disabledColor: Colors.blue,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)),
              //textColor: Colors.white,
              //highlightColor: Colors.red,
              color: Colors.green,
              elevation: 1

              //highlightElevation: 0.5,
              ),
        );
      }
      else if(CorrectAns.contains(Option[i])){
        tiles.add(
          RaisedButton(
              onPressed: () {},
              //disabledColor: Colors.green,
              child: Text(
                Option.elementAt(i),
                style: TextStyle(
                  fontSize: 15, /*color: Color(0x2E303E)*/
                ),
                textAlign: TextAlign.center,
              ),
              //disabledColor: Colors.blue,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)),
              //textColor: Colors.white,
              //highlightColor: Colors.red,
              color: Colors.red,
              elevation: 1

              //highlightElevation: 0.5,
              ),
        );
      }
      else{
        tiles.add(
          RaisedButton(
              onPressed: () {},
              //disabledColor: Colors.green,
              child: Text(
                Option.elementAt(i),
                style: TextStyle(
                  fontSize: 15, /*color: Color(0x2E303E)*/
                ),
                textAlign: TextAlign.center,
              ),
              //disabledColor: Colors.blue,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)),
              //textColor: Colors.white,
              //highlightColor: Colors.red,
              color: Colors.white70,
              elevation: 1

              //highlightElevation: 0.5,
              ),
        );
      }
    }
    return List<Widget>.generate(Option.length, (i) {
      return tiles.elementAt(i);
    });
  }
}
