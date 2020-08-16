import 'dart:ui';

import 'package:Dimik/config.dart';
import 'package:Dimik/models/task.dart';
import 'package:Dimik/utils/downloader.dart';

class MGList extends Task {
  List<MG> _sms;

  MGList._({List<MG> sms})
      : _sms = sms,
        super.empty();

  factory MGList.fromJson(List<dynamic> parsedJson) {
    List<MG> sms = new List<MG>();
    sms = parsedJson.map((i) => MG.fromJson(i)).toList();

    return new MGList._(sms: sms);
  }

  void setTopicId(int topicId) {
    for (int i = 0; i < _sms.length; i++) {
      _sms[i].topicId = topicId;
    }
  }

  void downloadImages() async {
    for (int i = 0; i < _sms.length; i++) {
      //it may be possible to further optimize this
      String name =
          'PW-Topic' + '-' + _sms[i].topicId.toString() + (i + 1).toString();
      await _sms[i].downloadImage(name);
    }
  }

  List<MG> get sms => _sms;
}

class MG extends Task {
  int _id;
  String _imageLink;
  List<String> _options;
  List<String> _correctAnswers;
  String _explanation;
  int _topicId;
  int _taskId;
  int _specificTaskId;

  MG._(
      {int id,
      String imageLink,
      List<String> options,
      List<String> correctAnswers,
      String taskname,
      int taskId,
      int specificTaskId})
      : super(taskname, taskId, specificTaskId) {
    _id = id;
    _imageLink = imageLink;
    _options = options;
    _correctAnswers = correctAnswers;
    _taskId = taskId;
    _specificTaskId = specificTaskId;
  }

  factory MG.fromParam(
      {String link,
      List<String> ops,
      List<String> correct,
      int taskId,
      int specificTaskId}) {
    return new MG._(
        //id: g,
        imageLink: link,
        options: ops,
        correctAnswers: correct,
        taskId: taskId,
        specificTaskId: specificTaskId);
  }

  factory MG.fromJson(Map<String, dynamic> json) {
    var ops = json['Options'];
    List<String> optionList = new List<String>.from(ops);
    var temp = json['Correct_answers'];
    List<String> correctList = new List<String>.from(temp);

    return new MG._(
      //id: g,
      taskname: json['Task_Name'],
      taskId: json['task_id'],
      specificTaskId: json['specific_task_id'],
      imageLink: json['Image_link'],
      options: optionList,
      correctAnswers: correctList,
    );
  }

  //getter
  int get topicId => _topicId;
  int get id => _id;
  List<String> get options => _options;
  List<String> get correctAnswers => _correctAnswers;
  String get imageLink => _imageLink;
  String get explanation => _explanation;
  int get taskId => _taskId;
  int get specificTaskId => _specificTaskId;

  //setter
  set id(int smId) {
    this._id = smId;
  }

  set options(List<String> options) {
    this._options = options;
  }

  set imageLink(String imageLink) {
    this._imageLink = imageLink;
  }

  set banglaSentence(List<String> correctAnswers) {
    this._correctAnswers = correctAnswers;
  }

  set explanation(String explanation) {
    this._explanation = explanation;
  }

  set topicId(int topicId) {
    this._topicId = topicId;
  }

  set taskId(int t) {
    this._taskId = t;
  }

  set specificTaskId(int t) {
    this._specificTaskId = t;
  }

  @override
  String get taskname {
    return "Memory Game";
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
    map['ImageLink'] = _imageLink;
    map['Options'] = _concatenateListElements(_options);
    map['CorrectAnswers'] = _concatenateListElements(_correctAnswers);
    //map['AnswerCount'] = answerCount;
    //map['Explanation'] = explanation;
    map['Topic_Id'] = _topicId;
    map['Task_Id'] = _taskId;
    map['Specific_Task_Id'] = _specificTaskId;

    return map;
  }

  void downloadImage(String name) async {
    Downloader downloader = new Downloader();
    String filename = name + '.jpg'; //extension may change
    _imageLink = IMAGE_URL + _imageLink;
    print(_imageLink);
    _imageLink = await downloader.downloadImg(_imageLink, filename);
    print(_imageLink);
  }

  MG.fromMapObject(Map<String, dynamic> map) : super.empty() {
    this._id = map['Id'];
    //this.answerCount = map['AnswerCount'];
    this._imageLink = map['ImageLink'];
    this._options = map['Options'].split('#');
    this._correctAnswers = map['CorrectAnswers'].split('#');
    //this._explanation = map['Explanation'];
    this._topicId = map['Topic_Id'];
    this._taskId = map['Task_Id'];
    this._specificTaskId = map['Specific_Task_Id'];
  }
  /*
  String toString()
  {
    String res='';
    print(_id.toString());
    
    res+=_id.toString();
    res+=_question;
    res+=_concatenateListElements(_options);
    res+=_concatenateListElements(_answers);
    res+=_explanation;
    return res;
  }
  */
}
