import 'dart:async';
import 'dart:io' as io;

import 'package:path/path.dart';
import '../../models/sm.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

import './main.dart';

class SMDatabaseHelper {
  static final SMDatabaseHelper _instance = new SMDatabaseHelper.internal();
  factory SMDatabaseHelper() => _instance;
  final MainDatabaseHelper _databaseHelper = new MainDatabaseHelper();

  SMDatabaseHelper.internal();

  String tableName = 'SM';
  String idCol = 'Id';
  //String questionCol='Question';
  String englishSentenceCol = 'EnglishSentence';
  String banglaSentenceCol = 'BanglaSentence';
  String topicIdCol = 'Topic_Id';
  String taskIdCol = 'Task_Id';
  String specificTaskCol = 'Specific_Task_Id';

  Future<List<SM>> getSMList(int topicId) async {
    Database dbClient = await _databaseHelper.db;

    List<Map<String, dynamic>> result = await dbClient
        .query(tableName, where: '$topicIdCol = ?', whereArgs: [topicId]);
    List<SM> tList = new List<SM>();
    for (int i = 0; i < result.length; i++) {
      SM sm = new SM.fromMapObject(result[i]);
      tList.add(sm);
    }
    // var result = await db.query(noteTable, orderBy: '$colPriority ASC');
    //return result;
    return tList;
  }

  // Insert Operation: Insert a Topic object to database
  Future<int> insertSM(SM sm) async {
    var dbClient = await _databaseHelper.db;
    var result = await dbClient.insert(tableName, sm.toMap());
    return result;
  }

  // Update Operation: Update a Topic object and save it to database
  Future<int> updateSM(SM sm) async {
    var dbClient = await _databaseHelper.db;
    var result = await dbClient
        .update(tableName, sm.toMap(), where: '$idCol = ?', whereArgs: [sm.id]);
    return result;
  }

  // Delete Operation: Delete a Topic object from database
  Future<int> deleteSM(int entryId) async {
    var dbClient = await _databaseHelper.db;
    //int result = await dbClient.rawDelete('DELETE FROM $tableName WHERE $idCol = $entryId');
    int result = await dbClient
        .delete(tableName, where: '$idCol = ?', whereArgs: [entryId]);
    return result;
  }

  Future<int> getCount() async {
    var dbClient = await _databaseHelper.db;
    List<Map<String, dynamic>> x =
        await dbClient.rawQuery('SELECT COUNT (*) from $tableName');
    int result = Sqflite.firstIntValue(x);
    return result;
  }

  Future<int> getTopicSMCount(int topicId) async {
    var dbClient = await _databaseHelper.db;
    //List<Map<String,dynamic>> x= await dbClient.query(tableName,where: '$idCol = ?', whereArgs: [topicId]);
    List<Map<String, dynamic>> x = await dbClient.rawQuery(
        'SELECT COUNT (*) from $tableName WHERE $topicIdCol= $topicId');
    int result = Sqflite.firstIntValue(x);
    return result;
  }
}
