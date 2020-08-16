import 'dart:async';
import 'dart:io' as io;

import 'package:Dimik/models/wordpicture.dart';
import 'package:path/path.dart';
import '../../models/mcq.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

import './main.dart';

class WPDatabaseHelper{

  static final WPDatabaseHelper _instance = new WPDatabaseHelper.internal();
  factory WPDatabaseHelper() => _instance;
  final MainDatabaseHelper _databaseHelper= new MainDatabaseHelper();

  WPDatabaseHelper.internal();

  String tableName='WP';
  String idCol='Id';
  String wordCol='Word';
  String optionCol='Image_Options';
  String answerCol='Image_Answer';
  String explanationCol='Explanation';
  String topicIdCol='Topic_Id';
  

  Future<List<WordPicture> > getWPList(int topicId) async {
    Database dbClient = await _databaseHelper.db;

    List<Map<String,dynamic> > result = await dbClient.query(tableName,where:'$topicIdCol = ?',whereArgs: [topicId]);
    List<WordPicture> wpList= new List<WordPicture>();
    for(int i=0;i<result.length;i++)
    {
      WordPicture wp=new WordPicture.fromMapObject(result[i]);
      wpList.add(wp);
    }
   // var result = await db.query(noteTable, orderBy: '$colPriority ASC');
    //return result;
    return wpList;
  }

  // Insert Operation: Insert a Topic object to database
  Future<int> insertWP(WordPicture wp) async {
    var dbClient = await _databaseHelper.db;
    var result = await dbClient.insert(tableName, wp.toMap());
    return result;
  }

  // Update Operation: Update a Topic object and save it to database
  Future<int> updateWP(WordPicture wp) async {
    var dbClient = await _databaseHelper.db;
    var result = await dbClient.update(tableName, wp.toMap(), where: '$idCol = ?', whereArgs: [wp.id]);
    return result;
  }

  // Delete Operation: Delete a Topic object from database
  Future<int> deleteWP(int entryId) async {
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

  Future<int> getTopicWPCount(int topicId) async {
    var dbClient = await _databaseHelper.db;
    //List<Map<String,dynamic>> x= await dbClient.query(tableName,where: '$idCol = ?', whereArgs: [topicId]);
    List<Map<String, dynamic>> x = await dbClient.rawQuery('SELECT COUNT (*) from $tableName WHERE $topicIdCol= $topicId');
    int result =Sqflite.firstIntValue(x);
    return result;
  }

}