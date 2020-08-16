import 'dart:async';
import 'dart:io' as io;
import 'package:sqflite/sqflite.dart';
import './main.dart';
import '../../models/memorygame.dart';
import 'package:path_provider/path_provider.dart';

class MGDatabaseHelper {
  static final MGDatabaseHelper _instance = new MGDatabaseHelper.internal();
  factory MGDatabaseHelper() => _instance;
  final MainDatabaseHelper _databaseHelper = new MainDatabaseHelper();

  MGDatabaseHelper.internal();

  String mGTable = 'MG';
  String mGIdCol = 'Id';
  String mGImageLink = 'Image_link';
  String mGOptions = 'Options';
  String mGCorrect = 'Correct_answers';
  String mGTopicId = "Topic_Id";

  Future<List<MG>> getMGList(int topicId) async {
    Database dbClient = await _databaseHelper.db;

    List<Map<String, dynamic>> result = await dbClient
        .query(mGTable, where: '$mGTopicId = ?', whereArgs: [topicId]);
    List<MG> MGList = new List<MG>();
    for (int i = 0; i < result.length; i++) {
      MG pw = new MG.fromMapObject(result[i]);
      MGList.add(pw);
    }
    // var result = await db.query(noteTable, orderBy: '$colPriority ASC');
    //return result;
    return MGList;
  }

  Future<int> insertPW(MG pw) async {
    var dbClient = await _databaseHelper.db;
    var result = await dbClient.insert(mGTable, pw.toMap());
    return result;
  }

  // Update Operation: Update a Topic object and save it to database
  Future<int> updatePW(MG pw) async {
    var dbClient = await _databaseHelper.db;
    var result = await dbClient.update(mGTable, pw.toMap(), where: '$mGIdCol = ?', whereArgs: [pw.id]);
    return result;
  }

  // Delete Operation: Delete a Topic object from database
  Future<int> deletePW(int entryId) async {
    var dbClient = await _databaseHelper.db;
    //int result = await dbClient.rawDelete('DELETE FROM $tableName WHERE $idCol = $entryId');
    int result = await dbClient.delete(mGTable, where:'$mGIdCol = ?', whereArgs: [entryId]);
    return result;
  }


  Future<int> getCount() async {
    var dbClient = await _databaseHelper.db;
    List<Map<String, dynamic>> x = await dbClient.rawQuery('SELECT COUNT (*) from $mGTable');
    int result = Sqflite.firstIntValue(x);
    return result;
  }

  Future<int> getTopicPWCount(int topicId) async {
    var dbClient = await _databaseHelper.db;
    //List<Map<String,dynamic>> x= await dbClient.query(tableName,where: '$idCol = ?', whereArgs: [topicId]);
    List<Map<String, dynamic>> x = await dbClient.rawQuery('SELECT COUNT (*) from $mGTable WHERE $mGTopicId= $topicId');
    int result =Sqflite.firstIntValue(x);
    return result;
  }



}
