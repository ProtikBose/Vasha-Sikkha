import 'package:Dimik/data/db/fb.dart';
import 'package:Dimik/data/db/mcq.dart';
import 'package:flutter/material.dart';

import '../../data/rest_ds.dart';
import '../../models/token.dart';
import '../../data/rest/login.dart';
import '../../data/rest/topic.dart'; // just for testing
import '../../data/rest/fb.dart'; // just for testing
import '../../models/fb.dart';
import '../../data/db/topic.dart';

class FBController {
  FBRest fbRest = new FBRest();
  FBDatabaseHelper fbDatabaseHelper = new FBDatabaseHelper();

  Future<List<FB>> getFBList(String token, int topicId) async {
    int count = await fbDatabaseHelper.getCount();
    if (count == 0) //table is empty
    {
      FBList fbList =
          await fbRest.getAllFB(token, topicId).catchError((Object onError) {
        print(onError.toString());
        print("Pour some sugar on me");
      });
      await _insertFBList(fbList);
    }
    List<FB> result = await fbDatabaseHelper.getFBList(topicId);
    return result;
  }

  Future<void> _insertFBList(FBList fbList) async {
    List<FB> fList = fbList.fbs;

    for (int i = 0; i < fList.length; i++) {
      fbDatabaseHelper.insertFB(fList[i]);
    }
  }

  Future<int> insertFB(FB fb) async {
    return fbDatabaseHelper.insertFB(fb);
  }

  Future<int> updateFB(FB fb) async {
    return fbDatabaseHelper.updateFB(fb);
  }

  Future<int> deleteTopic(int id) async {
    return fbDatabaseHelper.deleteFB(id);
  }
}
