/*
import 'dart:async';

import '../utils/network_util.dart';
import '../models/token.dart';
import '../models/topic.dart';
import '../models/task.dart';

class RestDatasource {
  NetworkUtil _netUtil = new NetworkUtil();
  static const BASE_URL = "http://192.168.43.225:8000/api";
  static const LOGIN_URL = BASE_URL + "/login";
  static const REG_URL = BASE_URL + "/register";
  static const TASK_URL = BASE_URL + "/allTasks";
  static const TOPIC_URL = BASE_URL + "/allTopics";
  static const VOCAB_URL = BASE_URL + "allVocabulary";

  static const API_KEY = "somerandomkey";

  Future<Token> login(String username, String password) {
    return _netUtil.post(LOGIN_URL, body: {
      "email": username,
      "password": password
    }).then((dynamic res) {
      print("DEBUG :=====================\n"+
      res.toString()+"\n=====================\n");
      if(res["error"] == "Unauthorised") throw new Exception(res["error"]);
      return new Token.map(res["success"]);
    });
  }

  Future<Token> register(String email,String username, String password) {
    return _netUtil.post(REG_URL, body: {
      "name": username,
      "email": email,
      "password": password,
      "c_password": password,
    }).then((dynamic res) {
      print("DEBUG :=====================\n"+
      res.toString()+"\n=====================\n");
      if(res["error"] == "Unauthorised") throw new Exception(res["error"]);
      return new Token.map(res["success"]);
    });
  }

  Future<List<Topic>> allTopics(String token) {
     List<Topic> list = List();

    return _netUtil.get(TOPIC_URL, headers: {
      "Content-Type": "application/x-www-form-urlencoded",
      "Accept": "application/json",
      "Authorization": "Bearer "+token,
    }).then((dynamic res) {
      print("DEBUG :=====================\n"+
      res.toString()+"\n=====================\n");
      list = (res as List)
          .map((data) => new Topic.fromJson(data))
          .toList();
      if(res["message"] == "Unauthenticated.") throw new Exception(res["message"]);
      return list;
    });
  }

  Future<List<Task>> allTasks(String token) {
     List<Task> list = List();

    return _netUtil.get(TASK_URL, headers: {
      "Content-Type": 'application/x-www-form-urlencoded',
      "Accept": 'application/json',
      "Authorization": "Bearer "+token,
    }).then((dynamic res) {
      print("DEBUG :=====================\n"+
      res.toString()+"\n=====================\n");
      // list = (res as List)
      //     .map((data) => new Task.fromJson(data))
      //     .toList();
      if(res["message"] == "Unauthenticated.") throw new Exception(res["message"]);
      return list;
    });
  }

  Future<Token> allVocab(String token) {
    return _netUtil.get(TASK_URL, headers: {
      "Content-Type": "application/x-www-form-urlencoded",
      "Accept": "application/json",
      "Authorization": "Bearer "+token,
    }).then((dynamic res) {
      print("DEBUG :=====================\n"+
      res.toString()+"\n=====================\n");
      if(res["message"] == "Unauthorised") throw new Exception(res["error"]);
      return new Token.map(res["success"]);
    });
  }

  //   Future<User> login(String username, String password) {
  //   return _netUtil.post(LOGIN_URL, body: {
  //    // "token": _API_KEY,
  //     "username": username,
  //     "password": password
  //   }).then((dynamic res) {
  //     print(res.toString());
  //     if(res["error"]) throw new Exception(res["error_msg"]);
  //     return new User.map(res["user"]);
  //   });
  // }
}
*/