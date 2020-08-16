import 'package:Dimik/style/theme.dart' as prefix0;
import 'package:Dimik/ui/task/memory_game/optionButton.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:flip_card/flip_card.dart';
import '../../../ScopedModel/mainmodel.dart';
import 'package:Dimik/models/memorygame.dart';
import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';

class FlipCardBackView extends StatefulWidget {
  final MG card;
  GlobalKey<ScaffoldState> scaffoldKey;
  FlipCardBackView({this.card, this.scaffoldKey});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return FlipCardBackStats(card: card);
  }
}

class FlipCardBackStats extends State<FlipCardBackView> {
  MG card;
  FlipCardBackStats({this.card});
  List<Color> col = new List();
  List<String> correct = new List();
  List<String> option = new List();
  AudioPlayer audioPlayer;
  int option1 = 1, option2 = 1, option3 = 1, option4 = 1;
  bool disable1 = false, disable2 = false, disable3 = false, disable4 = false;

  @override
  void initState() {

    super.initState();

    // option.add("Dog");
    // option.add("Cat");
    // option.add("Mat");
    // option.add("Bat");

    // correct.add("Dog");
    // correct.add("Mat");

    for(int i=0;i<card.correctAnswers.length;i++){
      correct.add(card.correctAnswers.elementAt(i));
      print(correct);
    }

    for(int i=0;i<card.options.length;i++){
      option.add(card.options.elementAt(i));
    }

    for (int i = 0; i < option.length; i++) {
      col.add(Colors.grey);
    }
  }
    Future successAudio() async {
    audioPlayer = await AudioCache().play("audios/success.mp3");
  }

  Future errorAudio() async {
    audioPlayer = await AudioCache().play("audios/error.mp3");
  }

  void disableAll() {
    disable1 = disable2 = disable3 = disable4 = true;
  }

  void CorrectAnswer(MainModel model) {
    setState(() {
      disableAll();
    });
    successAudio();
    widget.scaffoldKey.currentState
        .showBottomSheet<Null>((BuildContext context) {
      return Container(
          decoration: BoxDecoration(
              color: Color.fromRGBO(83, 195, 111, 1),
              borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(30),
                  topRight: const Radius.circular(30))),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.20,
          child: Stack(
            children: <Widget>[
              Positioned(
                top: 20,
                left: 20,
                child: Text(
                  model.explanationSM[0],
                  style: TextStyle(color: Colors.white),
                ),
              ),
              Positioned(
                top: MediaQuery.of(context).size.height * 0.10,
                left: MediaQuery.of(context).size.width * 0.40,
                child: FlatButton(
                  child: Text(
                    'Got It',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ],
          ));
    });
  }

  void WrongAnswer(MainModel model) {
    setState(() {
      disableAll();
    });
    errorAudio();
    widget.scaffoldKey.currentState
        .showBottomSheet<Null>((BuildContext context) {
      return Container(
          decoration: BoxDecoration(
              color: Color.fromRGBO(255, 131, 131, 1),
              borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(30),
                  topRight: const Radius.circular(30))),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.20,
          child: Stack(
            children: <Widget>[
              Positioned(
                top: 20,
                left: 20,
                child: Text(
                  model.explanationSM[0],
                  style: TextStyle(color: Colors.white),
                ),
              ),
              Positioned(
                top: MediaQuery.of(context).size.height * 0.10,
                left: MediaQuery.of(context).size.width * 0.40,
                child: FlatButton(
                  child: Text(
                    'Wrong Answer',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ],
          ));
    });
  }

  bool checkButton(String val, int index, MainModel model) {
    bool flag;
    ;
    if (correct.contains(val)) {
      model.solvedMG = model.solvedMG + 1;
      model.currSolvedMG = model.currSolvedMG + 1;
      col[index] = Colors.green;
      correct.remove(val);
      flag = true;
      CorrectAnswer(model);

      if(model.currSolvedMG==widget.card.correctAnswers.length)
        model.postVerdict(card, 1);
      
      
    } else {
      col[index] = Colors.red;
      flag = false;
      WrongAnswer(model);
      //model.postVerdict(card, 0);
    }
    setState(() {});
    return flag;
  }

  @override
  Widget build(BuildContext context) {
    
    return ScopedModelDescendant<MainModel>(
        builder: (BuildContext context, Widget child, MainModel model) {
      return Stack(children: <Widget>[
        Positioned(
            top: MediaQuery.of(context).size.height * (30 / 740),
            bottom: MediaQuery.of(context).size.height * (30 / 740),
            left: MediaQuery.of(context).size.width * (20 / 370),
            right: MediaQuery.of(context).size.width * (20 / 370),
            child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0)),
                child: Stack(children: <Widget>[
                  Positioned(
                    //left: 200,
                    //top: 10,
                    top: MediaQuery.of(context).size.height * (20 / 453),
                    //bottom: 270,
                    left: MediaQuery.of(context).size.width * (2 / 320),
                    right: MediaQuery.of(context).size.width * (2 / 320),
                    child: Container(
                        padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * (18 / 320), 
                                      right: MediaQuery.of(context).size.width * (18 / 320)),
                        width: MediaQuery.of(context).size.width,
                        child: Wrap(
                            // spacing: 8.0,
                            //runSpacing: 4.0,
                            //children: drawQuestion(context)

                            children: <Widget>[
                              Text(
                                "What can you find from the picture ?",
                                style: TextStyle(fontSize: 28),
                              ),
                            ])
                        //Text("data")

                        ),
                  ),
                  Positioned(
                      top: MediaQuery.of(context).size.width * (150 / 453),
                      left: MediaQuery.of(context).size.width * (.1 / 320),
                      right: MediaQuery.of(context).size.width * (.1 / 320),
                      child: Container(
                        padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * (15 / 320), 
                                  right: MediaQuery.of(context).size.width * (15 / 320), 
                                     top: MediaQuery.of(context).size.height * (15 / 320)
                                     ),
                        width: MediaQuery.of(context).size.width,
                        child: Wrap(
                          spacing: 8.0,
                          runSpacing: 4.0,
                          children: drawButton(context, model),
                        ),
                      ))
                ])))
      ]);
    });
  }

  List<Widget> drawButton(BuildContext context, MainModel model) {
    List<Widget> tiles = new List();
    for (int i = 0; i < option.length; i++) {
      tiles.add(OptionButton(
        text: option.elementAt(i),
        col: col.elementAt(i),
        index: i,
        func: checkButton,
        model: model,
      ));
    }

    return List<Widget>.generate(option.length, (i) {
      return tiles.elementAt(i);
    });
  }
}
