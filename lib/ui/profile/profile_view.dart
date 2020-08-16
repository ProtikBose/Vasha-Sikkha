import 'package:Dimik/ScopedModel/mainmodel.dart';
import 'package:Dimik/ui/profile/halloffamecard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => new _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  PageController _hallofFamepageController;
  PageController _achievementsController;

  @override
  void initState() {
    super.initState();
    _hallofFamepageController =
        PageController(initialPage: 0, viewportFraction: 0.75);
    _achievementsController =
        PageController(initialPage: 0, viewportFraction: 0.75);
  }

  Widget profileHeader(String image_url) {
    return Container(
      height: MediaQuery.of(context).size.height * (300.0 / 740.0),
      child: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              color: Color.fromRGBO(224, 224, 224, 1),
              borderRadius:
                  new BorderRadius.only(bottomLeft: const Radius.circular(40)),
            ),
            height: MediaQuery.of(context).size.height * (212.0 / 740.0),
            width: MediaQuery.of(context).size.width,
          ),
          Positioned(
            left: MediaQuery.of(context).size.width * (29.0 / 360.0),
            top: MediaQuery.of(context).size.height * (45.0 / 720.0),
            child: Container(
              child: Row(
                children: <Widget>[
                  IconButton(
                      icon: Icon(CupertinoIcons.back),
                      onPressed: () => Navigator.pop(context)),
                  Text(
                    'Profile',
                    style: new TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color.fromRGBO(113, 113, 113, 1)),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * (140.0 / 720.0),
            left: MediaQuery.of(context).size.width * (110.0 / 360.0),
            right: MediaQuery.of(context).size.width * (110.0 / 360.0),
            child: Hero(
              tag: 'Profile',
              child: CircleAvatar(
                  radius: 70,
                  backgroundImage: AssetImage('assets/img/fortnite.jpg')),
            ),
          )
        ],
      ),
    );
  }

  Widget uiProfile() {
    return ScopedModelDescendant(
      builder: (BuildContext context, Widget child, MainModel model) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            profileHeader(model.user.imageLink),
            Center(
                child: Text(
              model.user.username, //user full name
              style: new TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            )),
            Center(
                child: Text(
              '@' + model.user.email, //user full name
              style: new TextStyle(fontSize: 16, fontWeight: FontWeight.w100),
            )),
            Container(
              padding: EdgeInsets.fromLTRB(40, 18, 0, 18),
              child: Column(
                children: <Widget>[
                  Text(
                    'Hall of Fame', //user full name
                    style: new TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.all(25),
              height: 100,
              width: MediaQuery.of(context).size.width,
              child: PageView.builder(
                  itemBuilder: (BuildContext context, int index) {
                    return HallofFameCard(
                      title: model.halloffame[index],
                    );
                  },
                  itemCount: model.halloffame.length),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(40, 18, 0, 18),
              child: Column(
                children: <Widget>[
                  Text(
                    'Achievements', //user full name
                    style: new TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.all(25),
              height: 100,
              child: PageView.builder(
                  itemBuilder: (BuildContext context, int index) {
                    return HallofFameCard(
                      title: model.Achievements[index],
                    );
                  },
                  itemCount: model.Achievements.length),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: Color.fromRGBO(242, 242, 242, 1),
      body: uiProfile(),
    );
  }
}
