import 'dart:math';

import 'task.dart';

class FBList {
  List<FB> _fbs;

  FBList._({List<FB> fbs}) : _fbs = fbs;

  factory FBList.fromJson(List<dynamic> parsedJson) {
    List<FB> fbs = new List<FB>();
    fbs = parsedJson.map((i) => FB.fromJson(i)).toList();

    return new FBList._(fbs: fbs);
  }

  void setTopicId(int topicId) {
    for (int i = 0; i < fbs.length; i++) {
      fbs[i].topicId = topicId;
    }
  }

  List<FB> get fbs => _fbs;
}

class FB extends Task {
  int _id;
  //int _answerCount;
  String _question;
  List<String> _options;
  List<String> _answers;
  String _explanation;
  int _topicId;

  factory FB.fromParam({question, option,answer,explanation,taskName, taskId,topicId, specificTaskId}) {
        return new FB._(
        //id: g,
        taskname: taskName,
        taskId: taskId,
        specificTaskId: specificTaskId,
        id:topicId,
        question: question,
        options: option,
        answers: answer,
        explanation: explanation
      );
    }

  FB._(
      {String taskname,
      int taskId,
      int specificTaskId,
      int id,
      String question,
      List<String> options,
      List<String> answers,
      String explanation})
      : _id = id,
        _question = question,
        _options = options,
        _answers = answers,
        _explanation = explanation,
        super(taskname, taskId, specificTaskId);

  factory FB.fromJson(Map<String, dynamic> json) {
    //var dataList=json['data'];
    var temp = json['Options'];
    List<String> optionList = new List<String>.from(temp);
    var temp1 = json['Answers'];
    List<String> answerList = new List<String>.from(temp1);
    //var g=int.parse(json['id']);//Id of MockApi returns as a string.Will be changed when taking data from laravel
    //print(g.runtimeType);

    return new FB._(
        //id: g,
        taskname: json['Task_Name'],
        taskId: json['task_id'],
        specificTaskId: json['specific_task_id'],
        question: json['Incomplete_Sentence'],
        options: optionList,
        answers: answerList,
        explanation: json['Explanation']);
  }

  //getter
  int get id => _id;

  String get question => _question;

  List<String> get options => _options;

  List<String> get answers => _answers;

  String get explanation => _explanation;

  int get topicId => _topicId;
  //setter
  set id(int fbId) {
    this._id = fbId;
  }

  set question(String fbQuestion) {
    this._question = fbQuestion;
  }

  set answers(List<String> answerList) {
    this._answers = answerList;
  }

  set options(List<String> optionList) {
    this._options = optionList;
  }

  set explanation(String explanation) {
    this._explanation = explanation;
  }

  set topicId(int t) {
    this._topicId = t;
  }
  
  @override
  String get taskname{
    return "FB";
  }

  String _concatenateListElements(List<String> list) {
    if (list == null) return '';
    String res = '';
    for (int i = 0; i < list.length; i++) {
      if (i != list.length - 1)
        res = res + list[i] + '#';
      else
        res = res + list[i];
    }
    return res;
  }

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (id != null) {
      map['Id'] = id;
    }
    map['Question'] = question;
    map['Options'] = _concatenateListElements(options);
    map['Answers'] = _concatenateListElements(answers);
    //map['AnswerCount'] = answerCount;
    map['Explanation'] = explanation;
    map['Topic_Id'] = _topicId;

    return map;
  }

  FB.fromMapObject(Map<String, dynamic> map) : super.empty() {
    this._id = map['Id'];
    //this.answerCount = map['AnswerCount'];
    this._question = map['Question'];
    this._options = map['Options'].split('#');
    this._answers = map['Answers'].split('#');
    this._explanation = map['Explanation'];
    this._topicId = map['Topic_Id'];
  }

  String toString() {
    String res = '';
    print(_id.toString());

    res += _id.toString();
    res += _question;
    res += _concatenateListElements(_options);
    res += _concatenateListElements(_answers);
    res += _explanation;
    return res;
  }
}
