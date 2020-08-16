

import 'package:Dimik/data/db/mG.dart';
import 'package:Dimik/data/rest/memoryGame.dart';
import 'package:Dimik/models/memorygame.dart';

class MGController{
  
  MGRest mGRest=new MGRest();
  MGDatabaseHelper mGDataBaseHelper=new MGDatabaseHelper();

  Future<List<MG> >getPWList(String token,int topicId)async{
    int count = await mGDataBaseHelper.getTopicPWCount(topicId);
    //int count=0;
    if(count==0)//table is empty
    {
        MGList pwList=await mGRest.getAllQuestions(token,topicId).catchError((Object onError){
          print(onError.toString());
          print("Pour some sugar on me");
        });
        
        await pwList.downloadImages();
        await _insertPWList(pwList);
        
        print('One Piece');
        return pwList.sms;
    }
    List<MG> result = await  mGDataBaseHelper.getMGList(topicId);
    return result;
  }

  Future<void>_insertPWList(MGList pwList)async{
    List<MG>pList=pwList.sms;
    
    for(int i=0;i<pList.length;i++)
    {
        mGDataBaseHelper.insertPW(pList[i]);
    }
  }

  Future<int> insertPW(MG pw)async
  {
      return  mGDataBaseHelper.insertPW(pw);
  }

  Future<int> updatePW(MG pw)async
  {
      return  mGDataBaseHelper.updatePW(pw);
  }

  Future<int> deletePW(int id)async
  {
      return  mGDataBaseHelper.deletePW(id);
  }

}