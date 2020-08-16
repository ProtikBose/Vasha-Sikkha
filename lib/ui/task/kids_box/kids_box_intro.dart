import 'dart:async';

import 'package:Dimik/ui/task/TrueFalse/true_false_card.dart';
import 'package:Dimik/ui/task/kids_box/kids_box_intro_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:page_indicator/page_indicator.dart';

class KidsBoxIntro extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _KidsBoxIntroState();
  }

}

class _KidsBoxIntroState extends State<KidsBoxIntro> with SingleTickerProviderStateMixin {
  bool isKBLoading = false ;
  bool _timer_flag = false ;

  static GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  Timer _timer;
  int _start = 10;

  static get scaffoldKey => _scaffoldKey;

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
          (Timer timer) => setState(
            () {
          if (_start < 1) {
            timer.cancel();
            Navigator.pushReplacementNamed(context, '/kbtask');
          } else {
            _start = _start - 1;
          }
        },
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
    ]);
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight
    ]);
  }

  Widget progressDetails() {
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
                  Text(
                    _start < 10
                        ? '00:0' + _start.toString()
                        : '00:' + _start.toString(),
                    style: TextStyle(color: Colors.redAccent),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 30 * (MediaQuery.of(context).size.width / 360.0),
            ),

          ],
        );
      }


  @override
  Widget build(BuildContext context) {
    List<String> story = ['Spondon plays badly but dances quickly','Imtiaz sings quickly but dances well','Tusar dances well but sings badly'];

    if(!_timer_flag){
      startTimer() ;
      _timer_flag = true ;
    }

    return Scaffold(body: Container(child: isKBLoading
        ? Center(
        child: CircularProgressIndicator(
          backgroundColor: Colors.blue,
          strokeWidth: 1.5,
        )):Stack(
        children: <Widget>[
    Positioned(
    top: (40.0 / 740) * MediaQuery.of(context).size.height,
      left: (20.0 / 360) * MediaQuery.of(context).size.width,
      child: progressDetails(),
    ),
    Positioned(
      top: 150,
      left: 20,
      right: 20,
      child: KidsBoxIntroCard(hint:story ),
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
            Navigator.pushReplacementNamed(context, '/kbtask');
          },
          child: Text(
            'Start Game',
            style: TextStyle(
                color: Colors.white,
                fontSize: 15,
                fontWeight: FontWeight.w100),
          ),
        ),
      ),
    ),
    ])));
  }
}



