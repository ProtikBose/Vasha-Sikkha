import 'package:Dimik/ScopedModel/mainmodel.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:toast/toast.dart';

import 'login_controller.dart';
import 'package:flutter/material.dart';
import 'package:Dimik/models/user.dart';

class LogInPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LogInState();
  }
}

class _LogInState extends State<LogInPage> implements LoginScreenContract {
  bool _isLoading = false;
  User _user;
  int state = 1;
  String username, password, confirm_pass, email;
  LoginScreenPresenter _presenter;
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    _presenter = new LoginScreenPresenter(this);
    super.initState();
  }

  login(MainModel model) async {
    print("Greyfiay");
    await _presenter
        .doLogin(username, password, model)
        .then((onValue) => {_user = onValue});

    if (model.successfulLogin == false) {
      _scaffoldKey.currentState.showSnackBar(new SnackBar(
        content: new Text("Creation of user failed"),
        duration: Duration(milliseconds: 500),
      ));
    }
    if (_user != null) {
      onLoginSuccess(_user.token);
    } else
      onLoginError('errorTxt');
  }

  register() async {
    if (password == confirm_pass) {
      print("Greyfiay");
      await _presenter
          .doRegister(email, username, password)
          .then((onValue) => {_user = onValue});

      if (_user != null) {
        onLoginSuccess(_user.token);
      }
    } else
      onLoginError('errorTxt');
  }

  Widget logInView() {
    return ScopedModelDescendant(
        builder: (BuildContext context, Widget child, MainModel model) {
      model.logOut();
      return Container(
        color: Color.fromRGBO(247, 248, 248, 1),
        child: Column(
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height * (616.0 / 740.0),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: new BorderRadius.only(
                    bottomLeft: const Radius.circular(40)),
              ),
              child: Container(
                margin: EdgeInsets.fromLTRB(40, 48, 0, 30),
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Vasha',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w100),
                          ),
                          Text('Sikkha',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w100))
                        ],
                      ),
                    ),
                    Positioned(
                      top: 2.0 / 360.0 * MediaQuery.of(context).size.width,
                      left: 190.0 / 360.0 * MediaQuery.of(context).size.width,
                      child: InkWell(
                        child: Text(
                          'Sign in',
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: state == 1
                                  ? FontWeight.w900
                                  : FontWeight.w100,
                              color: state == 1 ? Colors.black : Colors.grey),
                        ),
                        onTap: () {
                          setState(() {
                            state = 1;
                          });
                        },
                      ),
                    ),
                    Positioned(
                      top: 2.0 / 360.0 * MediaQuery.of(context).size.width,
                      left: 240.0 / 360.0 * MediaQuery.of(context).size.width,
                      child: InkWell(
                        child: Text(
                          'Sign up',
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: state == 2
                                  ? FontWeight.w900
                                  : FontWeight.w100,
                              color: state == 2 ? Colors.black : Colors.grey),
                        ),
                        onTap: () {
                          setState(() {
                            state = 2;
                          });
                        },
                      ),
                    ),
                    Positioned(
                      top: 150.0 / 740.0 * MediaQuery.of(context).size.height,
                      child: Text(
                        'Hello genius',
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.w500),
                      ),
                    ),
                    Positioned(
                      top: 196.0 / 740.0 * MediaQuery.of(context).size.height,
                      child: Text(
                          'Enter your informations below or login with a \nsocial account',
                          style: TextStyle(
                              fontSize: 13, fontWeight: FontWeight.w500)),
                    ),
                    Positioned(
                      top: 290,
                      child: Container(
                        height: 100,
                        width: 280,
                        child: TextField(
                          onChanged: (String value) {
                            username = value;
                          },
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            labelText: state == 1 ? 'Email' : 'Username',
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 350,
                      child: Container(
                        height: 100,
                        width: 280,
                        child: TextField(
                          onChanged: (String value) {
                            if (state == 2)
                              email = value;
                            else
                              password = value;
                          },
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              labelText: state == 2 ? 'Email' : 'Password'),
                          obscureText: state == 2 ? false : true,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 410,
                      child: state == 2
                          ? Container(
                              height: 100,
                              width: 280,
                              child: TextField(
                                onChanged: (String value) {
                                  password = value;
                                },
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    labelText: 'Password'),
                                obscureText: true,
                              ),
                            )
                          : Container(),
                    ),
                    Positioned(
                      top: 470,
                      child: state == 2
                          ? Container(
                              height: 100,
                              width: 280,
                              child: TextField(
                                onChanged: (String value) {
                                  confirm_pass = value;
                                },
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    labelText: 'Confirm Password'),
                                obscureText: true,
                              ),
                            )
                          : Container(),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * (29.0 / 740.0),
            ),
            Container(
              height: 60,
              width: 280,
              decoration: BoxDecoration(
                color: Color.fromRGBO(133, 119, 226, 1),
                borderRadius: new BorderRadius.all(const Radius.circular(30)),
              ),
              child: FlatButton(
                onPressed: () {
                  setState(() {
                    if (state == 1) {
                      _isLoading = true;
                      login(model);
                    } else {
                      _isLoading = true;
                      register();
                      state == 1;
                    }
                  });
                },
                child: Text(
                  state == 1 ? 'Sign In' : 'Signup now',
                  style: TextStyle(color: Colors.white, fontSize: 15),
                ),
              ),
            )
          ],
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: SingleChildScrollView(
          child: _isLoading
              ? Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: Center(
                    child: CircularProgressIndicator(
                      backgroundColor: Colors.white,
                      strokeWidth: 1.5,
                    ),
                  ),
                )
              : logInView()),
    );
  }

  @override
  void onLoginError(String errorTxt) {
    setState(() {
      _isLoading = false;
    });
    if (state == 1) {
      _scaffoldKey.currentState.showSnackBar(new SnackBar(
        content: new Text("Invalid Credentials"),
        duration: Duration(milliseconds: 500),
      ));
    } else {
      //alert er dialog
      _scaffoldKey.currentState.showSnackBar(new SnackBar(
        content: new Text("Creation of user failed"),
        duration: Duration(milliseconds: 500),
      ));
    }
  }

  @override
  void onLoginSuccess(String token) {
    if (state == 1) {
      setState(() {
        //_isLoading = false;
        Navigator.pushReplacementNamed(context, '/home', arguments: _user);
      });
    } else {
      setState(() {
        _isLoading = false;
        state = 1;
      });

      _scaffoldKey.currentState.showSnackBar(new SnackBar(
        content: new Text("Successfully created user"),
        duration: Duration(milliseconds: 500),
      ));
    }
  }
}
