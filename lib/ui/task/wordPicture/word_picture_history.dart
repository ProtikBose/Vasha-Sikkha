import 'package:Dimik/ScopedModel/mainmodel.dart';
import 'package:Dimik/models/task_history.dart';
import 'package:Dimik/models/wordpicture.dart';
import 'package:flutter/material.dart';
import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:scoped_model/scoped_model.dart';

class WordPictureHistory_Card extends StatefulWidget {
  Task_History task_history;
  WordPicture _wordPicture;
  WordPictureHistory_Card({this.task_history}) {
    this._wordPicture = task_history.task;
  }

  @override
  State<StatefulWidget> createState() {
    return WordPictureHistory_CardState();
  }
}

class WordPictureHistory_CardState extends State<WordPictureHistory_Card> {
  int option1 = 1, option2 = 2, option3 = 3, option4 = 4;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant(
      builder: (BuildContext context, Widget child, MainModel model) {
        return Container(
          height: (453.0 / 740.0) * MediaQuery.of(context).size.height,
          width: (320.0 / 360.0) * MediaQuery.of(context).size.width,
          margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: new BorderRadius.all(const Radius.circular(30)),
          ),
          child: Stack(
            children: <Widget>[
              Positioned(
                top: 30,
                left: 25,
                right: 25,
                child: Container(
                  child: Center(
                    child: Text(
                      'Below which is \'' + widget._wordPicture.word + '\' ?',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
              Positioned(
                child: GestureDetector(
                    child: Container(
                      height: 120,
                      width: 120,
                      child: ClipRRect(
                          borderRadius: new BorderRadius.circular(30.0),
                          child: Image.asset(
                            widget._wordPicture.imgLinks[0],
                            width: MediaQuery.of(context).size.width *
                                (270.0 / 360.0),
                            height: MediaQuery.of(context).size.width *
                                (300.0 / 455.0),
                            fit: BoxFit.cover,
                            /*color: option1 == 0
                                ? Colors.grey.withOpacity(0)
                                : option1 == 1
                                    ? Colors.grey.withOpacity(1)
                                    : option1 == 2
                                        ? Color.fromRGBO(83, 195, 111, 1)
                                        : Color.fromRGBO(255, 131, 131, 1),*/
                            color: option1 == widget.task_history.inputIndex
                                ? ((option1 == widget.task_history.correctIndex)
                                    ? Color.fromRGBO(83, 195, 111, 1)
                                    : Color.fromRGBO(255, 131, 131, 1))
                                : (option1 == widget.task_history.correctIndex)
                                    ? Color.fromRGBO(83, 195, 111, 1)
                                    : Colors.grey.withOpacity(0.1),
                            colorBlendMode: BlendMode.color,
                          )),
                    ),
                    onTap: () {}),
                top: 170,
                left: 30,
              ),
              Positioned(
                child: GestureDetector(
                    child: Container(
                      height: 120,
                      width: 120,
                      child: ClipRRect(
                          borderRadius: new BorderRadius.circular(30.0),
                          child: Image.asset(
                            widget._wordPicture.imgLinks[1],
                            width: MediaQuery.of(context).size.width *
                                (270.0 / 360.0),
                            height: MediaQuery.of(context).size.width *
                                (300.0 / 455.0),
                            fit: BoxFit.cover,
                            color: option2 == widget.task_history.inputIndex
                                ? ((option2 == widget.task_history.correctIndex)
                                    ? Color.fromRGBO(83, 195, 111, 1)
                                    : Color.fromRGBO(255, 131, 131, 1))
                                : (option2 == widget.task_history.correctIndex)
                                    ? Color.fromRGBO(83, 195, 111, 1)
                                    : Colors.grey.withOpacity(0.1),
                            colorBlendMode: BlendMode.color,
                          )),
                    ),
                    onTap: () {}),
                top: 170,
                right: 30,
              ),
              Positioned(
                child: GestureDetector(
                  child: Container(
                    height: 120,
                    width: 120,
                    child: ClipRRect(
                        borderRadius: new BorderRadius.circular(30.0),
                        child: Image.asset(
                          widget._wordPicture.imgLinks[2],
                          width: MediaQuery.of(context).size.width *
                              (270.0 / 360.0),
                          height: MediaQuery.of(context).size.width *
                              (300.0 / 455.0),
                          fit: BoxFit.cover,
                          color: option3 == widget.task_history.inputIndex
                              ? ((option3 == widget.task_history.correctIndex)
                                  ? Color.fromRGBO(83, 195, 111, 1)
                                  : Color.fromRGBO(255, 131, 131, 1))
                              : (option3 == widget.task_history.correctIndex)
                                  ? Color.fromRGBO(83, 195, 111, 1)
                                  : Colors.grey.withOpacity(0.1),
                          colorBlendMode: BlendMode.color,
                        )),
                  ),
                  onTap: () {},
                ),
                top: 330,
                left: 30,
              ),
              Positioned(
                child: GestureDetector(
                  child: Container(
                    height: 120,
                    width: 120,
                    child: ClipRRect(
                        borderRadius: new BorderRadius.circular(30.0),
                        child: Image.asset(
                          widget._wordPicture.imgLinks[3],
                          width: MediaQuery.of(context).size.width *
                              (270.0 / 360.0),
                          height: MediaQuery.of(context).size.width *
                              (300.0 / 455.0),
                          fit: BoxFit.cover,
                          color: option4 == widget.task_history.inputIndex
                              ? ((option4 == widget.task_history.correctIndex)
                                  ? Color.fromRGBO(83, 195, 111, 1)
                                  : Color.fromRGBO(255, 131, 131, 1))
                              : (option4 == widget.task_history.correctIndex)
                                  ? Color.fromRGBO(83, 195, 111, 1)
                                  : Colors.grey.withOpacity(0.1),
                          colorBlendMode: BlendMode.color,
                        )),
                  ),
                  onTap: () {},
                ),
                top: 330,
                right: 30,
              ),
            ],
          ),
        );
      },
    );
  }
}
