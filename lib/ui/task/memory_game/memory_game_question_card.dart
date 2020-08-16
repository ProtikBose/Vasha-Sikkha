import 'package:Dimik/models/memorygame.dart';
import 'package:Dimik/ui/task/memory_game/FlipCardBackFunction.dart';
import 'package:Dimik/ui/task/memory_game/FlipCardFront.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:flip_card/flip_card.dart';
import '../../../ScopedModel/mainmodel.dart';

class QuestionCardGM extends StatelessWidget {
  final MG card;
  final int index;
  GlobalKey<ScaffoldState> scaffoldKey;


  QuestionCardGM({this.card, this.index, this.scaffoldKey});

  @override
  Widget build(BuildContext context) {
    //print(index);
    return ScopedModelDescendant<MainModel>(
        builder: (BuildContext context, Widget child, MainModel model) {
      if (index == model.mgCurrentTask) model.mgFlipCard(index);
      return FlipCard(
        key: model.mgFlipKey.elementAt(index),
        flipOnTouch: false,
        front: FlipCardFrontView(imageLink: card.imageLink),
        back: FlipCardBackView(card: card, scaffoldKey: scaffoldKey,),
      );
    });
  }
}
