import 'package:Dimik/ScopedModel/mainmodel.dart';
import 'package:Dimik/data/controller/fb.dart';
import 'package:Dimik/data/controller/mcq.dart';
import 'package:Dimik/data/controller/pictureword.dart';
import 'package:Dimik/data/controller/sm.dart';
import 'package:Dimik/data/controller/task.dart';
import 'package:Dimik/data/controller/task.dart';
import 'package:Dimik/data/controller/tf.dart';
import 'package:Dimik/data/controller/user.dart';
import 'package:Dimik/data/controller/wordpicture.dart';
import 'package:Dimik/data/db/mcq.dart';
import 'package:Dimik/data/rest/task.dart';
import 'package:Dimik/models/fb.dart';
import 'package:Dimik/models/pictureword.dart';
import 'package:Dimik/models/sm.dart';
import 'package:Dimik/models/wordpicture.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:Dimik/utils/connectivity.dart';
import '../../data/rest_ds.dart';
import '../../models/token.dart';
import '../../models/tf.dart';
import '../../models/listening_item.dart';
import '../../data/rest/login.dart';
import '../../data/rest/topic.dart'; // just for testing
import '../../data/rest/mcq.dart'; // just for testing
import '../../models/topic.dart';
import '../../models/mcq.dart';
import '../../data/db/topic.dart';
import '../../models/user.dart';
import '../../models/task.dart';
import '../../data/db/user.dart';
import '../../data/controller/topic.dart';
import '../../data/controller/lw.dart';
import '../../data/rest/lw.dart';

abstract class LoginScreenContract {
  void onLoginSuccess(String token);
  void onLoginError(String errorTxt);
}

class LoginScreenPresenter {
  LoginScreenContract _view;
  LoginRest api = new LoginRest();
  TopicRest api2 = new TopicRest(); //This is just for testing
  MCQRest api3 = new MCQRest();
  LWRest lwrest = new LWRest();
  LoginScreenPresenter(this._view);
  TopicDatabaseHelper tHelper = new TopicDatabaseHelper();
  MCQDatabaseHelper mHelper = new MCQDatabaseHelper();
  UserDatabaseHelper uHelper = new UserDatabaseHelper();
  TopicController tController = new TopicController();
  UserController uController = new UserController();
  MCQController mController = new MCQController();
  //FBRest fbRest= new FBRest();
  TaskRest taskRest = new TaskRest();
  TaskController taskController = new TaskController();
  FBController fController = new FBController();
  TFController tfController = new TFController();
  SMController smController = new SMController();
  PWController pwController = new PWController();
  WPController wpController = new WPController();
  LWController lwController = new LWController();
  ConnectionChecker connChecker = new ConnectionChecker();
  doLogin(String username, String password, MainModel model) async {
    /*
    FBList fbList= await fbRest.getAllQuestions().catchError((Object onError){
      print(onError.toString());
      print("Tell me why?");
    });
    List<FB>f=fbList.fbs;
    */
    //for(int i=0;i<f.length;i++)
    //print(f[i].toString());

    /* 
    MCQList list=await api3.getAllMCQ().catchError((Object error){
      print(error.toString());
      print("I want it that way");
      return null;
    });
    
    

    List<MCQ>tList=list.mcqs;

    List<MCQ> tList = list.MCQs;

    for (int i = 0; i < tList.length; i++) {
      int q = await m_Helper.insertMCQ(tList[i]);
      print(q);
    }

    int count = await helper.getCount();
    print(count);

    dynamic m_list = await m_Helper.getMCQList();
    //for(int i=0;i<tName.length;i++)
    //print(tName[i]);

    for (int i = 0; i < list.mcqs.length; i++) {
      debugPrint(list.mcqs[i].printOptions());
    }
    */

    //Token token=await api.login(username, password).catchError((Object error) => _view.onLoginError(error.toString()));

    /*
    User user=await api.getUserDetails(token).catchError((Object error){
      print(error.toString());
      print("Hello Hello");
    });
    */

    /*
    int m=await uHelper.insertUser(user);
    print("gehehe");
    List<User>uList=await uHelper.getUserList();
    */
    /*
    List<PictureWord>pList = await pwController.getPWList();

    for(int i=0;i<pList.length;i++)
      print(pList[i].toString());    
    */
    /*
    List<WordPicture>wList = await wpController.getWPList();

    for(int i=0;i<wList.length;i++)
      print(wList[i].toString());
    */
    //bool b= await connChecker.checkConnection();
    //print("Connection "+b.toString());
    User user;
    user = await uController
        .login(username, password, model)
        .catchError((Object onError) {
      print(onError.toString());

      //throw new Exception("Invalid Username or Password");
    });
    User new_user;
    if (user == null) {
      new_user = null;
    } else {
      new_user = await uController.getUser(user.token);
      new_user.token = user.token;
    }

    //List<Topic>favList= await tController.getFavouriteTopics(user.token);

    //List<ListeningItem>l=await lwController.getLWList(user.token, 1);

    /*
    List<PictureWord>pList = await pwController.getPWList(user.token,1);

    for(int i=0;i<pList.length;i++)
      print(pList[i].toString()); 
    */
    /*
    List<WordPicture>wList = await wpController.getWPList(user.token,1);

    for(int i=0;i<wList.length;i++)
      print(wList[i].toString());
    */
    /*
    String t="Bearer "+user.token;
    
    List<Topic>topicList= await tController.getTopicList(t);
    for(int i=0;i<topicList.length;i++)
      topicList[i].printData();
    
    List<FB>fbList=await fController.getFBList(t, 1);
    for(int i=0;i<fbList.length;i++)
      fbList[i].toString();
    
    List<SM>smList=await smController.getSMList(t, 1);
    for(int i=0;i<smList.length;i++)
      smList[i].toString();

    List<TF>tfList= await tfController.getTFList(t, 1);
    for(int i=0;i<tfList.length;i++)
      print(tfList[i].toString());
    */
    //String t="Bearer "+user.token;
    /*
    List<FB>fbList= await fController.getFBList(t, user.id, 1, 1);
    for(int i=0;i<fbList.length;i++)
      print(fbList[i].toString());
    */
    /* 
    List<MCQ> mcqList=await mController.getMCQList(t, user.id,1);
    for(int i=0;i<mcqList.length;i++)
      print(mcqList[i].toString());
    */
    //user.token = "Bearer " + user.token;

    return new_user;

    /*
    MCQList mcqList=await api3.getAllMCQ(t, user.id, 1).catchError((Object error){
      print(error.toString());
      print("Halarput");
    });
   
   for(int i=0;i<mcqList.mcqs.length;i++)
    print(mcqList.mcqs[i].toString());
  
    List<MCQ>mList=mcqList.mcqs;
    for(int i=0;i<mList.length;i++)
      await mHelper.insertMCQ(mList[i]);

    List<MCQ>hoho=await mHelper.getMCQList();
    for(int i=0;i<hoho.length;i++)
      print(hoho[i].toString());
    */

    /*
    List<Topic>topicList=await tController.getTopicList(t);
    for(int i=0;i<topicList.length;i++)
    {
      print(topicList[i].name+" "+topicList[i].imageLink);  
    }
   
   */
  }

  doRegister(String email, String username, String password) {
    api.register(email, username, password, password).then((String token) {
      _view.onLoginSuccess(token);
    }).catchError((Object error) => _view.onLoginError(error.toString()));
  }
}
