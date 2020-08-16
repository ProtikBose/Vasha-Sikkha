import 'package:Dimik/ScopedModel/mainmodel.dart';
import 'package:Dimik/models/pictureword.dart';
import 'package:Dimik/models/task_history.dart';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:scoped_model/scoped_model.dart';

class Picture_Word_History extends StatefulWidget {
  PictureWord _pictureWord;
  Task_History task_history;
  Picture_Word_History({this.task_history}) {
    _pictureWord = task_history.task;
    print(task_history.correctIndex);
    print(task_history.inputIndex);
  }

  @override
  State<StatefulWidget> createState() {
    return Picture_Word_History_State();
  }
}

class Picture_Word_History_State extends State<Picture_Word_History> {
  AudioPlayer audioPlayer;

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
          //margin: EdgeInsets.all(20),
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
                      color: option1 == widget.task_history.inputIndex
                          ? ((option1 == widget.task_history.correctIndex)
                              ? Color.fromRGBO(83, 195, 111, 1)
                              : Color.fromRGBO(255, 131, 131, 1))
                          : (option1 == widget.task_history.correctIndex)
                              ? Color.fromRGBO(83, 195, 111, 1)
                              : Colors.grey.withOpacity(0.1),
                      borderRadius:
                          new BorderRadius.all(const Radius.circular(23)),
                      boxShadow: [
                        BoxShadow(
                            color: option1 != widget.task_history.inputIndex
                                ? Colors.grey.withOpacity(0.1)
                                : Colors.white.withOpacity(0.1),
                            spreadRadius: 1,
                            blurRadius: 5)
                      ]),
                  child: FlatButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(23.0)),
                    onPressed: () {},
                    child: Text(
                      widget._pictureWord.options[0],
                      style: TextStyle(
                          color: option1 != widget.task_history.inputIndex
                              ? Colors.black
                              : Colors.white,
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
                      color: option2 == widget.task_history.inputIndex
                          ? ((option2 == widget.task_history.correctIndex)
                              ? Color.fromRGBO(83, 195, 111, 1)
                              : Color.fromRGBO(255, 131, 131, 1))
                          : (option2 == widget.task_history.correctIndex)
                              ? Color.fromRGBO(83, 195, 111, 1)
                              : Colors.grey.withOpacity(0.1),
                      borderRadius:
                          new BorderRadius.all(const Radius.circular(23)),
                      boxShadow: [
                        BoxShadow(
                            color: option2 != widget.task_history.inputIndex
                                ? Colors.grey.withOpacity(0.1)
                                : Colors.white.withOpacity(0.1),
                            spreadRadius: 1,
                            blurRadius: 5)
                      ]),
                  child: FlatButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(23.0)),
                    onPressed: () {},
                    child: Text(
                      widget._pictureWord.options[1],
                      style: TextStyle(
                          color: option2 != widget.task_history.inputIndex
                              ? Colors.black
                              : Colors.white,
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
                      color: option3 == widget.task_history.inputIndex
                          ? ((option3 == widget.task_history.correctIndex)
                              ? Color.fromRGBO(83, 195, 111, 1)
                              : Color.fromRGBO(255, 131, 131, 1))
                          : (option3 == widget.task_history.correctIndex)
                              ? Color.fromRGBO(83, 195, 111, 1)
                              : Colors.grey.withOpacity(0.1),
                      borderRadius:
                          new BorderRadius.all(const Radius.circular(23)),
                      boxShadow: [
                        BoxShadow(
                            color: option3 != widget.task_history.inputIndex
                                ? Colors.grey.withOpacity(0.1)
                                : Colors.white.withOpacity(0.1),
                            spreadRadius: 1,
                            blurRadius: 5)
                      ]),
                  child: FlatButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(23.0)),
                    onPressed: () {},
                    child: Text(
                      widget._pictureWord.options[2],
                      style: TextStyle(
                          color: option3 != widget.task_history.inputIndex
                              ? Colors.black
                              : Colors.white,
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
                      color: option4 == widget.task_history.inputIndex
                          ? ((option4 == widget.task_history.correctIndex)
                              ? Color.fromRGBO(83, 195, 111, 1)
                              : Color.fromRGBO(255, 131, 131, 1))
                          : (option4 == widget.task_history.correctIndex)
                              ? Color.fromRGBO(83, 195, 111, 1)
                              : Colors.grey.withOpacity(0.1),
                      borderRadius:
                          new BorderRadius.all(const Radius.circular(23)),
                      boxShadow: [
                        BoxShadow(
                            color: option4 != widget.task_history.inputIndex
                                ? Colors.grey.withOpacity(0.1)
                                : Colors.white.withOpacity(0.1),
                            spreadRadius: 1,
                            blurRadius: 5)
                      ]),
                  child: FlatButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(23.0)),
                    onPressed: () {},
                    child: Text(
                      widget._pictureWord.options[3],
                      style: TextStyle(
                          color: option4 != widget.task_history.inputIndex
                              ? Colors.black
                              : Colors.white,
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
