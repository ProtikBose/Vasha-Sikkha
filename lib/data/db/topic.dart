import 'dart:async';
import 'dart:io' as io;

import 'package:Dimik/data/db/main.dart';
import 'package:path/path.dart';
import '../../models/topic.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class TopicDatabaseHelper {
  
  static final TopicDatabaseHelper _instance = new TopicDatabaseHelper.internal();
  factory TopicDatabaseHelper() => _instance;

  final MainDatabaseHelper _databaseHelper= new MainDatabaseHelper();

  TopicDatabaseHelper.internal();

  String tableName='Topic';
  String idCol='Id';
  String topicNameCol='Topic_Name';
  String topicImageLinkCol='Image_Link';
  String topicIsLovedCol='Is_Loved';
  String topicProgressCol='Progress';
  String topicLevelCol = 'Level';


  Future<List<Topic>> getTopicList() async {
    Database dbClient = await _databaseHelper.db;

    List<Map<String,dynamic> > result = await dbClient.rawQuery('SELECT * FROM $tableName');
    
    List<Topic>tList= new List<Topic>();
    for(int i=0;i<result.length;i++)
      tList.add(new Topic.fromMapObject(result[i]));

   // var result = await db.query(noteTable, orderBy: '$colPriority ASC');
    //return result;
    return tList;
  }

  // Insert Operation: Insert a Topic object to database
  Future<int> insertTopic(Topic topic) async {
    var dbClient = await _databaseHelper.db;
    var result = await dbClient.insert(tableName, topic.toMap());
    return result;
  }

  // Update Operation: Update a Topic object and save it to database
  Future<int> updateTopic(Topic topic) async {
    var dbClient = await _databaseHelper.db;
    var result = await dbClient.update(tableName, topic.toMap(), where: '$idCol = ?', whereArgs: [topic.id]);
    return result;
  }

  // Delete Operation: Delete a Topic object from database
  Future<int> deleteTopic(int entryId) async {
    var dbClient = await _databaseHelper.db;
    int result = await dbClient.rawDelete('DELETE FROM $tableName WHERE $idCol = $entryId');
    return result;
  }

  Future<int>deleteAll()async{
    var dbClient= await _databaseHelper.db;
    int result= await dbClient.rawDelete('DELETE * FROM $tableName');
    return result;
  }

  // Get number of Note objects in database
  Future<int> getCount() async {
    var dbClient = await _databaseHelper.db;
    List<Map<String, dynamic>> x = await dbClient.rawQuery('SELECT COUNT (*) from $tableName');
    int result = Sqflite.firstIntValue(x);
    return result;
  }

  

  /*
 static final table = 'my_table';
  
  static final columnId = '_id';
  static final columnName = 'name';
  static final columnAge = 'age';

  // make this a singleton class
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  // only have a single app-wide reference to the database
  static Database _database;
  Future<Database> get database async {
    if (_database != null) return _database;
    // lazily instantiate the db the first time it is accessed
    _database = await _initDatabase();
    return _database;
  }
  
  // this opens the database (and creates it if it doesn't exist)
  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(path,
        version: _databaseVersion,
        onCreate: _onCreate);
  }

  // SQL code to create the database table
  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE $table (
            $columnId INTEGER PRIMARY KEY,
            $columnName TEXT NOT NULL,
            $columnAge INTEGER NOT NULL
          )
          ''');
  }
  
  // Helper methods

  // Inserts a row in the database where each key in the Map is a column name
  // and the value is the column value. The return value is the id of the
  // inserted row.
  Future<int> insert(Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.insert(table, row);
  }

  // All of the rows are returned as a list of maps, where each map is 
  // a key-value list of columns.
  Future<List<Map<String, dynamic>>> queryAllRows() async {
    Database db = await instance.database;
    return await db.query(table);
  }

  // All of the methods (insert, query, update, delete) can also be done using
  // raw SQL commands. This method uses a raw query to give the row count.
  Future<int> queryRowCount() async {
    Database db = await instance.database;
    return Sqflite.firstIntValue(await db.rawQuery('SELECT COUNT(*) FROM $table'));
  }

  // We are assuming here that the id column in the map is set. The other 
  // column values will be used to update the row.
  Future<int> update(Map<String, dynamic> row) async {
    Database db = await instance.database;
    int id = row[columnId];
    return await db.update(table, row, where: '$columnId = ?', whereArgs: [id]);
  }

  // Deletes the row specified by the id. The number of affected rows is 
  // returned. This should be 1 as long as the row exists.
  Future<int> delete(int id) async {
    Database db = await instance.database;
    return await db.delete(table, where: '$columnId = ?', whereArgs: [id]);
  }
  */
}