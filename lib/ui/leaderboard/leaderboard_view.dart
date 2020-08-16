import 'package:Dimik/ScopedModel/mainmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import 'leaderboard_card.dart';

class LeaderBoard extends StatefulWidget {
  bool call_flag = false;
  @override
  State<StatefulWidget> createState() {
    return LeaderBoardState();
  }
}

class LeaderBoardState extends State<LeaderBoard> {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant(
        builder: (BuildContext context, Widget child, MainModel model) {
      if (!widget.call_flag) {
        model.generateLeaderBoard();
        widget.call_flag = true;
      }
      return Scaffold(
        appBar: AppBar(
          title: Text('Leaderboard'),
          leading: IconButton(
              icon: Icon(Icons.arrow_back_ios),
              onPressed: () {
                Navigator.pop(context);
                model.isLBLoading = false;
              }),
        ),
        body: model.isLBLoading
            ? Container(
                child: Center(
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.white,
                    strokeWidth: 1.5,
                  ),
                ),
              )
            : ListView.builder(
                itemBuilder: (BuildContext context, int index) {
                  return LeaderBoardCard(
                    username: model.listlb[index].username,
                    highest: 1000.0,
                    imgLink: model.listlb[index].imgLink,
                    level: model.listlb[index].level,
                    progress: model.listlb[index].progress,
                  );
                },
                itemCount: model.listlb.length,
              ),
      );
    });
  }
}
