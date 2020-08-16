


import 'package:Dimik/data/db/fb.dart';
import 'package:Dimik/data/db/mcq.dart';
import 'package:Dimik/data/db/sm.dart';
import 'package:flutter/material.dart';

import '../../data/rest_ds.dart';
import '../../models/token.dart';
import '../../data/rest/login.dart';
import '../../data/rest/topic.dart'; // just for testing
import '../../data/rest/sm.dart'; // just for testing
import '../../models/sm.dart';
import '../../data/db/topic.dart';


class SMController{
  SMRest smRest=new SMRest();
  SMDatabaseHelper smDatabaseHelper=new SMDatabaseHelper();
  
  Future<List<SM> >getSMList(String token,int topicId)async{
    int count=await smDatabaseHelper.getCount();
    if(count==0)//table is empty
    {
        SMList smList=await smRest.getAllSM(token,topicId).catchError((Object onError){
          print(onError.toString());
          print("Pour some sugar on me");
        });
        await _insertSMList(smList);
    }
    List<SM>result = await smDatabaseHelper.getSMList(topicId);
    return result;
  }

  Future<void>_insertSMList(SMList smList)async{
    List<SM>sList=smList.sms;
    
    for(int i=0;i<sList.length;i++)
    {
       smDatabaseHelper.insertSM(sList[i]);
    }
  }

  Future<int> insertSM(SM sm)async
  {
      return smDatabaseHelper.insertSM(sm);
  }

  Future<int> updateSM(SM sm)async
  {
      return smDatabaseHelper.updateSM(sm);
  }

  Future<int> deleteSM(int id)async
  {
      return smDatabaseHelper.deleteSM(id);
  }

}

