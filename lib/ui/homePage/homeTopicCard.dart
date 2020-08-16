import 'dart:io';

import 'package:Dimik/ScopedModel/mainmodel.dart';
import 'package:Dimik/models/topic.dart';
import 'package:Dimik/view/widgets/task_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class TopicCard extends StatefulWidget {
  String currentGame;
  final int index;
  final Topic mainTopic;
  double completion;
  String level_id;

  TopicCard(
      {@required this.mainTopic,
      @required this.currentGame,
      @required this.index,
      @required this.level_id});
  @override
  State<StatefulWidget> createState() {
    return _TopicCardState();
  }
}

class _TopicCardState extends State<TopicCard> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant(
      builder: (BuildContext context, Widget child, MainModel model) {
        return GestureDetector(
          onTap: () {
            model.pwloading = true;
            model.wploading = true;
            model.tfloading = true;
            model.ltloading = true;
            model.sfsloading = true;
            model.fbwloading = true;
            model.mixloading = true;
            model.current = 1;
            //comment out
            switch (widget.currentGame) {
              case 'Fill in the Blanks Word':
                model.currentState = model.map[widget.index];
                Navigator.pushNamed(context, '/fbword');
                break;
              case 'Mix Task':
                model.currentState = model.map[widget.index];
                Navigator.pushNamed(context, '/mixtask');
                break;
              case 'Word to Picture':
                model.currentState = model.map[widget.index];
                Navigator.pushNamed(context, '/wordpicture');
                break;
              case 'Picture to Word':
                model.currentState = model.map[widget.index];
                Navigator.pushNamed(context, '/pictureword');
                break;
              case 'True False':
                model.currentState = model.map[widget.index];
                Navigator.pushNamed(context, '/truefalse');
                break;

              case 'Sentence From Story':
                model.currentState = model.map[widget.index];
                Navigator.pushNamed(context, '/sfs');
                break;

              case 'Listen to Word':
                model.currentState = model.map[widget.index];
                Navigator.pushNamed(context, '/lwtask');
                break;

              case 'Sentence Matching':
                model.currentState = model.map[widget.index];
                Navigator.pushNamed(context, '/smtask');
                break;

              default:
            }
          },
          child: Container(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * (120 / 720),
                    child: Stack(
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              model.change_fav_state(widget.index);
                            });
                          },
                          child: Icon(
                            Icons.favorite,
                            size: 30,
                            color: model.AllTopic[widget.index].isLoved == 1
                                ? Colors.redAccent
                                : Color.fromRGBO(171, 172, 197, 1),
                          ),
                        ),
                        Positioned(
                          left: MediaQuery.of(context).size.width * (90 / 360),
                          child: Container(
                            child: new ClipRRect(
                              borderRadius: new BorderRadius.circular(30.0),
                              child: Image.asset(
                                widget.mainTopic.imageLink,
                                width: MediaQuery.of(context).size.width *
                                    (120 / 360),
                                height: MediaQuery.of(context).size.height *
                                    (120 / 720),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Spacer(
                    flex: 1,
                  ),
                  Text(
                    '',
                    style: new TextStyle(
                        fontSize: 14, fontWeight: FontWeight.w100),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        widget.mainTopic.name,
                        style: new TextStyle(
                            fontSize: 24, fontWeight: FontWeight.w900),
                      ),
                      Row(
                        children: <Widget>[
                          Image.asset(
                            'assets/img/crown.png',
                            scale: 20,
                          ),
                          Text(
                            ' ' + widget.level_id,
                            style: new TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w900),
                          ),
                        ],
                      )
                    ],
                  ),
                  SizedBox(
                    height: 60,
                  ),
                  TaskProgressIndicator(
                      color: Colors.red,
                      progress: model.map[widget.index].completion),
                ],
              ),
              margin: EdgeInsets.fromLTRB(16, 16, 10, 16),
              decoration: BoxDecoration(
                color: Color.fromRGBO(255, 255, 255, 1),
                borderRadius: new BorderRadius.all(const Radius.circular(24)),
              )),
        );
      },
    );
  }
}
