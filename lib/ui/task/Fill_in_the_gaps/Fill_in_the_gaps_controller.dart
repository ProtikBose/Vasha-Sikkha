import 'package:flutter/material.dart';

class controllerClass extends StatefulWidget {
  Map<Map<String, String>, String> title = new Map();
  final Function getFunc;
  String value="Solved";
  controllerClass({this.title,this.getFunc});
  @override
  State<StatefulWidget> createState() {
    return controllerCLassState(title: title);
  }
}

class controllerCLassState extends State<controllerClass> {
  Map<Map<String, String>, String> title = new Map();
  
  final Function getFunc;
  controllerCLassState({this.title,this.getFunc});
  String question = "";
  String options, correctAns;
  String option1, option2, option3, option4;

  //Color colo1,colo2,colo3,color4;
  Color colo1 = Colors.white;
  Color colo2 = Colors.white;
  Color colo3 = Colors.white;
  Color colo4 = Colors.white;
  Color Red = Color(0xFFFF8383);
  Color Green = Color(0xFF53C36F);

  bool isButtonDIsabled=true;

  TextEditingController txt=new TextEditingController();

  

  void makingTheFormation() {
    //String question,options,correctAns;
    List<Map<String, String>> temp = new List();
    List<String> option = new List();
    temp = title.keys.toList();
    
    //print(title);
    //print(temp);

    List<String> questionList = new List();
    questionList = temp[0].keys.toList();
    question = questionList[0];
    //print(question);

    List<String> optionList = new List();
    optionList = temp[0].values.toList();
    options = optionList[0];
    //print(options);
    List<String> correctAnsList = new List();
    correctAnsList = title.values.toList();
    correctAns = correctAnsList[0];
    //print(correctAns);

    option = options.split(',').toList();
    option1 = option[0];
    option2 = option[1];
    option3 = option[2];
    option4 = option[3];
  }

  

  void _onPressedButton(String value, String buttonNum) {
    if (value == correctAns && isButtonDIsabled) {
      String temp = "colo" + buttonNum;
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
      isButtonDIsabled=false;
      print(temp);
      print("correctAns " + correctAns);
      print(value);
      //runCard();
      
      widget.getFunc(widget.value);
    }
    else{
      String temp = "colo" + buttonNum;

      if (temp == "colo1" && isButtonDIsabled) {
        setState(() {
          colo1 = Red;
          question=value;
        });
      } else if (temp == "colo2" && isButtonDIsabled) {
        setState(() {
          colo2 = Red;
          question=value;
        });
      } else if (temp == "colo3" && isButtonDIsabled) {
        setState(() {
          colo3 = Red;
          question=value;
        });
      } else if (temp == "colo4" && isButtonDIsabled) {
        setState(() {
          colo4 = Red;
          question=value;
        });
      }

      if (correctAns == option1 && isButtonDIsabled) {
        setState(() {
          colo1 = Green;
        });
      } else if (correctAns == option2 && isButtonDIsabled) {
        setState(() {
          colo2 = Green;
        });
      } else if (correctAns == option3 && isButtonDIsabled) {
        setState(() {
          colo3 = Green;
        });
      } else if (correctAns == option4 && isButtonDIsabled) {
        setState(() {
          colo4 = Green;
        });
        
      }
      isButtonDIsabled=false;
    }
    //ChangeText();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    makingTheFormation();
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
      child: Stack(
        children: <Widget>[
          Positioned(
            top: 70,
            bottom: 270,
            left: 20,
            right: 20,
            //width: 280,
            //height: 70,
            child: Text(
              
              "$question",
              style: TextStyle(
                  fontSize: 30,
                  //fontFamily: ,
                  letterSpacing: -0.654545),
            ),
          ),
          Positioned(
            top: 237.63,
            left: 20,
            width: 132,
            height: 70,
            child: RaisedButton(
              onPressed: () {
                _onPressedButton(option1, "1");
                setState(() {
                  
                });
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
            top: 237.63,
            right: 20,
            width: 132,
            height: 70,
            child: RaisedButton(
              onPressed: () {
                _onPressedButton(option2, "2");
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
            bottom: 43.6,
            left: 20,
            width: 132,
            height: 70,
            child: RaisedButton(
              onPressed: () {
                _onPressedButton(option3, "3");
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
            bottom: 43.6,
            right: 20,
            width: 132,
            height: 70,
            child: new RaisedButton(
              onPressed: () {
                _onPressedButton(option4, "4");
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
  }
}
