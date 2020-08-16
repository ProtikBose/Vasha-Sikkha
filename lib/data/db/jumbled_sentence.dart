import 'dart:async';
import 'dart:io' as io;

import 'package:path/path.dart';
import '../../models/jumbled_sentence.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

import './main.dart';

class JumbledDatabaseHelper{

  static final JumbledDatabaseHelper _instance = new JumbledDatabaseHelper.internal();
  factory JumbledDatabaseHelper() => _instance;
  final MainDatabaseHelper _databaseHelper= new MainDatabaseHelper();

  JumbledDatabaseHelper.internal();
  

  String tableName="JUMBLED";
  String idCol="Id";
  String segmentsCol="Segments";
  String englishSentenceCol="EnglishSentence";
  String banglaMeaningCol="BanglaMeaning";
  String topic_id = "Topic_Id";

  

  Future<List<Jumbled> > getSMList(String topic_id) async {
    Database dbClient = await _databaseHelper.db;

    List<Map<String,dynamic> > result = await dbClient.rawQuery('SELECT * FROM $tableName WHERE Topic_Id=$topic_id');
    List<Jumbled> sList= new List<Jumbled>();
    for(int i=0;i<result.length;i++)
    {
      Jumbled sm=new Jumbled.fromMapObject(result[i]);
      sList.add(sm);
    }
   // var result = await db.query(noteTable, orderBy: '$colPriority ASC');
    //return result;
    return sList;
  }

  // Insert Operation: Insert a Topic object to database
  Future<int> insertSM(Jumbled sm) async {
    var dbClient = await _databaseHelper.db;
    var result = await dbClient.insert(tableName, sm.toMap());
    return result;
  }

  // Update Operation: Update a Topic object and save it to database
  Future<int> updateSM(Jumbled sm) async {
    var dbClient = await _databaseHelper.db;
    var result = await dbClient.update(tableName, sm.toMap(), where: '$idCol = ?', whereArgs: [sm.id]);
    return result;
  }

  // Delete Operation: Delete a Topic object from database
  Future<int> deleteSM(int entryId) async {
    var dbClient = await _databaseHelper.db;
    int result = await dbClient.rawDelete('DELETE FROM $tableName WHERE $idCol = $entryId');
    return result;
  }
  // Future<int> deleteSM() async {
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