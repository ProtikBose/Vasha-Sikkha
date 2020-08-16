import 'dart:async';
import 'dart:io' as io;

import 'package:path/path.dart';
import '../../models/fb.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

import './main.dart';

class FBDatabaseHelper{

  static final FBDatabaseHelper _instance = new FBDatabaseHelper.internal();
  factory FBDatabaseHelper() => _instance;
  final MainDatabaseHelper _databaseHelper= new MainDatabaseHelper();

  FBDatabaseHelper.internal();

  String tableName='FB';
  String idCol='Id';
  String questionCol='Question';
  String optionCol='Options';
  String answerCol='Answers';
  String explanationCol='Explanation';
  String topicIdCol='Topic_Id';
  

  Future<List<FB> > getFBList(int topicId) async {
    Database dbClient = await _databaseHelper.db;

    List<Map<String,dynamic> > result = await dbClient.query(tableName,where:'$topicIdCol = ?',whereArgs: [topicId]);
    List<FB> fList= new List<FB>();
    for(int i=0;i<result.length;i++)
    {
      FB fb=new FB.fromMapObject(result[i]);
      fList.add(fb);
    }
   // var result = await db.query(noteTable, orderBy: '$colPriority ASC');
    //return result;
    return fList;
  }

  // Insert Operation: Insert a Topic object to database
  Future<int> insertFB(FB fb) async {
    var dbClient = await _databaseHelper.db;
    var result = await dbClient.insert(tableName, fb.toMap());
    return result;
  }

  // Update Operation: Update a Topic object and save it to database
  Future<int> updateFB(FB fb) async {
    var dbClient = await _databaseHelper.db;
    var result = await dbClient.update(tableName, fb.toMap(), where: '$idCol = ?', whereArgs: [fb.id]);
    return result;
  }

  // Delete Operation: Delete a Topic object from database
  Future<int> deleteFB(int entryId) async {
    var dbClient = await _databaseHelper.db;
    int result = await dbClient.rawDelete('DELETE FROM $tableName WHERE $idCol = $entryId');
    return result;
  }


  Future<int> getCount() async {
    var dbClient = await _databaseHelper.db;
    List<Map<String, dynamic>> x = await dbClient.rawQuery('SELECT COUNT (*) from $tableName');
    int result = Sqflite.firstIntValue(x);
    return result;
  }

}