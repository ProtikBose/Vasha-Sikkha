import 'dart:async';
import 'dart:io' as io;

import 'package:path/path.dart';
import '../../models/user.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

import './main.dart';

class UserDatabaseHelper{

  static final UserDatabaseHelper _instance = new UserDatabaseHelper.internal();
  factory UserDatabaseHelper() => _instance;
  final MainDatabaseHelper _databaseHelper= new MainDatabaseHelper();

  UserDatabaseHelper.internal();

  String userTable='User';
  String userIdCol='Id';
  String userNameCol='Username';
  String userEmailCol = 'Email';
  String userImageLinkCol='Image_Link';
  String userExperienceIdCol='ExperienceId';
  String userAgeCol='Age';
  String userTokenCol='Token';

  
  Future<List<User> > getUserList() async {
    Database dbClient = await _databaseHelper.db;

    List<Map<String,dynamic> > result = await dbClient.rawQuery('SELECT * FROM $userTable');
    
    List<User>uList=new List<User>();
    for(int i=0;i<result.length;i++)
    {
        uList.add(User.fromMapObject(result[i]));
    }
    // var result = await db.query(noteTable, orderBy: '$colPriority ASC');
    //return result;
    return uList;
  }

  // Insert Operation: Insert a Topic object to database
  Future<int> insertUser(User user) async {
    var dbClient = await _databaseHelper.db;
    var result = await dbClient.insert(userTable, user.toMap());
    return result;
  }

  // Update Operation: Update a Topic object and save it to database
  Future<int> updateUser(User user) async {
    var dbClient = await _databaseHelper.db;
    var result = await dbClient.update(userTable, user.toMap(), where: '$userIdCol = ?', whereArgs: [user.id]);
    return result;
  }

  // Delete Operation: Delete a Topic object from database
  Future<int> deleteMCQ(int entryId) async {
    var dbClient = await _databaseHelper.db;
    int result = await dbClient.rawDelete('DELETE FROM $userTable WHERE $userIdCol = $entryId');
    return result;
  }


  Future<int> getCount() async {
    var dbClient = await _databaseHelper.db;
    List<Map<String, dynamic>> x = await dbClient.rawQuery('SELECT COUNT (*) from $userTable');
    int result = Sqflite.firstIntValue(x);
    return result;
  }

}