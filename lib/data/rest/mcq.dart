import 'package:Dimik/config.dart';
import 'package:Dimik/utils/network_util.dart';
import '../../models/mcq.dart';
import 'dart:async';

//import 'package:mobile_application/models/token.dart';
//import 'package:mobile_application/models/token.dart';

class MCQRest{

 // static String M_URL= "https://5cf132f13db50700145db61f.mockapi.io/api/auth/";
  //static String T_URL=M_URL+"Topic";
  
  MCQList mcqList;

  NetworkUtil _netUtil = new NetworkUtil();

  Future<MCQList>getAllMCQ(String token, /*int user_id,*/int topic_id)
  { 

    String t1="application/x-www-form-urlencoded";
    String t2="application/json";
    Map<String,String> headers= new Map<String,String>();
    headers["Content-Type"]=t1;
    headers["Accept"]=t2;
    headers["Authorization"]=token;
    headers["topic_id"]=topic_id.toString();
    //headers["user_id"]=user_id.toString();

    return _netUtil.get(MCQ_URL,headers: headers).then((dynamic res){
      
      //print("DEBUG :=====================\n"+
      //res.toString()+"\n=====================\n");
      //if(res["error"] == "Unauthorised") throw new Exception(res["error"]);
      /*
      List<dynamic>temp=res;
      Map<String, dynamic>temp2=temp[0];
      print(temp.length);
      */
      print("Hello WOrld\n");

      mcqList = new MCQList.fromJson(res); 
      //mcqList.topicId(topic_id);
      print("KekekeR\n");

      //List<MCQ> tempG=mcqList.MCQs;
      //Testing
      /*
      for(int i=0;i<tempG.length;i++)
      {
          print(tempG[i].toString());
      }
      */
      //final Map<String, Map<String,dynamic> >tempRes=res
      /*
      res.forEach((String key, Map<String,dynamic>topicData){
        final Topic topic=new Topic.fromJson(topicData);
        topicList.add(topic);
      });
      */
      return mcqList;
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