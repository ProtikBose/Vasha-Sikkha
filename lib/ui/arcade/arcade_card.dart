import 'dart:io';
import 'dart:math';

import 'package:Dimik/ScopedModel/mainmodel.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class ArcadeCard extends StatelessWidget {
  String currentGame = "";
  Color c1, c2;
  ArcadeCard({this.currentGame, this.c1, this.c2});
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant(
      builder: (BuildContext context, Widget child, MainModel model) {
        return Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                // Where the linear gradient begins and ends
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                // Add one stop for each color. Stops should increase from 0 to 1
                stops: [0.1, 0.9],
                colors: [
                  c1,
                  c2,
                ],
              ),
              borderRadius: new BorderRadius.all(const Radius.circular(35))),
          child: InkWell(
            onTap: () {
              model.pwloading = true;
              model.wploading = true;
              model.tfloading = true;
              model.ltloading = true;
              model.sfsloading = true;
              model.fbwloading = true;
              model.mixloading = true;
              model.mix_active = false;
              model.currentTopic = model.AllTopic[0];
              model.current = 1;
              switch (currentGame) {
                case 'Fill in the Blanks Word':
                  Navigator.pushNamed(context, '/fbword');
                  break;

                case 'Word to Picture':
                  Navigator.pushNamed(context, '/wordpicture');
                  break;
                case 'Picture to Word':
                  Navigator.pushNamed(context, '/pictureword');
                  break;
                case 'True False':
                  Navigator.pushNamed(context, '/truefalse');
                  break;

                case 'Listen to Word':
                  Navigator.pushNamed(context, '/lwtask');
                  break;

                default:
              }
            },
            child: Container(
              height: 450.0 / 948.0 * MediaQuery.of(context).size.height,
              child: Stack(children: <Widget>[
                Positioned(
                  top: 0,
                  left: 0,
                  child: Container(
                      height:
                          385.0 / 948.0 * MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width * .785,
                      decoration: BoxDecoration(
                        border: Border.all(color: c1, width: 1),
                        color: Colors.white,
                        borderRadius: new BorderRadius.only(
                            topLeft: const Radius.circular(35),
                            topRight: const Radius.circular(35),
                            bottomRight: const Radius.circular(35)),
                      )),
                ),
                Positioned(
                  top: 40,
                  left: 40,
                  child: Text(
                    currentGame,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 25,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ]),
            ),
          ),
          margin: EdgeInsets.only(
              bottom: 35.0 / 948.0 * MediaQuery.of(context).size.height),
          //padding: EdgeInsets.all(20),
        );
      },
    );
  }
}
