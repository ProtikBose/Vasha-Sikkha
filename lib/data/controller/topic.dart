import 'package:Dimik/data/db/mcq.dart';
import 'package:flutter/material.dart';

import '../../data/rest_ds.dart';
import '../../models/token.dart';
import '../../data/rest/login.dart';
import '../../data/rest/topic.dart'; // just for testing
import '../../data/rest/mcq.dart'; // just for testing
import '../../models/topic.dart';
import '../../models/mcq.dart';
import '../../data/db/topic.dart';

class TopicController {
  TopicRest topicRest = new TopicRest();
  //TopicDatabaseHelper topicDatabaseHelper = new TopicDatabaseHelper();
  TopicList topicList;
  Future<List<Topic>> getTopicList(String token) async {
    //int count = await topicDatabaseHelper.getCount();

    if (true) //count == 0) //table is empty
    {
      topicList =
          await topicRest.getAllTopics(token).catchError((Object onError) {
        print(onError.toString());
        print("Pour some sugar on me");
      });
      await _insertTopicList(topicList);
    }
    List<Topic> result =
        topicList.topics; //await topicDatabaseHelper.getTopicList();
    return result;
  }

  Future<double> getPercentage(int topic_id, String token) async {
    double percentage = await topicRest.getPercentage(topic_id, token);
    return percentage;
  }

  Future<int> getLevel(int topic_id, String token) async {
    int level = await topicRest.getLevel(topic_id, token);
    return level;
  }

  Future<List<Topic>> getFavouriteTopics(String token) async {
    topicList =
        await topicRest.getFavTopics(token).catchError((Object onError) {
      print(onError.toString());
      print("Four Scores and Seven Years Ago");
    });
    //  await _insertTopicList(topicList);
    await topicList.downloadImages();
    List<Topic> result = topicList.topics;
    return result;
  }

  Future<void> _insertTopicList(TopicList topicList) async {
    await topicList.downloadImages(); //downloading of images occurring here
    //List<Topic> tList = topicList.topics;
    /*
    for (int i = 0; i < tList.length; i++) {
      topicDatabaseHelper.insertTopic(tList[i]);
    }*/
  }
  /*
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

  Future<void> postFavTopic(Topic topic, int is_loved, String token) async {
    await topicRest.postFavTopic(topic, is_loved, token);
    return;
  }
}
