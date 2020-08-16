import 'package:Dimik/ScopedModel/mainmodel.dart';
import 'package:Dimik/models/sentence_from_story.dart';
import 'package:flutter/material.dart';
import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:scoped_model/scoped_model.dart';

class SFSCard extends StatefulWidget {
  SFS sfsItem;
  GlobalKey<ScaffoldState> scaffoldKey;

  SFSCard({this.sfsItem, this.scaffoldKey});

  @override
  State<StatefulWidget> createState() {
    return SFSCardState();
  }
}

class SFSCardState extends State<SFSCard> {
  AudioPlayer audioPlayer;
  List<int> options = [];
  List<bool> disable = [];
  int correct_total;

  @override
  void initState() {
    for (int i = 0; i < widget.sfsItem.options.length; i++) {
      options.add(0);
      disable.add(false);
    }
    correct_total = widget.sfsItem.answers.length;
    super.initState();
  }

  Future successAudio() async {
    audioPlayer = await AudioCache().play("audios/success.mp3");
  }

  Future errorAudio() async {
    audioPlayer = await AudioCache().play("audios/error.mp3");
  }

  void disableAll() {
    for (int i = 0; i < widget.sfsItem.options.length; i++) {
      disable[i] = true;
    }
  }

  void CorrectAnswer() {
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
          height: MediaQuery.of(context).size.height * 0.18,
          child: Stack(
            children: <Widget>[
              Positioned(
                top: 20,
                left: 20,
                child: Text(
                  widget.sfsItem.explanation,
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

  void WrongAnswer() {
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
          height: MediaQuery.of(context).size.height * 0.18,
          child: Stack(
            children: <Widget>[
              Positioned(
                top: 20,
                left: 20,
                child: Text(
                  widget.sfsItem.explanation,
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

  void showCorrect() {
    for (int i = 0; i < widget.sfsItem.options.length; i++) {
      options[i] = 1;
    }
  }

  Widget optionCard(String option, int index) {
    bool correct = false;
    for (int i = 0; i < widget.sfsItem.answers.length; i++) {
      if (index + 1 == widget.sfsItem.answers[i]) {
        correct = true;
        break;
      }
    }
    return ScopedModelDescendant(
        builder: (BuildContext context, Widget child, MainModel model) {
      return Container(
        margin: EdgeInsets.fromLTRB(20, 0, 20, 15),
        height: (50.0 / 740.0) * MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width * (270.0 / 360.0),
        decoration: BoxDecoration(
            color: options[index] == 0
                ? Colors.grey.withOpacity(0.1)
                : (options[index] == 1 && correct == true)
                    ? Color.fromRGBO(83, 195, 111, 1)
                    : Color.fromRGBO(255, 131, 131, 1),
            borderRadius: new BorderRadius.all(const Radius.circular(23)),
            boxShadow: [
              BoxShadow(
                  color: options[index] == 0
                      ? Colors.grey.withOpacity(0.1)
                      : Colors.white.withOpacity(0.1),
                  spreadRadius: 1,
                  blurRadius: 5)
            ]),
        child: FlatButton(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(23.0)),
          onPressed: () {
            if (!disable[index]) {
              setState(() {
                options[index] = 1;
                if (correct == false) {
                  WrongAnswer();
                  model.decrementSFSScore();
                  setState(() {
                    showCorrect();
                  });
                  disableAll();
                }
                if (correct == true && correct_total == 1) {
                  CorrectAnswer();
                  model.incrementSFSScore();
                } else if (correct == true && correct_total > 1) {
                  correct_total--;
                }
              });
            } else {}
          },
          child: Text(
            option,
            style: TextStyle(
                color: options[index] == 0 ? Colors.black : Colors.white,
                fontSize: 15,
                fontWeight: FontWeight.w100),
          ),
        ),
      );
    });
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
          width: MediaQuery.of(context).size.width * (455.0 / 360.0),
          child: Stack(
            children: <Widget>[
              Positioned(
                top: 20,
                left: 20,
                right: 20,
                child: ClipRRect(
                    borderRadius: new BorderRadius.circular(30.0),
                    child: Image.asset(
                      widget.sfsItem.imgLink,
                      width:
                          MediaQuery.of(context).size.width * (270.0 / 360.0),
                      height:
                          MediaQuery.of(context).size.width * (220.0 / 455.0),
                      fit: BoxFit.cover,
                    )),
              ),
              Positioned(
                  top: MediaQuery.of(context).size.width * (250.0 / 455.0),
                  child: SizedBox(
                    height: 300,
                    width: MediaQuery.of(context).size.width * .9,
                    child: ListView.builder(
                      itemBuilder: (BuildContext context, int index) {
                        return optionCard(widget.sfsItem.options[index], index);
                      },
                      itemCount: widget.sfsItem.options.length,
                    ),
                  ))
            ],
          ),
        );
      },
    );
  }
}
