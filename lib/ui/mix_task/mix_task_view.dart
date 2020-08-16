import 'package:Dimik/ScopedModel/mainmodel.dart';
import 'package:Dimik/databaseChange/FBGapData.dart';
import 'package:Dimik/databaseChange/jumbleSentence.dart';
import 'package:Dimik/databaseChange/mcqData.dart';
import 'package:Dimik/models/fb.dart';
import 'package:Dimik/models/fb_word.dart';
import 'package:Dimik/models/jumbled_sentence.dart';
import 'package:Dimik/models/listening_item.dart';
import 'package:Dimik/models/mcq.dart';
import 'package:Dimik/models/pictureword.dart';
import 'package:Dimik/models/sm.dart';
import 'package:Dimik/models/sme.dart';
import 'package:Dimik/models/tf.dart';
import 'package:Dimik/models/wordpicture.dart';
import 'package:Dimik/ui/task/Fill_in_the_gaps/fillGapsControllerDragable.dart';
import 'package:Dimik/ui/task/Fill_in_the_gaps/fillGapsControllerDragable.dart'
    as prefix0;
import 'package:Dimik/ui/task/Fill_in_the_gaps_words/fb_word_card.dart';
import 'package:Dimik/ui/task/TrueFalse/true_false_card.dart';
import 'package:Dimik/ui/task/jumble_Sentence/jumble_SentenceDraggable.dart';
import 'package:Dimik/ui/task/jumble_Sentence/jumble_Sentence_stats.dart';
import 'package:Dimik/ui/task/listening_game/listening_card.dart';
import 'package:Dimik/ui/task/mcq_task/mcq_task_controller.dart';
import 'package:Dimik/ui/task/pictureWord/picture_word_card.dart';
import 'package:Dimik/ui/task/wordPicture/word_picture_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:scoped_model/scoped_model.dart';
import '../../models/memorygame.dart';
import '../task/memory_game/memory_game_question_card.dart';
import '../task/sentence_matching_task/OptionCard.dart';
import '../task/sentence_matching_task_eng/OptionCard.dart';

class MixTask extends StatefulWidget {
  bool _isLoaded = false;
  bool timer_flag = false;
  bool call_flag = false;
  int current = 1;
  bool randomize_flag = true;

  void stopRandomize() {
    randomize_flag = false;
  }

  @override
  State<StatefulWidget> createState() {
    return MixTaskState();
  }
}

class MixTaskState extends State<MixTask> with TickerProviderStateMixin {
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  // Timer _timer;
  // int _start = 60;
  AnimationController timeController;
  String _time;

  // void startTimer() {
  //   const oneSec = const Duration(seconds: 1);
  //   _timer = new Timer.periodic(
  //     oneSec,
  //     (Timer timer) => setState(
  //       () {
  //         if (_start < 1) {
  //           timer.cancel();
  //           ScopedModelDescendant(
  //               builder: (BuildContext context, Widget child, MainModel model) {
  //             model.increment();
  //             return;
  //           });
  //           Navigator.pushReplacementNamed(context, '/gameover',
  //               arguments: 'mixtask');
  //         } else {
  //           _start = _start - 1;
  //         }
  //       },
  //     ),
  //   );
  // }

  @override
  void initState() {
    super.initState();
    timeController =
        AnimationController(vsync: this, duration: Duration(seconds: 120));
    timeController.reverse(
        from: timeController.value == 0 ? 1 : timeController.value);

    timeController.addListener(() {
      if (_time == "0:00") {
        timeController.stop(canceled: true);
        Navigator.pushReplacementNamed(context, '/gameover',
            arguments: 'mixtask');
      }
    });
  }

  @override
  void dispose() {
    timeController.stop();
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
                                      model.scoreTF = 0;
                                      model.correctTF = 0;
                                      model.incorrectTF = 0;
                                      model.scorePW = 0;
                                      model.correctPW = 0;
                                      model.incorrectPW = 0;
                                      model.scoreWP = 0;
                                      model.correctWP = 0;
                                      model.incorrectWP = 0;
                                      model.scoreLT = 0;
                                      model.correctLT = 0;
                                      model.incorrectLT = 0;
                                      model.mixloading = true;
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
                  // Text(
                  //   _start < 10
                  //       ? '00:0' + _start.toString()
                  //       : '00:' + _start.toString(),
                  //   style: TextStyle(color: Colors.redAccent),
                  // ),
                  AnimatedBuilder(
                      animation: timeController,
                      builder: (_, Widget child) {
                        return Text(
                          timeString,
                          style:
                              TextStyle(color: Color(0xFFE27777), fontSize: 12),
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
    if (!widget.timer_flag) {
      //startTimer();
      widget.timer_flag = true;
    }
    return Scaffold(
        key: _scaffoldKey,
        backgroundColor: Color.fromRGBO(242, 242, 242, 1),
        body: ScopedModelDescendant(
            builder: (BuildContext context, Widget child, MainModel model) {
          if (!widget.call_flag) {
            //print("before generateMixTask");
            model.generateMixTask();
            widget._isLoaded = true;
            widget.call_flag = true;
          }
          return Container(
            child: model.isMixLoading
                ? Center(
                    child: CircularProgressIndicator(
                    backgroundColor: Colors.white,
                    strokeWidth: 1.5,
                  ))
                : model.mixtasks.length == 0
                    ? Container(
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Text('No Tasks Available'),
                              RaisedButton(
                                onPressed: () => Navigator.pop(context),
                                child: Text('Go Back to Home'),
                              )
                            ],
                          ),
                        ),
                      )
                    : Stack(
                        children: <Widget>[
                          Positioned(
                            top: (40.0 / 740) *
                                MediaQuery.of(context).size.height,
                            left: (20.0 / 360) *
                                MediaQuery.of(context).size.width,
                            child: progressDetails(model.mixtasks.length),
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
                                // itemCount: model.mixtasks.length >= 10
                                //     ? 10
                                //     : model.mixtasks.length,
                                itemCount: model.mixtasks.length,
                                itemBuilder: (BuildContext context, int index) {
                                  String currentGame =
                                      model.mixtasks[index].taskname;
                                  print(currentGame);
                                  switch (currentGame) {
                                    case 'WP':
                                      WordPicture wp = model.mixtasks[index];
                                      return WordPictureCard(
                                        wp,
                                        scaffoldKey: _scaffoldKey,
                                        controller: controller,
                                        current: model.current,
                                      );
                                      break;
                                    case 'PW':
                                      PictureWord pw = model.mixtasks[index];
                                      return PictureWordCard(
                                        pw,
                                        scaffoldKey: _scaffoldKey,
                                        controller: controller,
                                        current: model.current,
                                      );
                                      break;
                                    case 'True False':
                                      TF tf = model.mixtasks[index];
                                      return TrueFalseCard(
                                        index: index + 1,
                                        tf: tf,
                                        controller: controller,
                                        current: model.current,
                                        scaffoldKey: _scaffoldKey,
                                      );
                                      break;

                                    case 'LW':
                                      ListeningItem li = model.mixtasks[index];
                                      return ListeningCard(
                                        li,
                                        controller: controller,
                                        current: model.current,
                                        index: index + 1,
                                        scaffoldKey: _scaffoldKey,
                                      );
                                      break;

                                    case 'FBW':
                                      FB_Word fb_word = model.mixtasks[index];
                                      return FBWordCard(fb_word, _scaffoldKey,
                                          controller, model.current);
                                      break;

                                    case 'Sentence Matching':
                                      SMList smList = model.mixtasks[index];
                                      model.setSMQuestions(model, smList);
                                      model.smTotalQuestions += 3;
                                      return OptionCardSM(
                                          model.smQuestionList[0],
                                          model.orderSM,
                                          _scaffoldKey);
                                      break;

                                    case 'Sentence Matching English':
                                      SMEList smeList = model.mixtasks[index];
                                      model.setSMEQuestions(model, smeList);
                                      model.smETotalQuestions += 3;
                                      return OptionCardSME(
                                          model.smEQuestionList[0],
                                          model.orderSME,
                                          _scaffoldKey);
                                      break;

                                    case 'Memory Game':
                                      //print("Here in memory game");
                                      model.totalQuestionsMG =
                                          model.totalQuestionsMG + 1;
                                      MG mg = model.mixtasks[index];
                                      //mg.downloadImage("mg"/*+model.totalMGs.toString()*/+index.toString());
                                      //mg.imageLink="https://upload.wikimedia.org/wikipedia/en/2/21/Web_of_Spider-Man_Vol_1_129-1.png";
                                      //mg.downloadImage("mg"+index.toString());

                                      print("taskID: " + mg.taskId.toString());
                                      print("spectaskID: " +
                                          mg.specificTaskId.toString() +
                                          "\n\n");

                                      model.mgCardMixTask(mg);
                                      print("taskID: " +
                                          model.mgQuestionList[0].taskId
                                              .toString());
                                      print("spectaskID: " +
                                          model.mgQuestionList[0].specificTaskId
                                              .toString());
                                      // model.mgQuestionList.add(mg);
                                      // model.initListsMG();

                                      return QuestionCardGM(
                                        card: model.mgQuestionList[0],
                                        index: 0,
                                        scaffoldKey: _scaffoldKey,
                                      );
                                      break;

                                    case 'FB':
                                      model.setFBVal = new List();
                                      List<String> options = new List();
                                      List<String> correctAns = new List();
                                      FB fb = model.mixtasks[index];
                                      options = fb.options;
                                      correctAns = fb.answers;
                                      model.fbtotalScore = model.fbtotalScore +
                                          fb.answers.length;
                                      model.getFBVal.add(new FbGap(
                                          fb.question,
                                          options,
                                          correctAns,
                                          fb.taskId,
                                          fb.specificTaskId,
                                          fb.explanation));
                                      return dragableFG.draggableFB(
                                        title: model.getFBVal[0],
                                        scaffoldKey: _scaffoldKey,
                                      );
                                      break;

                                    case 'Jumbled Sentence':
                                      model.setVal = new List();
                                      String question;
                                      //List<String>questionPart=question.split(' ');
                                      String correctAns;

                                      //jumbleSentence jS=new jumbleSentence(question, questionPart, correctAns, correctPart);
                                      //val.add(jS);
                                      List<String> options = new List();
                                      Jumbled jS = model.mixtasks[index];
                                      options = jS.segments;
                                      correctAns = jS.englishSentence;
                                      List<String> correctPart = jS.segments;
                                      model.jumbledtotalScore =
                                          model.jumbledtotalScore +
                                              jS.segments.length;
                                      model.getVal.add(new jumbleSentence(
                                          "",
                                          options,
                                          correctAns,
                                          correctPart,
                                          jS.taskId,
                                          jS.specificTaskId));
                                      return dragableFGJum(
                                        title: model.getVal[0],
                                        scaffoldKey: _scaffoldKey,
                                      );
                                      break;
                                    case 'MCQ':
                                      model.setMCQVal = new List();
                                      List<String> options = new List();
                                      MCQ mcq = model.mixtasks[index];
                                      List<String> correctAns = new List();
                                      options = mcq.options;
                                      correctAns = mcq.answer;
                                      model.mcqtotalScore =
                                          model.mcqtotalScore +
                                              correctAns.length;
                                      model.getMCQVal.add(new MCQDataBase(
                                          mcq.question,
                                          options,
                                          correctAns,
                                          mcq.taskId,
                                          mcq.specificTaskId,
                                          mcq.explanation));
                                      return controllerClass(
                                          title: model.getMCQVal[0],
                                          scaffoldKey: _scaffoldKey);
                                      break;
                                    default:
                                      print("I am in default");
                                      return Container();
                                  }
                                },
                              ),
                            ),
                          ),
                          Positioned(
                            top: (677.0 / 740.0) *
                                MediaQuery.of(context).size.height,
                            left: (20.0 / 360.0) *
                                MediaQuery.of(context).size.width,
                            right: (20.0 / 360.0) *
                                MediaQuery.of(context).size.width,
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
                                    model.currSolvedMG = 0;
                                    widget.current = model.current;
                                    if (widget.current < model.tasklen) {
                                      model.current++;
                                      widget.current = model.current;
                                    } else {
                                      //model.increment();
                                      Navigator.pushReplacementNamed(
                                          context, '/gameover',
                                          arguments: 'mixtask');
                                    }
                                  });
                                  controller.nextPage(
                                      curve: _kCurve, duration: _kDuration);
                                },
                                child: Text(
                                  'Skip',
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

  String get timeString {
    Duration duration;
    if (widget.timer_flag == true) {
      duration = timeController.duration * timeController.value;
      String temp =
          '${duration.inMinutes % 60}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
      _time = temp;

      //print(time);
      return temp;
    }

    return "";
  }
}
