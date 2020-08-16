import 'dart:math';

import 'package:Dimik/ScopedModel/mainmodel.dart';
import 'package:Dimik/data/controller/user.dart';
import 'package:Dimik/models/quiz_item.dart';
import 'package:Dimik/models/topic.dart';
import 'package:Dimik/models/topic_task_state.dart';
import 'package:Dimik/models/user.dart';
import 'package:Dimik/ui/arcade/arcade_view.dart';
import 'package:Dimik/ui/homePage/homeTopicCard.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:scoped_model/scoped_model.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  int _key = 1;
  AnimationController _controller;
  bool quiz_generated = false;
  bool fav_generated = false;
  final GlobalKey _backdropKey = GlobalKey(debugLabel: 'Backdrop');
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  PageController _pageController;
  var currentPageValue = 0.0;
  var currentAnimationValue = 0.0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );

    _pageController = PageController(initialPage: 0, viewportFraction: 0.75);
    _pageController.addListener(() {
      setState(() {
        currentPageValue = _pageController.page;
        currentAnimationValue = _pageController.offset;
      });
    });

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
    ]);
  }

  @override
  void dispose() {
    super.dispose();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
    ]);
  }

  //uporer header part tuku
  Widget homeUIHeader(BuildContext context) {
    return ScopedModelDescendant(
        builder: (BuildContext context, Widget child, MainModel model) {
      return Container(
        decoration: BoxDecoration(
          color: Color.fromRGBO(255, 255, 255, 1),
          borderRadius:
              new BorderRadius.only(bottomLeft: const Radius.circular(40)),
          /*boxShadow: [
            new BoxShadow(
              color: Color.fromRGBO(183, 197, 240, 1),
              offset: new Offset(20.0, 10.0),
              blurRadius: 20.0,
            )
          ]*/
        ),
        height: MediaQuery.of(context).size.height * (212.0 / 740.0),
        width: MediaQuery.of(context).size.width,
        child: Container(
          padding: EdgeInsets.fromLTRB(
              MediaQuery.of(context).size.width * (29.0 / 360.0),
              MediaQuery.of(context).size.width * (49.0 / 360.0),
              MediaQuery.of(context).size.width * (40.0 / 360.0),
              0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      IconButton(
                          icon: Icon(Icons.menu),
                          onPressed: () =>
                              _scaffoldKey.currentState.openDrawer()),
                      Text(
                        !model.changeToBangla ? 'Vasha' : 'ভাষা',
                        style: new TextStyle(fontSize: 18),
                      ),
                      Text(
                        !model.changeToBangla ? 'Sikkha' : 'শিক্ষা',
                        style: new TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  Hero(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/profile');
                      },
                      child: CircleAvatar(
                        backgroundImage: AssetImage(
                            'assets/img/profile.jpg'), //user profile image would be added
                        minRadius: 23,
                        maxRadius: 23,
                      ),
                    ),
                    tag: 'Profile',
                  ),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * (18.0 / 720.0),
              ),
              Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      !model.changeToBangla ? '  Home' : '   হোম',
                      style: new TextStyle(
                          fontSize: 22, fontWeight: FontWeight.w900),
                    ),
                    SizedBox(
                        height:
                            MediaQuery.of(context).size.height * (1.0 / 740.0)),
                  ],
                ),
              )
            ],
          ),
        ),
      );
    });
  }

  Widget bottomNavBar(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          color: Color.fromRGBO(255, 255, 255, 1),
          borderRadius: new BorderRadius.only(
              topLeft: const Radius.circular(30),
              topRight: const Radius.circular(30)),
        ),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * (64.0 / 740.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            IconButton(
                onPressed: () {
                  setState(() {
                    _key = 1;
                  });
                },
                icon: Icon(
                  CupertinoIcons.home,
                  color: _key != 1
                      ? Color.fromRGBO(151, 152, 159, 1)
                      : Colors.black,
                )),
            IconButton(
              onPressed: () {
                setState(() {
                  _key = 3;
                });
              },
              icon: Icon(
                Icons.favorite_border,
                color:
                    _key != 3 ? Color.fromRGBO(151, 152, 159, 1) : Colors.black,
              ),
            ),
            IconButton(
              onPressed: () {
                setState(() {
                  _key = 4;
                });
              },
              icon: Icon(
                CupertinoIcons.game_controller,
                color:
                    _key != 4 ? Color.fromRGBO(151, 152, 159, 1) : Colors.black,
              ),
            )
          ],
        ));
  }

  Widget uiHome() {
    return ScopedModelDescendant(
      builder: (BuildContext context, Widget child, MainModel model) {
        if (!model.isTopicGenerated) {
          model.generateTopics();
          model.isTopicGenerated = true;
          print('I generated topics');
        }
        if (!model.isLoading) {
          _controller.forward();
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            homeUIHeader(context),
            Container(
              height: MediaQuery.of(context).size.height * (33.0 / 740.0),
            ),
            model.isLoading
                ? Center(
                    child: CircularProgressIndicator(
                      strokeWidth: 1.0,
                      valueColor:
                          new AlwaysStoppedAnimation<Color>(Colors.blue),
                    ),
                  )
                : Expanded(
                    key: _backdropKey,
                    flex: 1,
                    child: PageView.builder(
                      controller: _pageController,
                      itemBuilder: (BuildContext context, int index) {
                        return TopicCard(
                          index: index,
                          mainTopic: model.AllTopic[index],
                          currentGame: model.getTaskName(index),
                          level_id: model.AllTopic[index].level.toString(),
                        );
                      },
                      itemCount: model.AllTopic.length,
                    )),
            Container(
              height: MediaQuery.of(context).size.height * (46.0 / 740.0),
            ),
          ],
        );
      },
    );
  }

  Widget _fav_topicCard(Topic topic) {
    return ScopedModelDescendant(
      builder: (BuildContext context, Widget child, MainModel model) {
        Color c = Color.fromRGBO(Random().nextInt(200), Random().nextInt(200),
            Random().nextInt(200), 1);
        int index = model.AllTopic.indexOf(topic);
        return Container(
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: c, width: 2),
              borderRadius: new BorderRadius.all(const Radius.circular(20))),
          child: InkWell(
            onTap: () {
              model.pwloading = true;
              model.wploading = true;
              model.tfloading = true;
              model.ltloading = true;
              model.sfsloading = true;
              model.fbwloading = true;
              model.mixloading = true;
              model.current = 1;
              TopicTaskState t = model.getTopicStatet(topic);
              model.currentState = t;
              String currentGame = model.currentState.currentTask();
              switch (currentGame) {
                case 'Word to Picture':
                  Navigator.pushNamed(context, '/wordpicture');
                  break;
                case 'Picture to Word':
                  Navigator.pushNamed(context, '/pictureword');
                  break;
                case 'True False':
                  Navigator.pushNamed(context, '/truefalse');
                  break;

                case 'Kid\'s Box':
                  Navigator.pushNamed(context, '/kbintro');
                  break;

                case 'Listen to Word':
                  Navigator.pushNamed(context, '/lwtask');
                  break;

                case 'Synonym Antonym Matching':
                  Navigator.pushNamed(context, '/satask');
                  break;

                case 'Sentence Matching':
                  Navigator.pushNamed(context, '/smtask');
                  break;
                case 'Sentence From Story':
                  Navigator.pushNamed(context, '/sfs');
                  break;
                case 'Mix Task':
                  Navigator.pushNamed(context, '/mixtask');
                  break;
                default:
                  print('I am in default');
              }
            },
            child: Container(
              height: 110.0 / 948.0 * MediaQuery.of(context).size.height,
              child: Stack(children: <Widget>[
                Positioned(
                  top: 30,
                  left: 235,
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        model.change_fav_state(index);
                      });
                    },
                    child: Icon(
                      Icons.favorite,
                      size: 30,
                      color: model.AllTopic[index].isLoved == 1
                          ? Colors.redAccent
                          : Color.fromRGBO(171, 172, 197, 1),
                    ),
                  ),
                ),
                Positioned(
                  top: 20,
                  left: 20,
                  child: Text(
                    topic.name,
                    style: TextStyle(color: c, fontSize: 19),
                  ),
                ),
                Positioned(
                  top: 50,
                  left: 20,
                  child: Text(
                    model.task_topic(topic).toString() + ' Tasks',
                    style: TextStyle(color: c, fontSize: 14),
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

  Widget uiFav() {
    return ScopedModelDescendant(
      builder: (BuildContext context, Widget child, MainModel model) {
        return model.isFavLoading || model.isLoading
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
                      !model.changeToBangla ? "Favorites" : 'প্রিয়',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 40),
                    ),
                    top: 75.0 / 948.0 * MediaQuery.of(context).size.height,
                    left: 40.0 / 375.0 * MediaQuery.of(context).size.width,
                  ),
                  Positioned(
                    top: 150.0 / 948.0 * MediaQuery.of(context).size.height,
                    left: 40.0 / 375.0 * MediaQuery.of(context).size.width,
                    child: model.favs.length == 0
                        ? Center(
                            child: Text(!model.changeToBangla
                                ? 'No Favorites'
                                : 'কোনো প্রিয় নেই'),
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
                                  return _fav_topicCard(model.favs[index]);
                                },
                                itemCount: model.favs.length),
                          ),
                  )
                ],
              );
      },
    );
  }
  //ui for profile

  Widget uiArcade() {
    return new ArcadeView();
  }

  Widget _buildChild() {
    switch (_key) {
      case 1:
        return uiHome();
        break;
      case 3:
        return uiFav();
        break;
      case 4:
        return uiArcade();
        break;
      default:
        return uiHome();
    }
  }

  void logout(String token, MainModel model) async {
    await UserController().logout(token);
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant(
      builder: (BuildContext context, Widget child, MainModel model) {
        if (model.gotUser == false) {
          print('I got user');
          User _user = ModalRoute.of(context).settings.arguments;
          model.user = _user;
          model.gotUser = true;
        }
        return Scaffold(
          key: _scaffoldKey,
          drawer: Drawer(
            child: Column(
              children: <Widget>[
                AppBar(
                  automaticallyImplyLeading: false,
                  title: Text(
                      !model.changeToBangla ? 'VashaSikkha' : 'ভাষাশিক্ষা'),
                ),
                ListTile(
                  leading: Icon(CupertinoIcons.group), //icon needs to be fixed
                  title: Text(
                    !model.changeToBangla ? 'Leaderboard' : 'লিডারবোর্ড',
                  ),
                  onTap: () {
                    model.isLBLoading = true;
                    Navigator.pushNamed(context, '/leaderboard');
                  },
                ),
                ListTile(
                  leading: Icon(CupertinoIcons.heart), //icon needs to be fixed
                  title: Text(
                    !model.changeToBangla ? 'Favorites' : 'প্রিয়',
                  ),
                  onTap: () {
                    //model.isLBLoading = true;
                    setState(() {
                      _key = 3;
                    });
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: Icon(
                      CupertinoIcons.game_controller), //icon needs to be fixed
                  title: Text(
                    !model.changeToBangla ? 'Arcade' : 'Arcade',
                  ),
                  onTap: () {
                    //model.isLBLoading = true;
                    setState(() {
                      _key = 4;
                    });
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: Icon(CupertinoIcons.loop), //icon needs to be fixed
                  title: Text(
                    !model.changeToBangla ? 'Logout' : 'বাহির',
                  ),
                  onTap: () {
                    logout(model.user.token, model);

                    Navigator.pop(context);

                    Navigator.pushReplacementNamed(context, '/');
                  },
                ),
                SwitchListTile(
                  value: model.changeToBangla,
                  onChanged: (bool value) {
                    setState(() {
                      model.changeToBangla = value;
                    });
                  },
                  title: Text(!model.changeToBangla
                      ? 'Change to Bangla?'
                      : 'ইংরেজিতে পরিবর্তন করুন'),
                ),
              ],
            ),
          ),
          backgroundColor: Color.fromRGBO(242, 242, 242, 1),
          body: _buildChild(),
          bottomNavigationBar: bottomNavBar(context),
        );
      },
    );
  }
}
