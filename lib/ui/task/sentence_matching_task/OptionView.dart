import 'dart:async';
import 'package:Dimik/data/controller/score_update.dart';
import 'package:Dimik/models/score_update.dart';
import 'package:Dimik/ui/task/sentence_matching_task/TaskElement.dart';
import 'package:flutter/material.dart';
import './EmptyOptionView.dart';
import 'package:scoped_model/scoped_model.dart';
import '../../../ScopedModel/mainmodel.dart';
import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';

class OptionView extends StatefulWidget {
  TaskElementSM _text;
  final double _distanceFromTop;
  final TaskElementSM _acceptText;
  bool isDisabled = false;
  ScoreUpdateController scoreC = new ScoreUpdateController();
  GlobalKey<ScaffoldState> scaffoldKey;

  OptionView(
      this._text, this._acceptText, this._distanceFromTop, this.scaffoldKey);

  @override
  State<StatefulWidget> createState() {
    return _OptionViewState();
  }
}

class _OptionViewState extends State<OptionView> {
  Color buttonColor = Colors.white;
  AudioPlayer audioPlayer;
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

  void CorrectAnswer(MainModel model) {
    setState(() {
      disableAll();
    });
    successAudio();
    widget.scaffoldKey.currentState
        .showBottomSheet<Null>((BuildContext context) {
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
                  model.explanationSM[0],
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
  }

  void WrongAnswer(MainModel model) {
    setState(() {
      disableAll();
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
                  model.explanationSM[0],
                  style: TextStyle(color: Colors.white),
                ),
              ),
              Positioned(
                top: MediaQuery.of(context).size.height * 0.10,
                left: MediaQuery.of(context).size.width * 0.40,
                child: FlatButton(
                  child: Text(
                    'Wrong Answer!',
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
  }


  @override
  Widget build(BuildContext context) {
    //print(widget._text);

    return ScopedModelDescendant(
      builder: (BuildContext context, Widget child, MainModel model) {
        return Positioned(
          top: widget._distanceFromTop,
          left: 20,
          right: 20,
          height: 63,
          child: _manageButtonState(model),
        );
      },
    );
  }

  Widget _manageButtonState(MainModel model) {
    // if(widget.isLoaded == true)
    //   widget.isDisabled = false;
    // else
    //   widget.isDisabled = true;

    if (widget.isDisabled == true || model.smIsLoaded == false) {
      return RaisedButton(
        onPressed: () {},
        child: //Text(widget._text, style: TextStyle(fontSize: 15, /*color: Color(0x2E303E)*/), textAlign: TextAlign.center,),
            showLoadOrSentence(model),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        disabledElevation: 0.3,
        //disabledColor: Colors.blueGrey,
        disabledColor: Color(0xffA9A9A9),
      );
    }

    return Draggable<OptionView>(
      //data: widget._text,
      data: widget,
      child: DragTarget(
        builder: (context, accepted, rejected) => RaisedButton(
              onPressed: () {},
              child: Text(
                widget._text.sentence,
                style: TextStyle(
                  fontSize: 15, /*color: Color(0x2E303E)*/
                ),
                textAlign: TextAlign.center,
              ), //showLoadOrSentence(),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)),
              //textColor: Colors.white,
              //highlightColor: Colors.red,
              color: buttonColor,
              elevation: 1,
              //highlightElevation: 0.5,
            ),
        onAccept: (OptionView dragged) {
          //print(dragged._text);
          // if( SentenceMatchingView.time != "0:00"){
          String prevText = widget._text.sentence;
          setState(() {
            if (dragged._text.sentence == widget._acceptText.sentence) {
              model.smSolved = model.smSolved + 1;
              widget._text.sentence += (" " + dragged._text.sentence);
              buttonColor = Colors.green;
              dragged.isDisabled = true;
              CorrectAnswer(model);
              
              ScoreUpdate score = ScoreUpdate(model.currentTopic.id, widget._text.taskID, widget._text.specificTaskID, 1);
              widget.scoreC.postVerdict(model.user.token, score);
              print(widget._text.specificTaskID);
              
            } else {
              buttonColor = Colors.red;
              WrongAnswer(model);
              ScoreUpdate score = ScoreUpdate(model.currentTopic.id, widget._text.taskID, widget._text.specificTaskID, 0);
              ScoreUpdate score2 = ScoreUpdate(model.currentTopic.id, dragged._text.taskID, dragged._text.specificTaskID, 0);
              widget.scoreC.postVerdict(model.user.token, score);
              widget.scoreC.postVerdict(model.user.token, score2);
              print(widget._text.specificTaskID);
              print(dragged._text.specificTaskID);
            }
          });
          Timer(Duration(milliseconds: 700), () {
            setState(() {
              buttonColor = Colors.white;
              //print("prev: "+prevText+" text: "+widget._text);

              if (prevText != widget._text.sentence) {
                widget._text.sentence = prevText;
                widget.isDisabled = true;
              }
            });
          });
          //}
        },
      ),
      feedback: Container(
          width: 320,
          height: 63,
          child: RaisedButton(
              onPressed: () {},
              child: Text(
                widget._text.sentence,
                style: TextStyle(
                  fontSize: 15, /*color: Color(0x2E303E)*/
                ),
                textAlign: TextAlign.center,
              ),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)),
              //textColor: Colors.white,
              //highlightColor: Colors.red,
              color: Colors.white,
              elevation: 1
              //highlightElevation: 0.5,
              )),

      childWhenDragging: EmptyOptionView(widget._distanceFromTop),
      onDragCompleted: () {
        if (widget.isDisabled == true) {
          setState(() {});
        }
      },
    );
  }

  Widget showLoadOrSentence(MainModel model) {
    if (model.smIsLoaded == true)
      return Text(
        widget._text.sentence,
        style: TextStyle(
          fontSize: 15, /*color: Color(0x2E303E)*/
        ),
        textAlign: TextAlign.center,
      );

    return CircularProgressIndicator(
      strokeWidth: 3.0,
      valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
    );
  }
}
