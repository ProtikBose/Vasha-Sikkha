import 'dart:io';
import 'package:Dimik/ScopedModel/mainmodel.dart';
import 'package:Dimik/models/listening_item.dart';
import 'package:Dimik/models/task_history.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class ListeningHistory_Card extends StatefulWidget {
  ListeningItem _listeningItem;
  Task_History task_history;

  ListeningHistory_Card({this.task_history}) {
    _listeningItem = task_history.task;
  }

  @override
  State<StatefulWidget> createState() {
    return ListeningHistoryCardState();
  }
}

class ListeningHistoryCardState extends State<ListeningHistory_Card> {
  int option1 = 1, option2 = 2, option3 = 3, option4 = 4;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant(
      builder: (BuildContext context, Widget child, MainModel model) {
        int index = widget._listeningItem.options
                .indexOf(widget._listeningItem.correct) +
            1;
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: new BorderRadius.all(const Radius.circular(30)),
          ),
          margin: EdgeInsets.all(20),
          height: (453.0 / 740.0) * MediaQuery.of(context).size.height,
          width: (320.0 / 360.0) * MediaQuery.of(context).size.width,
          child: Stack(
            children: <Widget>[
              Positioned(
                top: 0,
                left: 20,
                right: 20,
                child: InkWell(
                  onTap: () {},
                  child: Image.asset(
                    'assets/img/icons/listen.png',
                    height: 300,
                    width: 300,
                    scale: 2,
                  ),
                ),
              ),
              Positioned(
                top: 290,
                left: 20,
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
                      widget._listeningItem.options[0],
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
                top: 290,
                right: 20,
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
                      widget._listeningItem.options[1],
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
                top: 380,
                left: 20,
                child: Container(
                  height: (50.0 / 740.0) * MediaQuery.of(context).size.height,
                  width: (100.0 / 360.0) * MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: option3 == 1
                          ? Colors.grey.withOpacity(0.1)
                          : option3 == 2
                              ? Color.fromRGBO(83, 195, 111, 1)
                              : Color.fromRGBO(255, 131, 131, 1),
                      borderRadius:
                          new BorderRadius.all(const Radius.circular(23)),
                      boxShadow: [
                        BoxShadow(
                            color: option3 == widget.task_history.inputIndex
                                ? ((option3 == widget.task_history.correctIndex)
                                    ? Color.fromRGBO(83, 195, 111, 1)
                                    : Color.fromRGBO(255, 131, 131, 1))
                                : (option3 == widget.task_history.correctIndex)
                                    ? Color.fromRGBO(83, 195, 111, 1)
                                    : Colors.grey.withOpacity(0.1),
                            spreadRadius: 1,
                            blurRadius: 5)
                      ]),
                  child: FlatButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(23.0)),
                    onPressed: () {},
                    child: Text(
                      widget._listeningItem.options[2],
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
                top: 380,
                right: 20,
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
                      widget._listeningItem.options[3],
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
