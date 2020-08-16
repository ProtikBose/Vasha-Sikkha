import 'package:Dimik/config.dart';
import 'package:Dimik/utils/network_util.dart';
import '../../models/score_update.dart';
import 'dart:async';

//import 'package:mobile_application/models/token.dart';
//import 'package:mobile_application/models/token.dart';

class ScoreUpdateRest{

  ScoreUpdate update ;
  NetworkUtil _netUtil = new NetworkUtil();

  Future <String> postScoreUpdate(String token,ScoreUpdate update)
  { 
    
    String t1="application/x-www-form-urlencoded";
    String t2="application/json";
    Map<String,String> headers= new Map<String,String>();
    headers["Content-Type"]=t1;
    headers["Accept"]=t2;
    headers["Authorization"] = token;

    return _netUtil.post(SCORE_UPDATE_URL,headers:headers,
     body: {
      "topic_id": update.topicID.toString(),
      "task_id": update.taskID.toString(),
      "specific_task_id": update.specificTaskID.toString(),
      "verdict": update.verdict.toString()

    }).then((dynamic res) {
      print("DEBUG :=====================\n"+
      res.toString()+"\n=====================\n");
      //if(res["message"] == "Unauthorised") throw new Exception(res["message"]);
      //print("Hello Man");
      return res.toString();
    });

  }


}
