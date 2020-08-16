import 'package:Dimik/models/task.dart';

class SMEList extends Task {
  List<SME> _sms;

  SMEList():super('SMEList',0,0);
  SMEList._({List<SME> sms}) : _sms = sms,super.empty();

  factory SMEList.fromJson(List<dynamic> parsedJson) {
    List<SME> sms = new List<SME>();
    sms = parsedJson.map((i) => SME.fromJson(i)).toList();

    return new SMEList._(sms: sms);
  }

  void set topicId(int topicId) {
    for (int i = 0; i < sms.length; i++) {
      sms[i].topicId = topicId;
    }
  }

      @override
  String get taskname{
    return "Sentence Matching English";
  }

  List<SME> get sms => _sms;

  set sms(List<SME> sme)
  {
      _sms=sme;
  }
}

class SME extends Task{
  int _id;
  //int _answerCount;

  String _first_segment;
  String _last_segment;
  String _broken_sentence;
  String _englishSentence;
  String _banglaSentence;
  int _topicId;
  int _taskId;
  int _specificTaskId;
  //String _explanation;

   factory SME.fromParam({first, last, taskId,topicId, specificTaskId}) {
        return new SME._(
        //id: g,
        first_segment: first,
        last_segment: last,
        taskId: taskId,
        specificTaskId: specificTaskId
      );
    }

   SME._({String taskname, int taskId,int specificTaskId,int id,String first_segment,String last_segment,String broken_sentence,String englishSentence,String banglaSentence}):
   //SME._({int id,String first_segment,String last_segment,String broken_sentence,String englishSentence,String banglaSentence}):
    this._id=id,
    this._first_segment = first_segment,
    this._last_segment = last_segment,
    this._broken_sentence = broken_sentence,
    this._englishSentence=englishSentence,
    this._banglaSentence=banglaSentence,
    this._taskId = taskId,
    this._specificTaskId = specificTaskId,
    super(taskname,taskId,specificTaskId);
  

  factory SME.fromSegment(Map<String,dynamic>segment,String taskName,int taskId)
  {
      return new SME._(
    //return new SME._(
      //id: g,
      taskname: taskName,
      taskId: taskId,
      specificTaskId: segment['specific_task_id'],
      first_segment: segment['first_segment'],
      last_segment: segment['last_segment'],
      broken_sentence: segment['broken_sentence'],
      englishSentence: segment['english_sentence'],
      banglaSentence: segment['bangla_sentence'],
    );
  }

  factory SME.fromJson(Map<String, dynamic> json){
    
    return new SME._(
    //return new SME._(
      //id: g,
      taskname: json['Task_Name'],
      taskId: json['task_id'],
      specificTaskId: json['specific_task_id'],
      first_segment: json['first_segment'],
      last_segment: json['last_segment'],
      broken_sentence: json['broken_sentence'],
      englishSentence: json['english_sentence'],
      banglaSentence: json['bangla_sentence'],
    );
  }

  //getter
  int get id => _id;

  int get taskId => _taskId;

  int get specificTaskId => _specificTaskId;

  String get englishSentence => this._englishSentence;

  String get banglaSentence => this._banglaSentence;

  String get lastSegment => this._last_segment;

  String get firstSegment => this._first_segment;

  String get brokenSetence => this._broken_sentence;

  int get topicId => _topicId;
  //String get explanation => _explanation;
  //setter
  set id(int smId) {
    this._id = smId;
  }

  set taskId(int t){
    this._taskId = t;
  }

  set specificTaskId(int t){
    this._specificTaskId = t;
  }

  set brokenSentence(String brokenSentence) {
    this._broken_sentence = brokenSentence;
  }

  set englishSentence(String englishSentence) {
    this._englishSentence = englishSentence;
  }

  set banglaSentence(String banglaSentence) {
    this._banglaSentence = banglaSentence;
  }

  set firstSegment(String firstSegment) {
    this._first_segment = firstSegment;
  }

  set lastSegment(String lastSegment) {
    this._last_segment = lastSegment;
  }

  set topicId(int t){
    this._topicId = t;
  }

    @override
  String get taskname{
    return "Sentence Matching English";
  }

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
    //map['Question'] = question;
    map['EnglishSentence'] = _englishSentence;
    map['BanglaSentence'] = _banglaSentence;
    map['BrokenSentence'] = _broken_sentence;
    map['FirstSegment'] = _first_segment;
    map['LastSegment'] = _last_segment;
    map['Topic_Id'] = _topicId;
    map['Task_Id'] = _taskId;
    map['Specific_Task_Id'] = _specificTaskId;
    //map['AnswerCount'] = answerCount;
    //map['Explanation'] = explanation;

    return map;
  }

  SME.fromMapObject(Map<String, dynamic> map):super.empty() {
    this._id = map['Id'];
    //this.answerCount = map['AnswerCount'];
    //this._question = map['Question'];
    this._englishSentence = map['EnglishSentence'];
    this._banglaSentence = map['BanglaSentence'];
    this._broken_sentence = map['BrokenSentence'];
    this._first_segment = map['FirstSegment'];
    this._last_segment = map['LastSegment'];
    this._topicId = map['Topic_Id'];
    this._taskId = map['Task_Id'];
    this._specificTaskId = map['Specific_Task_Id'];

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