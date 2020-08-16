import 'dart:async';
import 'dart:io' as io;

import 'package:path/path.dart';
import '../../models/mcq.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

import './main.dart';

class MCQDatabaseHelper{

  static final MCQDatabaseHelper _instance = new MCQDatabaseHelper.internal();
  factory MCQDatabaseHelper() => _instance;
  final MainDatabaseHelper _databaseHelper= new MainDatabaseHelper();

  MCQDatabaseHelper.internal();

  String tableName='MCQ';
  String idCol='Id';
  String questionCol='Question';
  String optionCol='Options';
  String answerCol='Answer';
  String explanationCol='Explanation';
  String topicIdCol='Topic_Id';

  

  Future<List<MCQ> > getMCQList(int topicId) async {
    Database dbClient = await _databaseHelper.db;

    List<Map<String,dynamic> > result = await dbClient.query(tableName,where:'$topicIdCol = ?',whereArgs: [topicId]);
    List<MCQ> mList= new List<MCQ>();
    for(int i=0;i<result.length;i++)
    {
      MCQ mcq=new MCQ.fromMapObject(result[i]);
      mList.add(mcq);
    }
   // var result = await db.query(noteTable, orderBy: '$colPriority ASC');
    //return result;
    return mList;
  }

  // Insert Operation: Insert a Topic object to database
  Future<int> insertMCQ(MCQ mcq) async {
    var dbClient = await _databaseHelper.db;
    var result = await dbClient.insert(tableName, mcq.toMap());
    return result;
  }

  // Update Operation: Update a Topic object and save it to database
  Future<int> updateMCQ(MCQ mcq) async {
    var dbClient = await _databaseHelper.db;
    var result = await dbClient.update(tableName, mcq.toMap(), where: '$idCol = ?', whereArgs: [mcq.id]);
    return result;
  }

  // Delete Operation: Delete a Topic object from database
  Future<int> deleteMCQ(int entryId) async {
    var dbClient = await _databaseHelper.db;
    int result = await dbClient.rawDelete('DELETE FROM $tableName WHERE $idCol = $entryId');
    return result;
  }
  //  Future<int> deleteMCQ() async {
  //   var dbClient = await _databaseHelper.db;
  //   int result = await dbClient.delete(tableName);
  //   return result;
  // }

  Future<int> getCount() async {
    var dbClient = await _databaseHelper.db;
    List<Map<String, dynamic>> x = await dbClient.rawQuery('SELECT COUNT (*) from $tableName');
    int result = Sqflite.firstIntValue(x);
    return result;
  }

}