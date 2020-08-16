import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LeaderBoardCard extends StatelessWidget {
  final double progress;
  final double highest;
  final int level;
  final String imgLink;
  final String username;

  LeaderBoardCard(
      {this.username, this.progress, this.level, this.highest, this.imgLink});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: <Widget>[
          Positioned(
            top: 20,
            left: 20,
            child: CircleAvatar(
              backgroundImage:
                  AssetImage(imgLink), //user profile image would be added
              minRadius: 25,
              maxRadius: 25,
            ),
          ),
          Positioned(
            top: 30,
            left: 100,
            child: Text(username),
          ),
          Positioned(
            top: 30,
            right: 25,
            child: Row(
              children: <Widget>[
                Image.asset(
                  'assets/img/crown.png',
                  scale: 30,
                ),
                Text(
                  ' ' + level.toString(),
                  style:
                      new TextStyle(fontSize: 12, fontWeight: FontWeight.w900),
                ),
              ],
            ),
          ),
          Positioned(
              top: 60,
              left: 100,
              right: 20,
              child: Row(
                children: [
                  Expanded(
                    child: LayoutBuilder(
                      builder:
                          (BuildContext context, BoxConstraints constraints) {
                        return Stack(
                          children: [
                            Container(
                              height: 3.0,
                              color: Colors.grey.withOpacity(0.1),
                            ),
                            AnimatedContainer(
                              height: 3.0,
                              width:
                                  (progress / highest) * constraints.maxWidth,
                              color: Colors.red,
                              duration: Duration(milliseconds: 300),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 8.0),
                    child: Text(
                      progress.toString(),
                      style: Theme.of(context).textTheme.caption,
                    ),
                  )
                ],
              ))
        ],
      ),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * (80 / 720),
      margin: EdgeInsets.fromLTRB(20, 16, 16, 16),
      decoration: BoxDecoration(
        color: Color.fromRGBO(255, 255, 255, 1),
        borderRadius: new BorderRadius.all(const Radius.circular(24)),
      ),
    );
  }
}
