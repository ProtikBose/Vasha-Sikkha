import 'package:Dimik/models/task.dart';
import 'package:Dimik/models/task_history.dart';
import 'package:Dimik/models/tf.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class True_False_History extends StatelessWidget {
  TF tf;
  Task_History task_history;

  True_False_History({this.task_history}) {
    tf = task_history.task;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Stack(
          children: <Widget>[
            Positioned(
              top: 115,
              left: 20,
              right: 20,
              child: Text(tf.question, style: TextStyle(fontSize: 18)),
            ),
            Positioned(
              top: 245,
              left: 95,
              right: 95,
              child: Container(
                height: (50.0 / 740.0) * MediaQuery.of(context).size.height,
                width: (200.0 / 360.0) * MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: (task_history.inputIndex == 1)
                      ? ((task_history.correctIndex == task_history.inputIndex)
                          ? Color.fromRGBO(83, 195, 111, 1)
                          : Color.fromRGBO(255, 131, 131, 1))
                      : task_history.correctIndex == 1
                          ? Color.fromRGBO(83, 195, 111, 1)
                          : Colors.grey.withOpacity(0.1),
                  borderRadius: new BorderRadius.all(const Radius.circular(23)),
                ),
                child: FlatButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(23.0)),
                  onPressed: () {},
                  child: Text(
                    'True',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.w100),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 330,
              left: 95,
              right: 95,
              child: Container(
                height: (50.0 / 740.0) * MediaQuery.of(context).size.height,
                width: (200.0 / 360.0) * MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: (task_history.inputIndex == 0)
                      ? ((task_history.correctIndex == task_history.inputIndex)
                          ? Color.fromRGBO(83, 195, 111, 1)
                          : Color.fromRGBO(255, 131, 131, 1))
                      : task_history.correctIndex == 0
                          ? Color.fromRGBO(83, 195, 111, 1)
                          : Colors.grey.withOpacity(0.1),
                  borderRadius: new BorderRadius.all(const Radius.circular(23)),
                ),
                child: FlatButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(23.0)),
                  onPressed: () {},
                  child: Text(
                    'False',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.w100),
                  ),
                ),
              ),
            )
          ],
        ),
        margin: EdgeInsets.all(20),
        height: (453.0 / 740.0) * MediaQuery.of(context).size.height,
        width: (320.0 / 360.0) * MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: new BorderRadius.all(const Radius.circular(30)),
        ));
  }
}
