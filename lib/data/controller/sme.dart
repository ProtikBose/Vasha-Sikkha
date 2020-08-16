


import 'package:Dimik/data/db/fb.dart';
import 'package:Dimik/data/db/mcq.dart';
import 'package:Dimik/data/db/sme.dart';
import 'package:flutter/material.dart';

import '../../data/rest_ds.dart';
import '../../models/token.dart';
import '../../data/rest/login.dart';
import '../../data/rest/topic.dart'; // just for testing
import '../../data/rest/sme.dart';
import '../../models/sme.dart';
import '../../data/db/topic.dart';


class SMEController{
  SMERest smRest=new SMERest();
  SMEDatabaseHelper smDatabaseHelper=new SMEDatabaseHelper();
  
  Future<List<SME> >getSMList(String token,int topicID)async{
    int count=await smDatabaseHelper.getCount();
    if(count==0)//table is empty
    {
        SMEList smList=await smRest.getAllSM(token,topicID).catchError((Object onError){
          print(onError.toString());
          print("Pour some sugar on me");
        });
        await _insertSMList(smList);
    }
    List<SME>result = await smDatabaseHelper.getSMList();
    return result;
  }

  Future<void>_insertSMList(SMEList smList)async{
    List<SME>sList=smList.sms;
    
    for(int i=0;i<sList.length;i++)
    {
       smDatabaseHelper.insertSM(sList[i]);
    }
  }

  Future<int> insertSM(SME sm)async
  {
      return smDatabaseHelper.insertSM(sm);
  }

  Future<int> updateSM(SME sm)async
  {
      return smDatabaseHelper.updateSM(sm);
  }

  Future<int> deleteSM(int id)async
  //Future<int> deleteSM()async
  {
      return smDatabaseHelper.deleteSM(id);
      //return smDatabaseHelper.deleteSM();
  }

}

