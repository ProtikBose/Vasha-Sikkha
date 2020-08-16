


import 'package:Dimik/data/db/fb.dart';
import 'package:Dimik/data/db/mcq.dart';
import 'package:Dimik/data/db/sm.dart';
import 'package:flutter/material.dart';

import '../../data/rest_ds.dart';
import '../../models/token.dart';
import '../../data/rest/login.dart';
import '../../data/rest/topic.dart'; // just for testing
import '../../data/rest/jumbled_sentence.dart'; // just for testing
import '../../models/jumbled_sentence.dart';
import '../../data/db/jumbled_sentence.dart';


class JumbledController{
  JumbledRest jmRest=new JumbledRest();
  JumbledDatabaseHelper jmDatabaseHelper=new JumbledDatabaseHelper();
  
  Future<List<Jumbled> >getSMList(String token,int topicID)async{
    int count=await jmDatabaseHelper.getCount();
    if(count==0)//table is empty
    {
        JumbledList jmList=await jmRest.getAllSM(token,topicID.toString()).catchError((Object onError){
          print(onError.toString());
          print("Pour some sugar on me");
        });
        print("jmList: ");
        print(jmList);
        await _insertSMList(jmList);
    }
    List<Jumbled>result = await jmDatabaseHelper.getSMList(topicID.toString());
    print("In controller");
    print(result);
    return result;
  }

  Future<void>_insertSMList(JumbledList jmList)async{
    List<Jumbled>jList=jmList.sms;
    
    for(int i=0;i<jList.length;i++)
    {
       jmDatabaseHelper.insertSM(jList[i]);
    }
  }

  Future<int> insertSM(Jumbled sm)async
  {
      return jmDatabaseHelper.insertSM(sm);
  }

  Future<int> updateSM(Jumbled jm)async
  {
      return jmDatabaseHelper.updateSM(jm);
  }

  Future<int> deleteSM(int id)async
  //Future<int> deleteSM()async
  {
      return jmDatabaseHelper.deleteSM(id);
      //return smDatabaseHelper.deleteSM();
  }

}

