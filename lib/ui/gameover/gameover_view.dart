import 'package:Dimik/ScopedModel/mainmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_circular_chart/flutter_circular_chart.dart';
//import 'package:pimp_my_button/pimp_my_button.dart';
import 'package:scoped_model/scoped_model.dart';

class GameOver extends StatefulWidget {
  @override
  GameOverState createState() => GameOverState();
}

class GameOverState extends State<GameOver>
    with SingleTickerProviderStateMixin {
  bool flag = false;
  AnimationController _animationController;
  final GlobalKey<AnimatedCircularChartState> _chartKey =
      new GlobalKey<AnimatedCircularChartState>();

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(duration: Duration(seconds: 15), vsync: this)
          ..repeat(
            period: Duration(seconds: 30),
          );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  _makeFirework(AnimationController controller) {
    Future.delayed(
        Duration(seconds: 0),
        () => controller.forward(from: 0).then((_) async {
              await Future.delayed(Duration(seconds: 0));
              _makeFirework(controller);
            }));
  }

  @override
  Widget build(BuildContext context) {
    _animationController.forward(from: 0);
    return ScopedModelDescendant(
      builder: (BuildContext context, Widget child, MainModel model) {
        String task_name = ModalRoute.of(context).settings.arguments;
        int correct, incorrect, total, score;

        switch (task_name) {
          case 'mixtask':
            // correct = model.tfcorrect +
            //     model.pwcorrect +
            //     model.wpcorrect +
            //     model.fbwcorrect +
            //     model.ltcorrect;
            // incorrect = model.tfincorrect +
            //     model.pwincorrect +
            //     model.wpincorrect +
            //     model.ltincorrect;
            // total = correct + incorrect;
            // score = model.trueFalseScore +
            //     model.pwScore +
            //     model.wpScore +
            //     model.ltScore +
            //     model.fbwScore;
            correct = model.tfcorrect +
                model.pwcorrect +
                model.wpcorrect +
                model.fbwcorrect +
                model.ltcorrect;
            incorrect = model.tfincorrect +
                model.pwincorrect +
                model.wpincorrect +
                model.fbwincorrect +
                model.ltincorrect;

            total = correct + incorrect;

            int correct2 = model.mcqcorrect +
                model.jumbledcorrect +
                model.smSolved +
                model.smESolved +
                model.fbcorrect +
                model.solvedMG;

            int total2 = model.fbtotalScore +
                model.mcqtotalScore +
                model.jumbledtotalScore +
                model.smTotalTasks +
                model.smETotalTasks +
                model.totalQuestionsMG;
            int incorrect2 = total2 - correct2;
            correct = correct + correct2;
            incorrect = incorrect + incorrect2;
            int score2 = correct2;
            score = model.trueFalseScore +
                model.pwScore +
                model.wpScore +
                model.ltScore +
                model.fbwScore +
                score2;
            total = total + total2;
            break;

          case 'fillgaps':
            correct = model.fbcorrect;
            score = model.fbcorrect;
            incorrect = model.fbtotalScore - model.fbcorrect;
            total = model.fbtotalScore;
            break;

          default:
        }

        List<CircularStackEntry> data = <CircularStackEntry>[
          new CircularStackEntry(
            <CircularSegmentEntry>[
              new CircularSegmentEntry((100.0 * correct / (1.0 * total)),
                  Color.fromRGBO(83, 195, 111, 1),
                  rankKey: 'Q1'),
              new CircularSegmentEntry((100.0 * incorrect / (1.0 * total)),
                  Color.fromRGBO(255, 131, 131, 1),
                  rankKey: 'Q2'),
            ],
            rankKey: 'Quarterly Profits',
          ),
        ];

        List<CircularStackEntry> correctEntry = <CircularStackEntry>[
          new CircularStackEntry(
            <CircularSegmentEntry>[
              new CircularSegmentEntry((100.0 * correct / (1.0 * total)),
                  Color.fromRGBO(83, 195, 111, 1),
                  rankKey: 'Q1'),
            ],
            rankKey: 'Quarterly Profits',
          ),
        ];

        List<CircularStackEntry> wrong = <CircularStackEntry>[
          new CircularStackEntry(
            <CircularSegmentEntry>[
              new CircularSegmentEntry((100.0 * incorrect / (1.0 * total)),
                  Color.fromRGBO(255, 131, 131, 1),
                  rankKey: 'Q1'),
            ],
            rankKey: 'Quarterly Profits',
          ),
        ];

        return Scaffold(
          backgroundColor: Color.fromRGBO(242, 242, 242, 1),
          body: Stack(
            children: <Widget>[
              Positioned(
                top: 300,
                left: 40,
                child: AnimatedBuilder(
                  animation: _animationController,
                  child: Image.asset(
                    'assets/img/ballon.png',
                    scale: 20,
                  ),
                  builder: (context, child) => Transform.translate(
                    child: child,
                    offset:
                        Offset(10, _animationController.value * -300 * 3.1416),
                  ),
                ),
              ),
              Positioned(
                top: 200,
                left: 250,
                child: AnimatedBuilder(
                  animation: _animationController,
                  child: Image.asset(
                    'assets/img/ballon.png',
                    scale: 20,
                  ),
                  builder: (context, child) => Transform.translate(
                    child: child,
                    offset:
                        Offset(10, _animationController.value * -300 * 3.1416),
                  ),
                ),
              ),
              Positioned(
                top: 100,
                left: 150,
                child: AnimatedBuilder(
                  animation: _animationController,
                  child: Image.asset(
                    'assets/img/ballon.png',
                    scale: 20,
                  ),
                  builder: (context, child) => Transform.translate(
                    child: child,
                    offset:
                        Offset(10, _animationController.value * -300 * 3.1416),
                  ),
                ),
              ),
              // Positioned(
              //   child: PimpedButton(
              //     particle: DemoParticle(),
              //     pimpedWidgetBuilder: (context, controller) {
              //       _makeFirework(controller);
              //       return Text(
              //         'Score',
              //         style:
              //             TextStyle(fontSize: 48, color: Colors.blueGrey[600]),
              //       );
              //     },
              //   ),
              //   top: (75.0 / 740.0) * MediaQuery.of(context).size.height,
              //   left: (117.0 / 360.0) * MediaQuery.of(context).size.width,
              // ),
              Positioned(
                top: (160.0 / 740.0) * MediaQuery.of(context).size.height,
                left: (75.0 / 360.0) * MediaQuery.of(context).size.width,
                child: AnimatedCircularChart(
                  holeRadius: 50,
                  holeLabel: score.toString(),
                  labelStyle: new TextStyle(
                    color: Colors.blueGrey[600],
                    fontWeight: FontWeight.bold,
                    fontSize: 48.0,
                  ),
                  key: _chartKey,
                  size: const Size(220.0, 220.0),
                  initialChartData: data,
                  chartType: CircularChartType.Radial,
                  edgeStyle: SegmentEdgeStyle.round,
                  percentageValues: true,
                ),
              ),
              Positioned(
                top: (430.0 / 740.0) * MediaQuery.of(context).size.height,
                left: (75.0 / 360.0) * MediaQuery.of(context).size.width,
                child: AnimatedCircularChart(
                  holeRadius: 15,
                  holeLabel: correct.toString(),
                  labelStyle: new TextStyle(
                    color: Colors.blueGrey[600],
                    fontWeight: FontWeight.bold,
                    fontSize: 25.0,
                  ),
                  size: const Size(90.0, 90.0),
                  initialChartData: correctEntry,
                  chartType: CircularChartType.Radial,
                  edgeStyle: SegmentEdgeStyle.round,
                  percentageValues: true,
                ),
              ),
              Positioned(
                top: (430.0 / 740.0) * MediaQuery.of(context).size.height,
                left: (200.0 / 360.0) * MediaQuery.of(context).size.width,
                child: AnimatedCircularChart(
                  holeRadius: 15,
                  holeLabel: incorrect.toString(),
                  labelStyle: new TextStyle(
                    color: Colors.blueGrey[600],
                    fontWeight: FontWeight.bold,
                    fontSize: 25.0,
                  ),
                  size: const Size(90.0, 90.0),
                  initialChartData: wrong,
                  chartType: CircularChartType.Radial,
                  edgeStyle: SegmentEdgeStyle.round,
                  percentageValues: true,
                ),
              ),
              Positioned(
                top: (400.0 / 740.0) * MediaQuery.of(context).size.height,
                left: (85.0 / 360.0) * MediaQuery.of(context).size.width,
                child: Text(
                  'Correct',
                  style: TextStyle(
                      color: Color.fromRGBO(83, 195, 111, 1),
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Positioned(
                top: (400.0 / 740.0) * MediaQuery.of(context).size.height,
                left: (215.0 / 360.0) * MediaQuery.of(context).size.width,
                child: Text(
                  'Wrong',
                  style: TextStyle(
                      color: Colors.redAccent,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),

              Positioned(
                  top: (545.0 / 740.0) * MediaQuery.of(context).size.height,
                  left: (40.0 / 360.0) * MediaQuery.of(context).size.width,
                  child: Container(
                      child: ButtonTheme(
                          shape: RoundedRectangleBorder(
                              borderRadius: new BorderRadius.all(
                                  const Radius.circular(30))),
                          child: FlatButton(
                              child: Text(
                                'Review Answers',
                                style: TextStyle(color: Colors.white),
                              ),
                              onPressed: () {
                                Navigator.pushNamed(context, '/history');
                              })),
                      height:
                          (60.0 / 740.0) * MediaQuery.of(context).size.height,
                      width:
                          (280.0 / 360.0) * MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          color: Color.fromRGBO(133, 119, 226, 1),
                          borderRadius: new BorderRadius.all(
                            const Radius.circular(30),
                          )))),

              Positioned(
                  top: (645.0 / 740.0) * MediaQuery.of(context).size.height,
                  left: (40.0 / 360.0) * MediaQuery.of(context).size.width,
                  child: Container(
                      child: ButtonTheme(
                        shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.all(
                                const Radius.circular(30))),
                        child: FlatButton(
                            child: Text(
                              'Take Back to Home',
                              style: TextStyle(color: Colors.white),
                            ),
                            onPressed: () {
                              model.isLoading = true;
                              model.getPercentage();
                              model.getLevel();
                              Navigator.pop(context);
                              Navigator.pushReplacementNamed(context, '/home');
                              model.clearHistory();
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
                              model.fbcorrect = 0;
                              model.fbtotalScore = 0;
                              model.fbtotalScore = 0;
                              model.fbcorrect = 0;
                              model.mcqtotalScore = 0;
                              model.mcqcorrect = 0;
                              model.smTotalQuestions = 0;
                              model.smSolved = 0;
                              model.jumbledtotalScore = 0;
                              model.jumbledcorrect = 0;
                              model.smESolved = 0;
                              model.smETotalQuestions = 0;
                              model.solvedMG = 0;
                              model.currSolvedMG = 0;
                              model.totalQuestionsMG = 0;
                              model.scoreFBW = 0;
                              model.correctFBW = 0;
                              model.incorrectFBW = 0;
                              model.mix_active = false;
                            }),
                      ),
                      height:
                          (60.0 / 740.0) * MediaQuery.of(context).size.height,
                      width:
                          (280.0 / 360.0) * MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          color: Color.fromRGBO(133, 119, 226, 1),
                          borderRadius: new BorderRadius.all(
                            const Radius.circular(30),
                          )))),
            ],
          ),
        );
      },
    );
  }
}
