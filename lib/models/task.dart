import 'dart:math';

import 'package:Dimik/models/fb_word.dart';
import 'package:Dimik/models/memorygame.dart';
import 'package:Dimik/models/pictureword.dart';
import 'package:Dimik/models/wordpicture.dart';

import 'fb.dart';
import 'jumbled_sentence.dart';
import 'listening_item.dart';
import 'mcq.dart';
import 'sentence_from_story.dart'; //name to be changed
import 'sm.dart';
import 'sme.dart';
import 'tf.dart';

//const var=0;
class TaskList {
  List<Task> _tasks = [];

  TaskList._({List<Task> tasks}) : _tasks = tasks;

  factory TaskList.fromJson(List<dynamic> parsedJson) {
    List<Task> tasks = new List<Task>();
    print("inside from json of task.dart model");
    //tasks = parsedJson.map((i) => Task.fromJson(i)).toList();
    for (int i = 0; i < parsedJson.length; i++) {
      Task t = Task.fromJson(parsedJson[i]);
      if (t != null) tasks.add(t);
    }
    print("inside from json of task.dart model");
    TaskList t = new TaskList._(tasks: tasks);
    return t;
  }

  void arrangeElements() {
    List<Task> t = new List<Task>();
    for (int i = 0; i < _tasks.length; i++) {
      Task temp = _tasks[i];
      //if(temp.taskname!=null)
      //  print(temp.taskname);
      if (temp.taskname == 'SMEList' || temp.taskname == 'SMList') {
        if (temp.taskname == 'SMEList') {
          SMEList s = temp;
          List<SME> sme = s.sms;
          for (int j = 0; j < sme.length; j++) t.add(sme[j]);
        } else if (temp.taskname == 'SMList') {
          SMList s = temp;
          List<SM> sms = s.sms;
          for (int j = 0; j < sms.length; j++) t.add(sms[j]);
        }
      } else
        t.add(temp);
    }
    _tasks.addAll(t);
  }

  void setTopicId(int topicId) {
    for (int i = 0; i < this._tasks.length; i++) {
      print("in set topicId:" + topicId.toString());
      print("in set topicId: " + this._tasks[i].taskname);
      this._tasks[i].topicId = topicId;
    }
  }

  List<Task> get tasks => List.from(this._tasks);
}

class Task {
  String _taskname;
  int _specificTaskId;
  int _taskId;
  int _topicId;

  Task.empty();
  Task._({String taskname, int taskId, int specificTaskId})
      : _taskname = taskname,
        _specificTaskId = specificTaskId,
        _taskId = taskId;

  //Task({this.taskname,this.specificTaskId,this.taskId});
  Task(String taskname, int taskId, int specificTaskId, {String name}) {
    this._taskname = taskname;
    this._taskId = taskId;
    this._specificTaskId = specificTaskId;
  }

  //Task({String taskname,int specificTaskId,int taskId}):
  //_taskname=taskname,
  //_specificTaskId=specificTaskId,
  //_taskId=taskId;
  //int val=0;
  factory Task.fromJson(Map<String, dynamic> json) {
    String taskName = json['Task_Name'];
    Task task;
    if (taskName == "mcq") {
      //task = MCQ.fromJson(json);
      print("mcq model");
      task = MCQ.fromJson(json);
      // print(json.toString());
      // int taskId = json['task_id'];
      // List<dynamic> segments = json['Task'];
      // List<
      // MCQ mcqList =MCQ.fromJson(json);
      //     //MCQ.fromSegment(1, taskName, taskId);
      // //print(smeList.length);
      // MCQList temp = new MCQList();
      // temp.mcqs.add(mcqList);
      // task = temp;
    } 
    else if (taskName == "trueFalse") {
      print("true false model");
      task = TF.fromJson(json);
    } else if (taskName == "listeningword") {
      print("listening word model");
      task = ListeningItem.fromJson(json);
    } else if (taskName == "wordToPicture") {
      print("WP model");
      task = WordPicture.fromJson(json);
    } else if (taskName == "pictureToWord") {
      print("PW model");
      task = PictureWord.fromJson(json);
    } else if (taskName == "fillInTheBlanks") {
      print("FB model");
      task = FB.fromJson(json);
    } else if (taskName == "fillInTheBlanksLetter") {
      print("FBL model");
      task = FB_Word.fromJson(json);
    } else if (taskName == "sentenceMatching") {
      print("SM model");
      int taskId = json['task_id'];
      List<dynamic> segments = json['Task'];
      List<SM> smList =
          segments.map((i) => SM.fromSegment(i, taskName, taskId)).toList();
      //print(smList.length);
      SMList temp = new SMList();
      temp.sms = smList;
      task = temp;

      //task= SM.fromJson(json);
    } else if (taskName == "sentenceMatchingEngToEng") {
      print("SME model");
      //task=SME.fromJson(json);
      int taskId = json['task_id'];
      List<dynamic> segments = json['Task'];
      List<SME> smeList =
          segments.map((i) => SME.fromSegment(i, taskName, taskId)).toList();
      //print(smeList.length);
      SMEList temp = new SMEList();
      temp.sms = smeList;
      task = temp;
    }
    // else if(taskName=="memoryGame"){
    //   print("memoryGame model");
    //   task=MG.fromJson(json);

    // }
    else if (taskName == "fixJumbledSentence") {
      task = Jumbled.fromJson(json);
      print("jumbled model");
      // int taskId = json['task_id'];
      // List<dynamic> segments = json['Task'];
      // List<Jumbled> jumbleList =
      //     segments.map((i) => Jumbled.fromSegment(i, taskName, taskId)).toList();
      // //print(smeList.length);
      // SMEList temp = new SMEList();
      // temp.sms = smeList;
      // task = temp;

    } else if (taskName == "memoryGame") {
      print("memory game");
      print(json.toString());
      task = MG.fromJson(json);
      print("IN TASK.DART");
      print(task._taskId.toString());
      print(task._specificTaskId);
    }
    return task;
  }

  String get taskname => _taskname;

  int get specificTaskId => _specificTaskId;

  int get taskId => _taskId;

  int get topicId => _topicId;

  set taskname(String taskname) {
    _taskname = taskname;
  }

  set specificTaskId(int specificTaskId) {
    _specificTaskId = specificTaskId;
  }

  set taskId(int taskId) {
    _taskId = taskId;
  }

  set topicId(int topicId) {
    _topicId = topicId;
  }
}
