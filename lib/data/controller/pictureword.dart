import 'package:Dimik/data/db/fb.dart';
import 'package:Dimik/data/db/mcq.dart';
import 'package:Dimik/data/db/pw.dart';
import 'package:Dimik/data/db/sm.dart';
import 'package:Dimik/data/rest/pictureword.dart';
import 'package:Dimik/models/pictureword.dart';
import 'package:flutter/material.dart';

import '../../data/rest_ds.dart';
import '../../models/token.dart';
import '../../data/rest/login.dart';
import '../../data/rest/topic.dart'; // just for testing
import '../../data/rest/sm.dart'; // just for testing
import '../../models/sm.dart';
import '../../data/db/topic.dart';

class PWController {
  PWRest pwRest = new PWRest();
  PWDatabaseHelper pwDatabaseHelper = new PWDatabaseHelper();

  Future<List<PictureWord>> getPWList(String token, int topicId) async {
    //int count = await pwDatabaseHelper.getTopicPWCount(topicId);
    //int count=0;
    PictureWordList pwList;
    if (true) //table is empty
    {
      pwList = await pwRest
          .getAllQuestions(token, topicId)
          .catchError((Object onError) {
        print(onError.toString());
        print("Pour some sugar on me");
      });

      await pwList.downloadImages();
    }
    List<PictureWord> result = pwList.pwList;
    return result;
  }

  Future<void> _insertPWList(PictureWordList pwList) async {
    List<PictureWord> pList = pwList.pwList;

    for (int i = 0; i < pList.length; i++) {
      pwDatabaseHelper.insertPW(pList[i]);
    }
  }

  Future<int> insertPW(PictureWord pw) async {
    return pwDatabaseHelper.insertPW(pw);
  }

  Future<int> updatePW(PictureWord pw) async {
    return pwDatabaseHelper.updatePW(pw);
  }

  Future<int> deletePW(int id) async {
    return pwDatabaseHelper.deletePW(id);
  }
}
