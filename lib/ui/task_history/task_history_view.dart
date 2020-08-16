import 'package:Dimik/ScopedModel/mainmodel.dart';
import 'package:Dimik/ui/arcade/arcade_card.dart';
import 'package:Dimik/ui/homePage/homeTopicCard.dart';
import 'package:Dimik/ui/task/TrueFalse/true_false_history.dart';
import 'package:Dimik/ui/task/listening_game/listening_history.dart';
import 'package:Dimik/ui/task/pictureWord/picture_word_history.dart';
import 'package:Dimik/ui/task/wordPicture/word_picture_history.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:scoped_model/scoped_model.dart';

class TaskHistoryView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return TaskHistoryViewState();
  }
}

class TaskHistoryViewState extends State<TaskHistoryView> {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant(
      builder: (BuildContext context, Widget child, MainModel model) {
        return Scaffold(
            body: Stack(
          children: <Widget>[
            Positioned(
              child: IconButton(
                icon: Icon(Icons.arrow_back_ios),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              top: 75.0 / 948.0 * MediaQuery.of(context).size.height,
              left: 20.0 / 375.0 * MediaQuery.of(context).size.width,
            ),
            Positioned(
              child: Text(
                !model.changeToBangla ? "History" : 'ইতিহাস',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40),
              ),
              top: 75.0 / 948.0 * MediaQuery.of(context).size.height,
              left: 70.0 / 375.0 * MediaQuery.of(context).size.width,
            ),
            Positioned(
              top: 150.0 / 948.0 * MediaQuery.of(context).size.height,
              left: 40.0 / 375.0 * MediaQuery.of(context).size.width,
              child: model.isLoading
                  ? Center(
                      child: CircularProgressIndicator(
                        strokeWidth: 1.0,
                        valueColor:
                            new AlwaysStoppedAnimation<Color>(Colors.blue),
                      ),
                    )
                  : SizedBox(
                      height: MediaQuery.of(context).size.height * .80,
                      width: MediaQuery.of(context).size.width -
                          (2 *
                              40.0 /
                              375.0 *
                              MediaQuery.of(context).size.width),
                      child: ListView.builder(
                          physics: BouncingScrollPhysics(),
                          itemBuilder: (BuildContext context, int index) {
                            if (model.taskHistory[index].task.taskname ==
                                'True False') {
                              return True_False_History(
                                task_history: model.taskHistory[index],
                              );
                            } else if (model.taskHistory[index].task.taskname ==
                                'PW') {
                              return Picture_Word_History(
                                task_history: model.taskHistory[index],
                              );
                            } else if (model.taskHistory[index].task.taskname ==
                                'WP') {
                              return WordPictureHistory_Card(
                                task_history: model.taskHistory[index],
                              );
                            } else if (model.taskHistory[index].task.taskname ==
                                'LW') {
                              return ListeningHistory_Card(
                                task_history: model.taskHistory[index],
                              );
                            } else
                              return Container();
                          },
                          itemCount: model.taskHistory.length),
                    ),
            )
          ],
        ));
      },
    );
  }
}
