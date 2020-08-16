import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:io' as io;
import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:Dimik/config.dart';

class centralWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return centralWidgetState();
  }
}

class centralWidgetState extends State<centralWidget>
    with TickerProviderStateMixin {
  AnimationController animationController;
  AnimationController animationCounter;
  Animation<Offset> _moveOutOfTheScreen;
  Animation<double> _rotate;
  CurvedAnimation curvedAnimation;
  bool isLoading = true;
  int _value = 0;
  int iterative = 1;
  int length = 1;
  bool isPressed;
  int index;

  String get timerString {
    Duration duration;
    if (isLoading == false) {
      duration = animationCounter.duration * animationCounter.value;
      _value = duration.inSeconds;
      String temp =
          '${duration.inMinutes % 60}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
      //if(temp=="0:00") dialogBoxShown();
      return temp;
    }

    return "";
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    index = 0;
    isPressed = false;
    isLoading = true;
    getData();
    animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    animationCounter =
        AnimationController(vsync: this, duration: Duration(seconds: 90));

    curvedAnimation =
        CurvedAnimation(parent: animationController, curve: Curves.easeOut);
    _moveOutOfTheScreen =
        new Tween<Offset>(begin: Offset(0.0, 0.0), end: Offset(-500.0, 200.0))
            .animate(curvedAnimation)
              ..addListener(() {
                setState(() {
                  //animationController.reset();
                });
              });
    _rotate = new Tween<double>(begin: 0, end: -1).animate(curvedAnimation);
    animationCounter.reverse(
        from: animationCounter.value == 0.0
            ? 1.0
            : animationCounter.value); //..addListener(() {
    //   setState(() {});
    // });
    // dataEntry();
    animationCounter.addListener(() {
      if (timerString == "0:00") {
        print("timer stopped");
        TimedialogBoxShown();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return WillPopScope(
        // onWillPop: _onWillPopPressed,
        child: Stack(
      children: <Widget>[
        Positioned(
            top: 49,
            //bottom: 650,
            left: 20,
            //right: 20,
            width: 194,
            height: 49,
            child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(29.5)),
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      left: 5,
                      width: 10,
                      top: -2,
                      child: IconButton(
                        icon: Icon(Icons.arrow_back_ios),
                        onPressed: () {
                          _onWillPopPressed();
                        },
                      ),
                    ),
                    Positioned(
                      left: 52,
                      right: 76,
                      top: 14,
                      bottom: 13,
                      child: Text("Remaining",
                          style: TextStyle(
                              color: Color(0xFF2E303E), fontSize: 12)),
                    ),
                    Positioned(
                        left: 136,
                        right: 26,
                        top: 14,
                        bottom: 13,
                        child: AnimatedBuilder(
                            animation: animationCounter,
                            builder: (_, Widget child) {
                              return Text(
                                timerString,
                                style: TextStyle(
                                    color: Color(0xFFE27777), fontSize: 12),
                              );
                            }))
                  ],
                ))),

        Positioned(
            top: 49,
            //bottom: 650,
            left: 243,
            //right: 20,
            width: 97,
            height: 49,
            child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(29.5)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(iterative.toString()),
                    Text("/",
                        style:
                            TextStyle(color: Color.fromARGB(51, 46, 48, 62))),
                    Text(length.toString())
                  ],
                ))),

        // Positioned(
        //   top: 144,
        //   bottom: 143,
        //   left: 20,
        //   right: 20,
        //   child:TaskStats()

        // ),
        Positioned(
            top: 144,
            bottom: 143,
            left: 20,
            right: 20,
            child: cardMovement(context)),

        Positioned(
          top: 675,
          //bottom: 0,
          left: 20,
          width: 345,
          height: 63,
          child: RaisedButton(
            onPressed: () {
              isPressed = true;
              if (timerString != "0:00") {
                animationController.forward().whenComplete(() {
                  setState(() {
                    iterative++;
                    animationController.reset();
                    if (isLoading == false)
                      //FbGap removedCard = val.removeAt(0);
                      //cards.add(removedCard);
                      isPressed = false;

                    if (iterative > length) {
                      iterative--;
                      animationCounter.stop();
                      //animationCounter.
                      dialogBoxShown();
                    }
                  });
                });
              } else {
                TimedialogBoxShown();
              }
            },
            child: Stack(
              children: <Widget>[
                Positioned(
                  top: 18,
                  bottom: 28,
                  left: 122.5,
                  child: Text(
                    "Get next",
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                )
              ],
            ),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(23)),
            textColor: Colors.white,
            //highlightColor: Colors.red,
            color: Color(0xFF8577E2),
            //elevation: 1,
            //highlightElevation: 0.5,
          ),
        )
      ],
    ));
  }

  Future<bool> dialogBoxShown() {
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text(" Do you want to continue?"),
              actions: <Widget>[
                FlatButton(
                  child: Text("Yes"),
                  onPressed: () => Navigator.of(context)
                      .pushReplacementNamed("/centralWidget"),
                ),
                FlatButton(
                  child: Text("No"),
                  //onPressed: () => Navigator.pop(context, false),
                  onPressed: () =>
                      Navigator.of(context).pushReplacementNamed("/home"),
                )
              ],
            ));
  }

  Widget cardMovement(BuildContext context) {
    if (isLoading == true) {
      return Container();
    } else {
      return Container();
    }
  }

  Future<bool> _onWillPopPressed() {
    animationCounter.stop();
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text("Do You Really Want To Exit?"),
              actions: <Widget>[
                FlatButton(
                  child: Text("Yes"),
                  onPressed: () =>
                      Navigator.of(context).pushReplacementNamed("/home"),
                ),
                FlatButton(
                  child: Text("No"),
                  onPressed: () {
                    animationCounter.reverse(
                        from: animationCounter.value == 0.0
                            ? 1.0
                            : animationCounter.value);
                    Navigator.pop(context, false);
                  },
                )
              ],
            ));
  }

  Future<bool> TimedialogBoxShown() {
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text("Sorry !!!! Your time is up .  " +
                  "Do you want to continue?"),
              actions: <Widget>[
                FlatButton(
                  child: Text("Yes"),
                  onPressed: () => Navigator.of(context)
                      .pushReplacementNamed("/fillTheGaps"),
                ),
                FlatButton(
                  child: Text("No"),
                  onPressed: () =>
                      Navigator.of(context).pushReplacementNamed("/home"),
                )
              ],
            ));
  }

  void getData() async {
    /*
    mixTask = new MixTaskController();
    //List<dynamic>qsList;
    mixTask.getMixList(TOKEN, "1").then((qsList) {
      setState(() {
        print("In getData");
        //print(qsList.list);
      });
    });
    */
  }
}
