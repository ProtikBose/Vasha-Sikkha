import 'dart:async';

import 'package:Dimik/ScopedModel/mainmodel.dart';
import 'package:Dimik/ui/task/Fill_in_the_gaps_words/fb_word_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:scoped_model/scoped_model.dart';

class FB_Word_Task extends StatefulWidget {
  bool _isLoaded = false;
  bool timer_flag = false;
  bool call_flag = false;
  int current = 1;

  @override
  State<StatefulWidget> createState() {
    return FB_Word_Task_State();
  }
}

class FB_Word_Task_State extends State<FB_Word_Task>
    with TickerProviderStateMixin {
  AnimationController timeController;
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  Timer _timer;
  String _time = "";
  var sub;

  String get timeString {
    Duration duration;
    if (widget._isLoaded == true) {
      duration = timeController.duration * timeController.value;
      String temp =
          '${duration.inMinutes % 60}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
      _time = temp;
      return temp;
    }

    return "";
  }

  @override
  void initState() {
    super.initState();

    timeController =
        AnimationController(vsync: this, duration: Duration(seconds: 90));
    timeController.reverse(
        from: timeController.value == 0 ? 1 : timeController.value);

    timeController.addListener(() {
      if (timeString == "0:00") {
        timeController.stop(canceled: true);
        Navigator.pushNamed(context, '/gameover', arguments: 'mixtask');
      }
    });
  }

  @override
  void dispose() {
    timeController.dispose();
    super.dispose();
  }

  Widget progressDetails(int total) {
    return ScopedModelDescendant(
      builder: (BuildContext context, Widget child, MainModel model) {
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              height: 50 * (MediaQuery.of(context).size.height / 720.0),
              width: 195 * (MediaQuery.of(context).size.width / 360.0),
              alignment: FractionalOffset.center,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: new BorderRadius.all(const Radius.circular(29.5)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  GestureDetector(
                    child: Icon(Icons.arrow_back_ios),
                    onTap: () {
                      Dialog dialog = Dialog(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0)),
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: new LinearGradient(
                                colors: <Color>[
                                  Color.fromRGBO(0, 193, 134, 1),
                                  Color.fromRGBO(128, 109, 222, 1)
                                ],
                                begin: FractionalOffset.topLeft,
                                end: FractionalOffset.bottomRight),
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          height: 170.0 *
                              (MediaQuery.of(context).size.height / 740.0),
                          width: 320.0 *
                              (MediaQuery.of(context).size.width / 360.0),
                          child: Stack(
                            children: <Widget>[
                              Positioned(
                                top: 19,
                                left: 15,
                                child: Text(
                                  'Close',
                                  style: TextStyle(
                                      color: Colors.white.withOpacity(0.25),
                                      fontSize: 78),
                                ),
                              ),
                              Positioned(
                                top: 90 *
                                    (MediaQuery.of(context).size.height /
                                        740.0),
                                left: 20 *
                                    (MediaQuery.of(context).size.width / 360.0),
                                right: 54 *
                                    (MediaQuery.of(context).size.width / 360.0),
                                child: Text(
                                  'are you sure you want to exit?',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 14),
                                ),
                              ),
                              Positioned(
                                  top: 115 *
                                      (MediaQuery.of(context).size.height /
                                          740.0),
                                  left: 125 *
                                      (MediaQuery.of(context).size.width /
                                          360.0),
                                  child: FlatButton(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(23.0)),
                                    child: Text(
                                      'Yes',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    onPressed: () {
                                      model.scoreFBW = 0;
                                      model.correctFBW = 0;
                                      model.incorrectFBW = 0;
                                      model.fbwloading = true;
                                      Navigator.pop(context);
                                      Navigator.pop(context);
                                    },
                                  )),
                              Positioned(
                                  top: 115 *
                                      (MediaQuery.of(context).size.height /
                                          740.0),
                                  left: 195 *
                                      (MediaQuery.of(context).size.width /
                                          360.0),
                                  child: FlatButton(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(23.0)),
                                    child: Text(
                                      'No',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                  ))
                            ],
                          ),
                        ),
                      );
                      showDialog(
                          context: context,
                          builder: (BuildContext context) => dialog);
                    },
                  ),
                  Text('Remaining'),
                  AnimatedBuilder(
                      animation: timeController,
                      builder: (_, Widget child) {
                        return Text(
                          timeString,
                          style: TextStyle(color: Color(0xFFE27777)),
                        );
                      }),
                ],
              ),
            ),
            SizedBox(
              width: 30 * (MediaQuery.of(context).size.width / 360.0),
            ),
            Container(
              height: 50 * (MediaQuery.of(context).size.height / 720.0),
              width: 96.5 * (MediaQuery.of(context).size.width / 360.0),
              alignment: FractionalOffset.center,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: new BorderRadius.all(const Radius.circular(29.5)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(model.current.toString()),
                  Text('/'),
                  Text(total.toString()),
                ],
              ),
            ),
            SizedBox(
              width: 0,
            )
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    const _kDuration = const Duration(milliseconds: 300);
    const _kCurve = Curves.decelerate;
    PageController controller = PageController(keepPage: false);

    return Scaffold(
        key: _scaffoldKey,
        backgroundColor: Color.fromRGBO(242, 242, 242, 1),
        body: ScopedModelDescendant(
            builder: (BuildContext context, Widget child, MainModel model) {
          if (!widget.call_flag) {
            model.generateFBWord();
            widget.call_flag = true;
            widget._isLoaded = true;
          }
          return Container(
            child: model.isFBWLoading
                ? Center(
                    child: CircularProgressIndicator(
                    backgroundColor: Colors.white,
                    strokeWidth: 1.5,
                  ))
                : Stack(
                    children: <Widget>[
                      Positioned(
                        top: (40.0 / 740) * MediaQuery.of(context).size.height,
                        left: (20.0 / 360) * MediaQuery.of(context).size.width,
                        child: progressDetails(model.tasklen),
                      ),
                      Positioned(
                        top: 150,
                        left: 20,
                        right: 20,
                        child: SizedBox(
                            height: (453.0 / 740.0) *
                                MediaQuery.of(context).size.height,
                            width: (320.0 / 360.0) *
                                MediaQuery.of(context).size.width,
                            child: PageView.builder(
                              controller: controller,
                              physics: new NeverScrollableScrollPhysics(),
                              itemCount: model.fbwordlist.length >= 10
                                  ? 10
                                  : model.fbwordlist.length,
                              itemBuilder: (BuildContext context, int index) {
                                return FBWordCard(model.fbwordlist[index],
                                    _scaffoldKey, controller, model.current);
                              },
                            )),
                      ),
                      Positioned(
                        top: (677.0 / 740.0) *
                            MediaQuery.of(context).size.height,
                        left:
                            (20.0 / 360.0) * MediaQuery.of(context).size.width,
                        right:
                            (20.0 / 360.0) * MediaQuery.of(context).size.width,
                        child: Container(
                          height: (63.0 / 740.0) *
                              MediaQuery.of(context).size.height,
                          width: (340.0 / 360.0) *
                              MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(133, 119, 226, 1),
                            borderRadius: new BorderRadius.only(
                                topLeft: const Radius.circular(30),
                                topRight: const Radius.circular(30)),
                          ),
                          child: FlatButton(
                            onPressed: () {
                              setState(() {
                                if (model.current < model.fbwordlist.length) {
                                  model.current++;
                                } else {
                                  Navigator.pushReplacementNamed(
                                      context, '/gameover',
                                      arguments: 'mixtask');
                                }
                              });
                              controller.nextPage(
                                  curve: _kCurve, duration: _kDuration);
                            },
                            child: Text(
                              'Next',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w100),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
          );
        }));
  }
}
