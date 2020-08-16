import 'dart:async';
import 'dart:io' as io;

import 'package:path/path.dart';
import '../../models/tf.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

import './main.dart';

class TFDatabaseHelper{

  static final TFDatabaseHelper _instance = new TFDatabaseHelper.internal();
  factory TFDatabaseHelper() => _instance;
  final MainDatabaseHelper _databaseHelper= new MainDatabaseHelper();

  TFDatabaseHelper.internal();
  

  String tableName='TF';
  String idCol='Id';
  String questionCol='Question';
  String englishSentenceCol='Answer';
  String banglaSentenceCol='Explanation';
  String topicIdCol='Topic_Id';
  

  Future<List<TF> > getTFList(int topicId) async {
    Database dbClient = await _databaseHelper.db;

    List<Map<String,dynamic> > result = await dbClient.query(tableName,where:'$topicIdCol = ?',whereArgs: [topicId]);
    List<TF> tList= new List<TF>();
    for(int i=0;i<result.length;i++)
    {
      TF tf=new TF.fromMapObject(result[i]);
      tList.add(tf);
    }
   // var result = await db.query(noteTable, orderBy: '$colPriority ASC');
    //return result;
    return tList;
  }

  // Insert Operation: Insert a Topic object to database
  Future<int> insertTF(TF tf) async {
    var dbClient = await _databaseHelper.db;
    var result = await dbClient.insert(tableName, tf.toMap());
    return result;
  }

  // Update Operation: Update a Topic object and save it to database
  Future<int> updateTF(TF tf) async {
    var dbClient = await _databaseHelper.db;
    var result = await dbClient.update(tableName, tf.toMap(), where: '$idCol = ?', whereArgs: [tf.id]);
    return result;
  }

  // Delete Operation: Delete a Topic object from database
  Future<int> deleteTF(int entryId) async {
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

  Future<int> getTopicTFCount(int topicId) async {
    var dbClient = await _databaseHelper.db;
    //List<Map<String,dynamic>> x= await dbClient.query(tableName,where: '$idCol = ?', whereArgs: [topicId]);
    List<Map<String, dynamic>> x = await dbClient.rawQuery('SELECT COUNT (*) from $tableName WHERE $topicIdCol= $topicId');
    int result =Sqflite.firstIntValue(x);
    return result;
  }

}