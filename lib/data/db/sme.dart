import 'dart:async';
import 'dart:io' as io;

import 'package:path/path.dart';
import '../../models/sme.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

import './main.dart';

class SMEDatabaseHelper{

  static final SMEDatabaseHelper _instance = new SMEDatabaseHelper.internal();
  factory SMEDatabaseHelper() => _instance;
  final MainDatabaseHelper _databaseHelper= new MainDatabaseHelper();

  SMEDatabaseHelper.internal();
  

  String tableName='SME';
  String idCol='Id';
  String brokenSentCol='BrokenSentence';
  String englishSentenceCol='EnglishSentence';
  String banglaSentenceCol='BanglaSentence';
  String firstSegmentCol = 'FirstSegemnt';
  String lastSegmentCol = 'LastSegment';

  

  Future<List<SME> > getSMList() async {
    Database dbClient = await _databaseHelper.db;

    List<Map<String,dynamic> > result = await dbClient.rawQuery('SELECT * FROM $tableName');
    List<SME> sList= new List<SME>();
    for(int i=0;i<result.length;i++)
    {
      SME sm=new SME.fromMapObject(result[i]);
      sList.add(sm);
    }
   // var result = await db.query(noteTable, orderBy: '$colPriority ASC');
    //return result;
    return sList;
  }

  // Insert Operation: Insert a Topic object to database
  Future<int> insertSM(SME sm) async {
    var dbClient = await _databaseHelper.db;
    var result = await dbClient.insert(tableName, sm.toMap());
    return result;
  }

  // Future<int> deleteSM() async{
  //   var dbClient = await _databaseHelper.db;
  //   var result = await dbClient.delete(tableName);

  //   return result;
  // }

  // Update Operation: Update a Topic object and save it to database
  Future<int> updateSM(SME sm) async {
    var dbClient = await _databaseHelper.db;
    var result = await dbClient.update(tableName, sm.toMap(), where: '$idCol = ?', whereArgs: [sm.id]);
    return result;
  }

  //Delete Operation: Delete a Topic object from database
  Future<int> deleteSM(int entryId) async {
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