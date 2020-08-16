import 'package:Dimik/data/db/mcq.dart';
import 'package:Dimik/models/topic.dart';
import 'package:flutter/material.dart';

import '../../data/rest_ds.dart';
import '../../models/token.dart';
import '../../data/rest/login.dart';
import '../../data/rest/task.dart'; // just for testing
import '../../data/rest/mcq.dart'; // just for testing
import '../../models/task.dart';
import '../../models/mcq.dart';
//import '../../data/db/topic.dart';

class TaskController {
  TaskRest taskRest = new TaskRest();
  //TopicDatabaseHelper topicDatabaseHelper = new TopicDatabaseHelper();
  TaskList taskList;
  Future<List<Task>> getTaskList(String token, int topicId) async {
    //int count = await topicDatabaseHelper.getCount();

    //if (count == 0) //table is empty
    //{
    print(topicId);
    taskList =
        await taskRest.getTasks(token, topicId).catchError((Object onError) {
      print(onError.toString());
      print("Kamen Rider Grand Zio");
    });
    //await _insertTopicList(topicList);
    List<Task> result = [];
    if (taskList != null) result.addAll(taskList.tasks);
    print('in task controller' + result.length.toString());
    return result;
  }

  Future<void> postVerdict(
      Topic topic, Task task, int verdict, String token) async {
    await taskRest.postVerdict(
        topic.id, task.taskId, task.specificTaskId, verdict, token);
  }

  /*
  Future<void> _insertTopicList(TopicList topicList) async {
    await topicList.downloadImages(); //downloading of images occurring here
    List<Topic> tList = topicList.topics;
    for (int i = 0; i < tList.length; i++) {
      topicDatabaseHelper.insertTopic(tList[i]);
    }
  }

  Future<int> insertTopic(Topic topic) async {
    return topicDatabaseHelper.insertTopic(topic);
  }

  Future<int> updateTopic(Topic topic) async {
    return topicDatabaseHelper.updateTopic(topic);
  }

  Future<int> deleteTopic(int id) async {
    return topicDatabaseHelper.deleteTopic(id);
  }
  */
}
