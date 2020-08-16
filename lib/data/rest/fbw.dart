import 'package:Dimik/config.dart';
import 'package:Dimik/models/fb_word.dart';
import 'package:Dimik/utils/network_util.dart';

class FBWRest {
  // static String M_URL= "https://5cf132f13db50700145db61f.mockapi.io/api/auth/";
  //static String T_URL=M_URL+"Topic";

  //List<Topic>topicList = new List();
  FBWList fbwList;
  NetworkUtil _netUtil = new NetworkUtil();

  Future<FBWList> getAllFB(String token, int topicId) {
    String t2 = "application/json";
    Map<String, String> headers = new Map<String, String>();
    headers["Accept"] = t2;
    headers["Authorization"] = token;

    //headers["user_id"]=userId.toString();
    //headers["task_id"]=taskId.toString();
    return _netUtil
        .get(FBW_URL + topicId.toString(), headers: headers)
        .then((dynamic res) {
      print("DEBUG :=====================\n" +
          res.toString() +
          "\n=====================\n");
      //if(res["message"] == "Unauthenticated!") throw new Exception(res["message"]);

      print("Hello Vietnam");

      fbwList = new FBWList.fromJson(res);
      fbwList.setTopicId(topicId);
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

      return fbwList;
    });
  }
}
