// import 'package:Dimik/data/controller/sme.dart';
// import 'package:Dimik/models/sme.dart';
// import 'package:Dimik/models/token.dart';
// import 'package:Dimik/ui/task/sentence_matching_task_eng/OptionCard.dart';
// import 'package:flutter/material.dart';
// import './OptionView.dart';
// import '../../../view/widgets/topScreen.dart';
// import '../../../config.dart';
// import './EmptyOptionView.dart';
// import 'package:scoped_model/scoped_model.dart';
// import '../../../ScopedModel/mainmodel.dart';
// import '../sentence_matching_task_eng/TaskElement.dart';

// class SentenceMatchingViewEng extends StatefulWidget {
//   String topic;
//   @override
//   State<StatefulWidget> createState() {
//     return _SMState(topic: topic);
//   }
// }

// class _SMState extends State<SentenceMatchingViewEng>
//     with TickerProviderStateMixin {
//   String topic;
//   int _totalTasks;
//   int _currentTask;
//   int solved;
//   int totalQuestions;
//   bool _isLoaded;
//   int temp = 0;
//   String _buttonText;
//   AnimationController animationController;
//   AnimationController timeController;
//   AnimationController alertBox;
//   Animation<Offset> _moveOutOfTheScreen;
//   Animation<Offset> _alertBoxPos;
//   Animation<double> _rotate;
//   CurvedAnimation _curvedAnimation;
//   CurvedAnimation _alertBoxCurve;
//   List<Map<String, String>> _cards;
//   // int index, length;
//   bool _isPressed;
//   String _time;

//   Future<List<SME>> questionList;
//   SMEController smc;
//   _SMState({this.topic});

//   @override
//   void initState() {
//     //print(widget.questionList.elementAt(0).banglaSentence);

//     super.initState();
//     _isLoaded = false;
//     _totalTasks = 5;
//     _currentTask = 1;
//     _buttonText = "Get Next";
//     //getQuestions();

//     _cards = new List<Map<String, String>>();
//     for (int i = 0; i < _totalTasks; i++) {
//       _cards.add({
//         "1: Loading": "2: Loading",
//         "3: Loading": "4: Loading",
//         "5: Loading": "6: Loading"
//       });
//     }
//     // _cards = new List();
//     // for(int i=0;i<_totalTasks;i++){
//     //   _cards.add(_options[i])
//     // }

//     _isPressed = false;
//     solved = 0;
//     totalQuestions = _cards.length * 3;

//     animationController =
//         AnimationController(vsync: this, duration: Duration(milliseconds: 600));

//     timeController =
//         AnimationController(vsync: this, duration: Duration(seconds: 120));
//     timeController.reverse(
//         from: timeController.value == 0 ? 1 : timeController.value);

//     timeController.addListener(() {
//       if (_time == "0:00") {
//         print("timer stopped");
//         TimedialogBoxShown();
//       }
//     });

//     alertBox =
//         AnimationController(vsync: this, duration: Duration(milliseconds: 600));

//     _curvedAnimation =
//         CurvedAnimation(parent: animationController, curve: Curves.easeOut);
//     _alertBoxCurve = CurvedAnimation(parent: alertBox, curve: Curves.ease);

//     _moveOutOfTheScreen =
//         new Tween<Offset>(begin: Offset(0.0, 0.0), end: Offset(-500.0, 200.0))
//             .animate(_curvedAnimation)
//               ..addListener(() {
//                 setState(() {});
//               });

//     _rotate = new Tween<double>(begin: 0, end: -1).animate(_curvedAnimation);

//     _alertBoxPos = new Tween<Offset>().animate(_alertBoxCurve)
//       ..addListener(() {
//         setState(() {});
//       });
//   }

//   //  @override
//   // void dispose() {
//   //   super.dispose();
//   //   smc.deleteSM();
//   // }

//   @override
//   Widget build(BuildContext context) {
//     return ScopedModelDescendant(
//         builder: (BuildContext context, Widget child, MainModel model) {
//       //topic=ModalRoute.of(context).settings.arguments;
//       //topic=ModalRoute.of(context).settings.arguments;
//       if (temp == 0) {
//         getQuestions(model);
//         temp++;
//       }
//       return WillPopScope(
//           onWillPop: _onWillPopPressed,
//           child:
//               // Card(
//               //   color: Color(0xF2F2F2),
//               //   child:
//               Stack(
//             children: <Widget>[
//               Positioned(
//                   top: 49,
//                   //bottom: 650,
//                   left: 20,
//                   //right: 20,
//                   width: 194,
//                   height: 49,
//                   child: Card(
//                       shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(29.5)),
//                       child: Stack(
//                         children: <Widget>[
//                           Positioned(
//                             left: 5,
//                             width: 10,
//                             top: -2,
//                             child: IconButton(
//                               onPressed: //(){print("IconButton pressed");},
//                                   _onWillPopPressed,
//                               icon: Icon(Icons.arrow_back_ios),
//                             ),
//                           ),
//                           Positioned(
//                             left: 52,
//                             right: 76,
//                             top: 14,
//                             bottom: 13,
//                             child: Text("Remaining",
//                                 style: TextStyle(
//                                     color: Color(0xFF2E303E), fontSize: 12)),
//                           ),
//                           Positioned(
//                             left: 136,
//                             right: 26,
//                             top: 14,
//                             bottom: 13,
//                             child: AnimatedBuilder(
//                                 animation: timeController,
//                                 builder: (_, Widget child) {
//                                   return Text(
//                                     timeString,
//                                     style: TextStyle(
//                                         color: Color(0xFFE27777), fontSize: 12),
//                                   );
//                                 }),
//                           )
//                         ],
//                       ))),
//               RemainingTasks(model.smETotalTasks, model.smECurrentTask),
//               Positioned(
//                   top: 144,
//                   bottom: 120,
//                   left: 20,
//                   right: 20,
//                   child: Stack(
//                       children: model.smEQuestionList.reversed.map((card) {
//                     if (model.smEQuestionList.indexOf(card) == 0) {
//                       // print("here"+_cards.indexOf(card).toString());
//                       // print(_options);
//                       return (Transform.translate(
//                           offset: moveValue(card,model),
//                           child: Transform.rotate(
//                               angle: rotateValue(card,model),
//                               child: OptionCardSME(
//                                   card, bottomNotification, ))));
//                     } else {
//                       return Container();
//                     }
//                   }).toList())),
//               Positioned(
//                 top: 675,
//                 //bottom: 0,
//                 left: 20,
//                 width: 320,
//                 height: 63,
//                 child: RaisedButton(
//                   onPressed: () {
//                     model.smEIsPressed = true;
//                     if (model.smECurrentTask == model.smETotalTasks) {
//                       _onWillPopPressed();
//                     } else {
//                       animationController.forward().whenComplete(() {
//                         setState(() {
//                           if (model.smECurrentTask < model.smETotalTasks) model.smECurrentTask++;

//                           animationController.reset();
//                           model.smEQuestionList.removeAt(0);

//                           model.smEIsPressed = false;
//                         });
//                       });
//                     }

//                     // if(length>0){
//                     //   index = (index+1)%length;

//                     // }
//                   },
//                   child: Stack(
//                     children: <Widget>[
//                       Positioned(
//                         top: 18,
//                         bottom: 28,
//                         left: 122.5,
//                         child: Text(
//                           model.smEButtonText,
//                           style: TextStyle(
//                             fontSize: 15,
//                           ),
//                         ),
//                       )
//                     ],
//                   ),
//                   shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(23)),
//                   textColor: Colors.white,
//                   //highlightColor: Colors.red,
//                   color: Color(0xFF8577E2),
//                   //elevation: 1,
//                   //highlightElevation: 0.5,
//                 ),
//               ),
//               Positioned(
//                 top: MediaQuery.of(context).size.height,
//                 bottom: -300,
//                 left: 20,
//                 right: 20,
//                 child: Transform.translate(
//                   offset: alertMoveValue(),
//                   child: Container(
//                     color: Colors.green,
//                     // height: 30,
//                     // width: 60,
//                   ),
//                 ),
//               )
//             ],
//           ));
//     });
//   }

//   Offset moveValue(card,MainModel model) {
//     if (model.smEQuestionList.indexOf(card) == 0 && model.smEIsPressed)
//       return _moveOutOfTheScreen.value;
//     return Offset(0.0, 0.0);
//   }

//   Offset alertMoveValue() {
//     if (alertBox.value <= 0.5 && alertBox.status == AnimationStatus.forward) {
//       return Offset(alertBox.value * 100, alertBox.value * 100);
//     } else if (alertBox.value > 0.5 &&
//         alertBox.status == AnimationStatus.forward)
//       return Offset((1 - alertBox.value) * 100, (1 - alertBox.value) * 100);

//     return Offset(0.0, 0.0);
//   }

//   double rotateValue(card,MainModel model) {
//     if (model.smEQuestionList.indexOf(card) == 0 && model.smEIsPressed) return _rotate.value;
//     return 0.0;
//   }

//   String get timeString {
//     Duration duration;
//     if (_isLoaded == true) {
//       duration = timeController.duration * timeController.value;
//       String temp =
//           '${duration.inMinutes % 60}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
//       _time = temp;

//       //print(time);
//       return temp;
//     }

//     return "";
//   }

//   Future<bool> _onWillPopPressed() {
//     timeController.stop();
//     animationController.stop();

//     return showDialog(
//         context: context,
//         builder: (context) => AlertDialog(
//               shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(30)),
//               title: Text("Do You Really Want To Exit?"),
//               actions: <Widget>[
//                 FlatButton(
//                   child: Text("Yes"),
//                   onPressed: () {
//                     //smc.deleteSM();
//                     Navigator.of(context).pushReplacementNamed("/home");
//                   },
//                 ),
//                 FlatButton(
//                     child: Text("No"),
//                     onPressed: () {
//                       timeController.reverse(
//                           from: timeController.value == 0.0
//                               ? 1.0
//                               : timeController.value);
//                       Navigator.pop(context, false);
//                       animationController.reset();
//                     })
//               ],
//             ));
//   }

//   Future<bool> TimedialogBoxShown() {
//     return showDialog(
//         context: context,
//         builder: (context) => AlertDialog(
//               shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(30)),
//               //backgroundColor: Colors.white,
//               title: Text(
//                   "Sorry !!!! Your time is up . You got $solved out of $totalQuestions . " +
//                       "Do you want to continue?"),
//               actions: <Widget>[
//                 FlatButton(
//                   child: Text("Yes"),
//                   onPressed: () => Navigator.of(context)
//                       .pushReplacementNamed("/sentencematchingenglish"),
//                 ),
//                 FlatButton(
//                   child: Text("No"),
//                   onPressed: () {
//                     //smc.deleteSM();
//                     Navigator.of(context).pushReplacementNamed("/home");
//                   },
//                 )
//               ],
//             ));
//   }

//   void scoreKeeping(MainModel model) {
//     solved++;

//     if (time == "0:00") solved--;
//     print(solved);
//   }

//   void bottomNotification(bool correct,MainModel model) {
//     Color color = Colors.red;
//     String text = "Wrong Answer!";

//     if (correct == true && time != "0:00") {
//       color = Colors.green;
//       solved++;
//       text = "Correct Answer!";
//     }

//     if (time != "0:00") {
//       //print("Here");
//       //alertBox.forward();
//       timeController.stop();
//       showModalBottomSheet(
//           context: context,
//           builder: (context) {
//             return Container(
//               color: //Color.fromARGB(3, 0, 255, 0),
//                   color.withOpacity(0.3),
//               height: 100,
//               child: Center(
//                   child: Text(
//                 text,
//                 style: TextStyle(fontSize: 30, color: color),
//               )),
//             );
//           });
//     }
//   }

//   void getQuestions(MainModel model) async {
//     smc = new SMEController();
//     smc.getSMList(model.user.token, model.currentTopic.id).then((qsList) {
//       setState(() {
//         model.smEIsLoaded = true;
//         _isLoaded = true;
//         timeController.reverse(
//             from: timeController.value == 0 ? 1 : timeController.value);

//         int jsonSetArrived = qsList.length ~/ 3;
//         print("jsonArrived: " + jsonSetArrived.toString());

//         model.smECurrentTask = 1;
//         model.smETotalTasks = jsonSetArrived;

//         model.smEQuestionList=new List<Map<TaskElementSME,TaskElementSME>>();
//         for (int i = 0; i < jsonSetArrived; i++) {
          
//           model.smEQuestionList.add(new Map<TaskElementSME, TaskElementSME>());
//         }
        

//         int jsonNo = 0, index;
//         qsList.forEach((qs) {
//           index = (jsonNo ~/ 3);
//           TaskElementSME seg1 = TaskElementSME(sentence: qs.firstSegment, taskId: qs.taskId, specificTaskId: qs.specificTaskId);
//           TaskElementSME seg2 = TaskElementSME(sentence: qs.firstSegment, taskId:qs.taskId, specificTaskId: qs.specificTaskId);          
//           model.smEQuestionList.elementAt(index)[seg1] = seg2;

//           jsonNo++;
//         });
//       });
//     });
//   }

//   String get time => _time;
// }
