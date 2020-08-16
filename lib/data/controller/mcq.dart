import 'package:Dimik/data/db/mcq.dart';
import 'package:flutter/material.dart';

import '../../data/rest_ds.dart';
import '../../models/token.dart';
import '../../data/rest/login.dart';
import '../../data/rest/topic.dart'; // just for testing
import '../../data/rest/mcq.dart'; // just for testing
import '../../models/mcq.dart';
import '../../data/db/topic.dart';

class MCQController {
  MCQRest mcqRest = new MCQRest();
  MCQDatabaseHelper mcqDatabaseHelper = new MCQDatabaseHelper();

  Future<List<MCQ>> getMCQList(
      String token /*,int user_id*/, int topic_id) async {
    int count = await mcqDatabaseHelper.getCount();
    if (count == 0) //table is empty
    {
      MCQList mcqList = await mcqRest
          .getAllMCQ(token /*,user_id*/, topic_id)
          .catchError((Object onError) {
        print(onError.toString());
        print("Pour some sugar on me");
      });
      await _insertMCQList(mcqList);
    }
    List<MCQ> result = await mcqDatabaseHelper.getMCQList(topic_id);
    return result;
  }

  Future<void> _insertMCQList(MCQList mcqList) async {
    List<MCQ> mList = mcqList.mcqs;

    for (int i = 0; i < mList.length; i++) {
      mcqDatabaseHelper.insertMCQ(mList[i]);
    }
  }

  Future<int> insertMCQ(MCQ mcq) async {
    return mcqDatabaseHelper.insertMCQ(mcq);
  }

  Future<int> updateTopic(MCQ mcq) async {
    return mcqDatabaseHelper.updateMCQ(mcq);
  }

  Future<int> deleteTopic(int id) async {
    return mcqDatabaseHelper.deleteMCQ(id);
  }
  // Future<int> deleteTopic()async
  // {
  //     return mcqDatabaseHelper.deleteMCQ();
  // }

}
