import 'package:Dimik/config.dart';
import 'package:Dimik/utils/network_util.dart';
import '../../models/jumbled_sentence.dart';
import 'dart:async';

//import 'package:mobile_application/models/token.dart';
//import 'package:mobile_application/models/token.dart';

class JumbledRest{

 // static String M_URL= "https://5cf132f13db50700145db61f.mockapi.io/api/auth/";
  //static String T_URL=M_URL+"Topic";
  
  //List<Topic>topicList = new List();
  JumbledList smList ;
  NetworkUtil _netUtil = new NetworkUtil();

  Future <JumbledList> getAllSM(String token,String topicID)
  { 
    
    String t1="application/x-www-form-urlencoded";
    String t2="application/json";
    Map<String,String> headers= new Map<String,String>();
    headers["Content-Type"]=t1;
    headers["Accept"]=t2;
    headers["Authorization"]=token;
    /*
    headers["user_id"]=userId.toString();
    headers["topic_id"]=topicId.toString();
    headers["task_id"]=taskId.toString();
    */
    //headers["topic_name"]=topicName;
    headers["topic_id"]="1";//.toString();
    //print("topicID : "+topicID);
    return _netUtil.get(JUMBLED_URL+"1",headers:headers).then((dynamic res){
      print("DEBUG :=====================\n"+
      res.toString()+"\n=====================\n");
      //if(res["message"] == "Unauthenticated!") throw new Exception(res["message"]);
      
      print("Hello Vietnam");

      smList= new JumbledList.fromJson(res, "1");
      //smList.setTopicId(topicID);


      //final Map<String, Map<String,dynamic> >tempRes=res;
      /*
      res.forEach((String key, Map<String,dynamic>topicData){
        final Topic topic=new Topic.fromJson(topicData);
        topicList.add(topic);
      });
      */
     // List<Topic> temp=topicList.topics;
      //Testing
      /*
      for(int i=0;i<temp.length;i++)
      {
          print(temp[i].name);
          print(temp[i].imageLink);
      }
      */ 
        

      return smList;
    });

  }

  /*
  Future<Token> login(String username, String password) {
    return _netUtil.post(LOGIN_URL, body: {
      "email": username,
      "password": password
    }).then((dynamic res) {
      print("DEBUG :=====================\n"+"kamen Dired Zio"+
      res.toString()+"\n=====================\n");
      if(res["error"] == "Unauthorised") throw new Exception(res["error"]);
      return new Token.map(res["success"]);
    });
  }

  
  Future<Token> register(String email,String username, String password) {
    return _netUtil.post(REG_URL, body: {
      "name": username,
      "email": email,
      "password": password,
      "c_password": password,
    }).then((dynamic res) {
      print("DEBUG :=====================\n"+
      res.toString()+"\n=====================\n");
      if(res["error"] == "Unauthorised") throw new Exception(res["error"]);
      return new Token.map(res["success"]);
    });
  }
  */
}
