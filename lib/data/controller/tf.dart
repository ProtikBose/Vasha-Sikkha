import 'package:Dimik/data/db/fb.dart';
import 'package:Dimik/data/db/mcq.dart';
import 'package:Dimik/data/db/tf.dart';
import 'package:flutter/material.dart';

import '../../data/rest_ds.dart';
import '../../models/token.dart';
import '../../data/rest/login.dart';
import '../../data/rest/topic.dart'; // just for testing
import '../../data/rest/tf.dart'; // just for testing
import '../../models/tf.dart';
import '../../data/db/topic.dart';

class TFController {
  TFRest tfRest = new TFRest();
  TFDatabaseHelper tfDatabaseHelper = new TFDatabaseHelper();

  Future<List<TF>> getTFList(String token, int topicId) async {
    //int count = await tfDatabaseHelper.getCount();
    //int count = 0;
    //int count = await tfDatabaseHelper.getTopicTFCount(topicId);
    TFList tfList;
    if (true) //no tf related to topic
    {
      tfList =
          await tfRest.getAllTF(token, topicId).catchError((Object onError) {
        print(onError.toString());
        print("Pour some sugar on me");
      });
    }
    List<TF> result = tfList.tfs;
    return result;
  }

  Future<void> _insertTFList(TFList tfList) async {
    List<TF> tList = tfList.tfs;

    for (int i = 0; i < tList.length; i++) {
      tfDatabaseHelper.insertTF(tList[i]);
    }
  }

  Future<int> insertTF(TF tf) async {
    return tfDatabaseHelper.insertTF(tf);
  }

  Future<int> updateTF(TF tf) async {
    return tfDatabaseHelper.updateTF(tf);
  }

  Future<int> deleteTF(int id) async {
    return tfDatabaseHelper.deleteTF(id);
  }
}
