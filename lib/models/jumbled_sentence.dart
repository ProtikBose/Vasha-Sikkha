import 'package:Dimik/models/task.dart';

class JumbledList {
  List<Jumbled> _sms;

  JumbledList._({List<Jumbled> sms}) : _sms = sms;

  factory JumbledList.fromJson(List<dynamic> parsedJson, String topicID) {
    List<Jumbled> sms = new List<Jumbled>();
    sms = parsedJson.map((i) => Jumbled.fromJson(i)).toList();

    return new JumbledList._(sms: sms);
  }
  /*
    void setTopicId(String topicId) {
    for (int i = 0; i < sms.length; i++) {
      sms[i].topicId = topicId;
    }
    
  }
  */
  List<Jumbled> get sms => _sms;
}

class Jumbled extends Task {
  int _id;
  //int _answerCount;
  List<String> _segments;
  String _english_sentence;
  String _bangla_meaning;
  String _topic_id;
  int _taskId;
  int _specificTaskId;

  factory Jumbled.fromParam(
      {question,
      option,
      answer,
      explanation,
      taskName,
      taskId,
      topicId,
      specificTaskId}) {
    return new Jumbled._(
        //id: g,
        taskname: taskName,
        taskId: taskId,
        specificTaskId: specificTaskId,
        id: topicId,
        english_sentence: question,
        segments: option,
        bangla_meaning: answer);
        //explanation: explanation);
  }

  Jumbled._(
      {String taskname,
      int taskId,
      int specificTaskId,
      int id,
      List<String> segments,
      String english_sentence,
      String bangla_meaning,
      String topic_id})
      :
        //SM._({int id,String question,String englishSentence,String banglaSentence}):
        _id = id,
        
        _segments = segments,
        _english_sentence = english_sentence,
        _bangla_meaning = bangla_meaning,
        _topic_id = topic_id,
        super(taskname, taskId, specificTaskId);

  //   factory Jumbled.fromParam({String taskname, int taskId, int specificTaskId, String segments, String english, String bangla}){

  //   var temp= json["segments"];
  //   List<String>segments= new List<String>.from(temp);

  //   return new Jumbled._(
  //   //return new SM._(
  //     //id: g,
  //     taskname: taskname,
  //     taskId: taskId,
  //     specificTaskId: specificTaskId,
  //     segments: segments,
  //     english_sentence: json['english_sentence'],
  //     bangla_meaning: json['bangla_meaning'],

  //   );
  // }

  factory Jumbled.fromJson(Map<String, dynamic> json) {
    //var dataList=json['data'];
    /*
    var temp= json['Options'];
    List<String>optionList= new List<String>.from(temp);
    var temp1= json['Answers'];
    List<String>answerList = new List<String>.from(temp1);
    */
    //var g=int.parse(json['id']);//Id of MockApi returns as a string.Will be changed when taking data from laravel
    //print(g.runtimeType);

    var temp = json["segments"];
    List<String> segments = new List<String>.from(temp);

    return new Jumbled._(
      //return new SM._(
      //id: g,
      taskname: json['Task_Name'],
      taskId: json['task_id'],
      specificTaskId: json['specific_task_id'],
      segments: segments,
      english_sentence: json['english_sentence'],
      bangla_meaning: json['bangla_meaning'],
      //topic_id: json['topic_ID']
      
    );
  }

  //getter
  int get id => _id;

  List<String> get segments => _segments;

  String get englishSentence => _english_sentence;

  String get banglaMeaning => _bangla_meaning;

  int get taskId => _taskId;

  int get specificTaskId => _specificTaskId;
  //String get topicId=> _topic_id;

  //String get explanation => _explanation;
  //setter
  set id(int smId) {
    this._id = smId;
  }

  set segments(List<String> segments) {
    this._segments = segments;
  }

  set englishSentence(String englishSentence) {
    this._english_sentence = englishSentence;
  }

  set banglaMeaning(String banglaSentence) {
    this._bangla_meaning = banglaSentence;
  }

  set taskId(int t){
    this._taskId=t;
  }

  set specificTaskId(int t){
    this._specificTaskId=t;
  }

  @override
  String get taskname {
    return "Jumbled Sentence";
  }

  /*
  set topicId(String s){
    this._topic_id = s;
  }
  */
  /*
  set explanation(String explanation)
  {
    this._explanation=explanation;
  }

  String _concatenateListElements(List<String>list)
  { 
    if(list==null)
      return '';
    String res='';
    for(int i=0;i<list.length;i++)
    {
      if(i!=list.length-1)
        res=res+list[i]+'#';
      else
        res=res+list[i];
    }
    return res;
    
  }
  */
  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (id != null) {
      map['Id'] = id;
    }

    //transform the list of words(_segments) into one single string
    String segText = "";
    for (int i = 0; i < _segments.length; i++) {
      if (i != _segments.length - 1)
        segText += (_segments.elementAt(i) + ",");
      else
        segText += _segments.elementAt(i);
    }

    map['Segments'] = segText;
    map['EnglishSentence'] = _english_sentence;
    map['BanglaMeaning'] = _bangla_meaning;
    map['Topic_Id'] = _topic_id;
    //map['AnswerCount'] = answerCount;

    return map;
  }

  Jumbled.fromMapObject(Map<String, dynamic> map) : super.empty() {
    this._id = map['Id'];
    //this.answerCount = map['AnswerCount'];

    //transform the one single string containing the segments into a list of words
    String segText = map['Segments'];

    this._segments = segText.split(',');
    this._english_sentence = map['EnglishSentence'];
    this._bangla_meaning = map['BanglaMeaning'];
    this._topic_id = map['Topic_Id'];
    //this._explanation = map['Explanation'];
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
