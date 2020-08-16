import 'package:Dimik/config.dart';
import 'package:Dimik/utils/network_util.dart';
import '../../models/task.dart';
import 'dart:async';
import 'dart:io';
//import 'package:mobile_application/models/token.dart';
//import 'package:mobile_application/models/token.dart';

class TaskRest {
  // static String M_URL= "https://5cf132f13db50700145db61f.mockapi.io/api/auth/";
  //static String T_URL=M_URL+"Topic";

  //List<Topic>topicList = new List();
  TaskList taskList;
  NetworkUtil _netUtil = new NetworkUtil();

  Future<TaskList> getTasks(String token, int topicId) {
    String t1 = "application/x-www-form-urlencoded";
    String t2 = "application/json";
    Map<String, String> headers = new Map<String, String>();
    headers["Content-Type"] = t1;
    headers["Accept"] = t2;
    headers["Authorization"] = token;
    //Map<String,String> body = new Map<String,String>();
    //headers['topic_id'] = topicId.toString();
    //headers["user_id"]=userId.toString();
    //headers["topic_id"]=topicId.toString();
    //headers["task_id"]=taskId.toString();
    print("Mix task url: " + TASK_URL + '/' + topicId.toString());
    return _netUtil
        .get(TASK_URL + '/' + topicId.toString(), headers: headers)
        .then((dynamic res) {
      //sleep(new Duration(seconds: 10));
      print("DEBUG :=====================\n" +
          res.toString() +
          "\n=====================\n");

      //if(res["message"] == "Unauthenticated!") throw new Exception(res["message"]);

      print("Hel Viloetnam");

      taskList = new TaskList.fromJson(res);
      print("mix api:\n" + res.toString());

      //taskList.arrangeElements();
      taskList.setTopicId(topicId);
      return taskList;
    });
  }

  Future<void> postVerdict(int topic_id, int task_id, int specific_task_id,
      int verdict, String token) {
    String t1 = "application/x-www-form-urlencoded";
    String t2 = "application/json";
    Map<String, String> headers = new Map<String, String>();
    headers["Content-Type"] = t1;
    headers["Accept"] = t2;
    headers["Authorization"] = token;
    print("taskID: " +
        task_id.toString() +
        "\nspecificTaskID: " +
        specific_task_id.toString());
    return _netUtil.post(VERDICT, headers: headers, body: {
      "topic_id": topic_id.toString(),
      "task_id": task_id.toString(),
      "specific_task_id": specific_task_id.toString(),
      "verdict": verdict.toString(),
    }).then((dynamic res) {
      print("DEBUG :=====================|||||||\n" +
          res.toString() +
          "\n=====================\n");
      print(res['message']);
      return;
    });
  }
}
