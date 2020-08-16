import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:flip_card/flip_card.dart';
import '../../../ScopedModel/mainmodel.dart';

class FlipCardFrontView extends StatelessWidget {
  final String imageLink;

  FlipCardFrontView({this.imageLink});

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
        builder: (BuildContext context, Widget child, MainModel model) {
      return Stack(children: <Widget>[
        Positioned(
          top: MediaQuery.of(context).size.height * (23 / 740),
          bottom: MediaQuery.of(context).size.height * (24 / 740),
          left: MediaQuery.of(context).size.width * (20 / 370),
          right: MediaQuery.of(context).size.width * (20 / 370),
          // top: 143,
          // bottom:  144,
          // left:  20,
          // right: 20,
          child: ClipRRect(
              borderRadius: BorderRadius.circular(30.0),
              child: Image.asset(
                imageLink,
                height: MediaQuery.of(context).size.height /** (497 / 740)*/,
                width: MediaQuery.of(context).size.width  /*(270 / 370)*/,
                fit: BoxFit.cover,
              )),
        ),
      ]);
    },
    rebuildOnChange: false
    );
  }
}
