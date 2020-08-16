

import 'dart:async';
import 'dart:io' as io;

import 'package:path/path.dart';
import '../models/token.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = new DatabaseHelper.internal();
  factory DatabaseHelper() => _instance;

  static Database _db;

  Future<Database> get db async {
    if (_db != null) return _db;
    _db = await initDb();
    return _db;
  }

  DatabaseHelper.internal();

  initDb() async {
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "main.db");
    print("DEBUG : === db path == : " + path);
    var theDb = await openDatabase(path, version: 1, onCreate: _onCreate);
    return theDb;
  }

  void _onCreate(Database db, int version) async {
    // When creating the db, create the table
    await db.execute("CREATE TABLE Token(id INTEGER PRIMARY KEY, token TEXT)");
    print("Created tables");
  }

  Future<int> saveToken(Token token) async {
    var dbClient = await db;
    int res = await dbClient.insert("Token", token.toMap());
    return res;
  }

  /*
  Future<String> getToken() async {
    var dbClient = await db;
    List<Map> list = await dbClient.rawQuery('SELECT * FROM Token');
    List<Token> token = new List();
    for (int i = 0; i < list.length; i++) {
      token.add(new Token(list[i]["token"]));
    }
    print(token.length);
    return token[0].getToken();
  }
  */
  Future<int> deleteTokens() async {
    var dbClient = await db;
    int res = await dbClient.delete("Token");
    return res;
  }

  Future<bool> isLoggedIn() async {
    var dbClient = await db;
    var res = await dbClient.query("Token");
    return res.length > 0 ? true : false;
  }
}
