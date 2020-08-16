import 'package:Dimik/data/db/fb.dart';
import 'package:Dimik/data/db/mcq.dart';
import 'package:Dimik/data/db/sm.dart';
import 'package:Dimik/data/db/wp.dart';
import 'package:Dimik/data/rest/wordpicture.dart';
import 'package:Dimik/models/wordpicture.dart';
import 'package:flutter/material.dart';

import '../../data/rest_ds.dart';
import '../../models/token.dart';
import '../../data/rest/login.dart';
import '../../data/rest/topic.dart'; // just for testing
import '../../data/rest/sm.dart'; // just for testing
import '../../models/sm.dart';
import '../../data/db/topic.dart';

class WPController {
  WPRest wpRest = new WPRest();
  WPDatabaseHelper wpDatabaseHelper = new WPDatabaseHelper();

  Future<List<WordPicture>> getWPList(String token, int topicId) async {
    //int count = await wpDatabaseHelper.getTopicWPCount(topicId);
    //int count=0;
    WordPictureList wpList;
    if (true) //table is empty
    {
      wpList = await wpRest
          .getAllQuestions(token, topicId)
          .catchError((Object onError) {
        print(onError.toString());
        print("Pour some sugar on me");
      });
      await wpList.downloadImages();
    }
    List<WordPicture> result = wpList.wpList;
    return result;
  }

  Future<void> _insertWPList(WordPictureList wpList) async {
    List<WordPicture> wList = wpList.wpList;

    for (int i = 0; i < wList.length; i++) {
      wpDatabaseHelper.insertWP(wList[i]);
    }
  }

  Future<int> insertWP(WordPicture wp) async {
    return wpDatabaseHelper.insertWP(wp);
  }

  Future<int> updateWP(WordPicture wp) async {
    return wpDatabaseHelper.updateWP(wp);
  }

  Future<int> deleteWP(int id) async {
    return wpDatabaseHelper.deleteWP(id);
  }
}
