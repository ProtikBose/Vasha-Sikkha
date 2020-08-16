import 'dart:async';
import 'dart:io' as io;

import 'package:Dimik/models/pictureword.dart';
import 'package:Dimik/models/wordpicture.dart';
import 'package:path/path.dart';
import '../../models/mcq.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

import './main.dart';

class PWDatabaseHelper{

  static final PWDatabaseHelper _instance = new PWDatabaseHelper.internal();
  factory PWDatabaseHelper() => _instance;
  final MainDatabaseHelper _databaseHelper= new MainDatabaseHelper();

  PWDatabaseHelper.internal();

  String tableName='PW';
  String idCol='Id';
  String imageCol='Image';
  String optionCol='Options';
  String answerCol='Answer';
  String explanationCol='Explanation';
  String topicIdCol='Topic_Id';
  

  Future<List<PictureWord> > getPWList(int topicId) async {
    Database dbClient = await _databaseHelper.db;

    List<Map<String,dynamic> > result = await dbClient.query(tableName,where:'$topicIdCol = ?',whereArgs: [topicId]);
    List<PictureWord> pwList= new List<PictureWord>();
    for(int i=0;i<result.length;i++)
    {
      PictureWord pw=new PictureWord.fromMapObject(result[i]);
      pwList.add(pw);
    }
   // var result = await db.query(noteTable, orderBy: '$colPriority ASC');
    //return result;
    return pwList;
  }

  // Insert Operation: Insert a Topic object to database
  Future<int> insertPW(PictureWord pw) async {
    var dbClient = await _databaseHelper.db;
    var result = await dbClient.insert(tableName, pw.toMap());
    return result;
  }

  // Update Operation: Update a Topic object and save it to database
  Future<int> updatePW(PictureWord pw) async {
    var dbClient = await _databaseHelper.db;
    var result = await dbClient.update(tableName, pw.toMap(), where: '$idCol = ?', whereArgs: [pw.id]);
    return result;
  }

  // Delete Operation: Delete a Topic object from database
  Future<int> deletePW(int entryId) async {
    var dbClient = await _databaseHelper.db;
    //int result = await dbClient.rawDelete('DELETE FROM $tableName WHERE $idCol = $entryId');
    int result = await dbClient.delete(tableName, where:'$idCol = ?', whereArgs: [entryId]);
    return result;
  }


  Future<int> getCount() async {
    var dbClient = await _databaseHelper.db;
    List<Map<String, dynamic>> x = await dbClient.rawQuery('SELECT COUNT (*) from $tableName');
    int result = Sqflite.firstIntValue(x);
    return result;
  }

  Future<int> getTopicPWCount(int topicId) async {
    var dbClient = await _databaseHelper.db;
    //List<Map<String,dynamic>> x= await dbClient.query(tableName,where: '$idCol = ?', whereArgs: [topicId]);
    List<Map<String, dynamic>> x = await dbClient.rawQuery('SELECT COUNT (*) from $tableName WHERE $topicIdCol= $topicId');
    int result =Sqflite.firstIntValue(x);
    return result;
  }

}