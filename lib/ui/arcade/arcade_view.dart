import 'package:Dimik/ScopedModel/mainmodel.dart';
import 'package:Dimik/ui/arcade/arcade_card.dart';
import 'package:Dimik/ui/homePage/homeTopicCard.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:scoped_model/scoped_model.dart';

class ArcadeView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ArcadeViewState();
  }
}

class ArcadeViewState extends State<ArcadeView> {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant(
      builder: (BuildContext context, Widget child, MainModel model) {
        return model.isFavLoading
            ? Container(
                child: Center(
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.white,
                    strokeWidth: 1.5,
                  ),
                ),
              )
            : Stack(
                children: <Widget>[
                  Positioned(
                    child: Text(
                      !model.changeToBangla ? "Arcade" : 'Arcade',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 40),
                    ),
                    top: 75.0 / 948.0 * MediaQuery.of(context).size.height,
                    left: 40.0 / 375.0 * MediaQuery.of(context).size.width,
                  ),
                  Positioned(
                    top: 150.0 / 948.0 * MediaQuery.of(context).size.height,
                    left: 40.0 / 375.0 * MediaQuery.of(context).size.width,
                    child: model.isLoading
                        ? Center(
                            child: CircularProgressIndicator(
                              strokeWidth: 1.0,
                              valueColor: new AlwaysStoppedAnimation<Color>(
                                  Colors.blue),
                            ),
                          )
                        : SizedBox(
                            height: MediaQuery.of(context).size.height * .80,
                            width: MediaQuery.of(context).size.width -
                                (2 *
                                    40.0 /
                                    375.0 *
                                    MediaQuery.of(context).size.width),
                            child: ListView.builder(
                                physics: BouncingScrollPhysics(),
                                itemBuilder: (BuildContext context, int index) {
                                  return ArcadeCard(
                                      currentGame:
                                          model.listarcadeitem[index].game,
                                      c1: model.listarcadeitem[index].c1,
                                      c2: model.listarcadeitem[index].c2);
                                },
                                itemCount: model.listarcadeitem.length),
                          ),
                  )
                ],
              );
      },
    );
  }
}
