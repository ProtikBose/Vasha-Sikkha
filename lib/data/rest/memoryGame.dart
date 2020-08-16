import 'package:Dimik/config.dart';
import 'package:Dimik/utils/network_util.dart';
import '../../models/memorygame.dart';
import 'dart:async';

class MGRest {
  MGList mGList;
  NetworkUtil _netUtil = new NetworkUtil();

  Future<MGList> getAllQuestions(String token, int topicId) {
    String t1 = "application/x-www-form-urlencoded";
    String t2 = "application/json";
    Map<String, String> headers = new Map<String, String>();

    headers["Content-Type"] = t1;
    headers["Accept"] = t2;
    headers["Authorization"] = token;
    headers["topic_id"] = topicId.toString();

    //headers["user_id"]=userId.toString();
    return _netUtil.get(MG_URL, headers: headers).then((dynamic res) {
      print("DEBUG :=====================\n" +
          res.toString() +
          "\n=====================\n");
      //if(res["message"] == "Unauthenticated!") throw new Exception(res["message"]);

      print("Hello World");

      mGList = new MGList.fromJson(res);
      mGList.setTopicId(topicId);

      //final Map<String, Map<String, dynamic>> tempRes = res;
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

      return mGList;
    });
  }
}
