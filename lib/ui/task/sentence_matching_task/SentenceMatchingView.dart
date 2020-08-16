// import 'package:Dimik/data/controller/sm.dart';
// import 'package:Dimik/models/sm.dart';
// import 'package:Dimik/ui/task/sentence_matching_task/OptionCard.dart';
// import 'package:Dimik/ui/task/sentence_matching_task/TaskElement.dart';
// import 'package:Dimik/view/responsive.dart';
// import 'package:flutter/material.dart';
// import './OptionView.dart';
// import '../../../view/widgets/topScreen.dart';
// import '../../../config.dart';
// import './EmptyOptionView.dart';
// import 'package:scoped_model/scoped_model.dart';
// import '../../../ScopedModel/mainmodel.dart';

// class SentenceMatchingView extends StatefulWidget {
//   //Map<String,String> _options = new Map<String, String>();
//   //Future<List<SM>>questionList;
//   String topic;
//   //SentenceMatchingView(this.topic);
//   @override
//   State<StatefulWidget> createState() {
//     return _SMState();
//     //return _SMState(_options);
//   }
// }

// class _SMState extends State<SentenceMatchingView>
//     with TickerProviderStateMixin {
//   int temp = 0;
//   bool _isLoaded = false;
//   int solved = 0;
//   int totalQuestions;
//   int _totalTasks = 5;
//   AnimationController animationController;
//   AnimationController timeController;
//   Animation<Offset> _moveOutOfTheScreen;
//   Animation<double> _rotate;
//   CurvedAnimation _curvedAnimation;
//   String _time;
//   SMController smc;

//   @override
//   void initState() {
//     super.initState();

//     //building the list of OptionCard views
//     //initializing the view with _options(a list of maps containing data for each OptionCard)

//     //print(_cards);

//     totalQuestions = 5 * 3;

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

//     _curvedAnimation =
//         CurvedAnimation(parent: animationController, curve: Curves.easeOut);
//     _moveOutOfTheScreen =
//         new Tween<Offset>(begin: Offset(0.0, 0.0), end: Offset(-500.0, 200.0))
//             .animate(_curvedAnimation)
//               ..addListener(() {
//                 setState(() {});
//               });
//     _rotate = new Tween<double>(begin: 0, end: -1).animate(_curvedAnimation);
//   }

//   @override
//   void dispose() {
//     super.dispose();
 
//   }

//   @override
//   Widget build(BuildContext context) {
//     return ScopedModelDescendant(
//         builder: (BuildContext context, Widget child, MainModel model) {
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
//               RemainingTasks(model.smTotalTasks, model.smCurrentTask),
//               Positioned(
//                   top: 144,
//                   bottom: 120,
//                   left: 20,
//                   right: 20,
//                   child: Stack(
//                       children: model.smQuestionList.reversed.map((card) {
//                     // print("_cards: ");
//                     // print(_cards);

//                     // print("card: ");
//                     // print(card);
//                     if (model.smQuestionList.indexOf(card) == 0) {
//                       // print("here"+_cards.indexOf(card).toString());
//                       // print(_options.elementAt(0));
//                       // print(_options);
//                       return (Transform.translate(
//                           offset: moveValue(card, model),
//                           child: Transform.rotate(
//                               angle: rotateValue(card, model),
//                               child: OptionCard(
//                                   card, bottomNotification))));
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
//                     model.smIsPressed = true;
//                     if (model.smCurrentTask == model.smTotalTasks) {
//                       _onWillPopPressed();
//                     } else {
//                       animationController.forward().whenComplete(() {
//                         setState(() {
//                           if (model.smCurrentTask < model.smTotalTasks) model.smCurrentTask++;

//                           animationController.reset();
//                           model.smQuestionList.removeAt(0);

//                           model.smIsPressed = false;
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
//                           model.smButtonText,
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
//               )
//             ],
//           )
//           //)
//           );
//     });
//   }

//   Offset moveValue(card, MainModel model) {
//     if (model.smQuestionList.indexOf(card) == 0 && model.smIsPressed)
//       return _moveOutOfTheScreen.value;
//     return Offset(0.0, 0.0);
//   }

//   double rotateValue(card, MainModel model) {
//     if (model.smQuestionList.indexOf(card) == 0 && model.smIsPressed) return _rotate.value;
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
//                     // dispose();
//                     // smc.deleteSM();
//                    // Navigator.of(context).pushReplacementNamed("/home");
//                     Navigator.pushReplacementNamed(
//                                       context, '/gameover',
//                                       arguments: 'sm');
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
//                       .pushReplacementNamed("/sentencematching"),
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
//     //print(model.smSolved);
//   }

//   void bottomNotification(bool correct, MainModel model) {
//     Color color = Colors.red;
//     String text = "Wrong Answer!";

//     if (correct == true && time != "0:00") {
//       color = Colors.green;
//       solved++;
//       text = "Correct Answer!";
//     }

//     if (time != "0:00") {
//       // timeController.stop();
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
//     smc = new SMController();
//     //print("Topic :" +topic);
//     smc.getSMList(model.user.token, model.currentTopic.id).then((qsList) {
//       setState(() {
//         model.smIsLoaded = true;
//         _isLoaded = true;
//         timeController.reverse(
//             from: timeController.value == 0 ? 1 : timeController.value);

//         int jsonSetArrived = qsList.length ~/ 3;
//         model.smTotalTasks = jsonSetArrived;
//         model.smCurrentTask =1;
//         model.smTotalQuestions = model.smTotalTasks*3;
//         model.smSolved = 0;
        

//         model.smQuestionList = new List<Map<TaskElement,TaskElement>>();
//         for (int i = 0; i < jsonSetArrived; i++) {
//           // _options[i] = new Map<String, String>();
//           model.smQuestionList.add(new Map<TaskElement, TaskElement>()); 
//         }

//         int jsonNo = 0, index;
//         qsList.forEach((qs) {
//           index = (jsonNo ~/ 3);
//           TaskElement ban = TaskElement(qs.banglaSentence, qs.taskID, qs.specificTaskID);
//           TaskElement eng = TaskElement(qs.englishSentence, qs.taskID, qs.specificTaskID);


//           model.smQuestionList.elementAt(index)[ban] = eng;
//           jsonNo++;
//         });
//       });
//     });
//   }

//   String get time => _time;
// }
