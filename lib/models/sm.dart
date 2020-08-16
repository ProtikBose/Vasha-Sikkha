import 'task.dart';

class SMList extends Task{
  List<SM> _sms;

  SMList():super('SMList',0,0);
  SMList._({List<SM> sms}) : _sms = sms,super.empty();

  factory SMList.fromJson(List<dynamic> parsedJson) {
    List<SM> sms = new List<SM>();
    sms = parsedJson.map((i) => SM.fromJson(i)).toList();

    return new SMList._(sms: sms);
  }

    @override
  String get taskname{
    return "Sentence Matching";
  }

    void set topicId(int topicId) {
    for (int i = 0; i < sms.length; i++) {
      sms[i].topicId = topicId;
    }
  }

  List<SM> get sms => _sms;

  set sms(List<SM> sms)
  {
      _sms=sms;
  }
}

class SM extends Task {
  int _id;
  String _englishSentence;
  String _banglaSentence;
  int _topicId;
  int _taskId;
  int _specificTaskId;
  //String _explanation;

  factory SM.fromParam({bangla, english, taskId,topicId, specificTaskId}) {
        return new SM._(
        //id: g,
        banglaSentence: bangla,
        englishSentence: english,
        taskId: taskId,
        
        specificTaskId: specificTaskId
      );
    }

  SM._(
      {String taskname,
      int taskId,
      int specificTaskId,
      int id,
      String question,
      String englishSentence,
      String banglaSentence})
      : _id = id,
        //_question = question,
        _englishSentence = englishSentence,
        _banglaSentence = banglaSentence,
        _taskId = taskId,
        _specificTaskId = specificTaskId,
        super(taskname, taskId, specificTaskId);
    
    factory SM.fromSegment(Map<String,dynamic>segment,String taskName,int taskId)
    {
        return new SM._(
        taskname: taskName,
        taskId: taskId,
        specificTaskId: segment['specific_task_id'],
        //question: json['broken_sentence'],
        englishSentence: segment['english_sentence'],
        banglaSentence: segment['bangla_sentence'],
        );
    }

    factory SM.fromJson(Map<String, dynamic> json) {
        return new SM._(
        //id: g,
        taskname: json['Task_Name'],
        taskId: json['task_id'],
        specificTaskId: json['specific_task_id'],
        //question: json['broken_sentence'],
        englishSentence: json['english_sentence'],
        banglaSentence: json['bangla_sentence'],
      );
    }

  //getter
  int get id =>_id;

  //String get question => _question;

  String get englishSentence => _englishSentence;

  String get banglaSentence => _banglaSentence;

  int get taskId => _taskId;

  int get specificTaskId => _specificTaskId;

  int get topicId => _topicId;
  // String get explanation => _explanation;
  //setter
  set id(int smId){
    this._id=smId;
  }

  set topicId(int t){
    this._topicId = t;
  }

  set englishSentence(String englishSentence){
    this._englishSentence=englishSentence;
  }

  set banglaSentence(String banglaSentence){
    this._banglaSentence=banglaSentence;
  }

  set taskId(int t){
    this._taskId = t;
  }

  set specificTaskId(int t){
    this._specificTaskId = t;
  }

  @override
  String get taskname{
    return "Sentence Matching";
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
   // map['Question'] = question;
    map['EnglishSentence'] = _englishSentence;
    map['BanglaSentence'] = _banglaSentence;
    map['Task_Id'] = taskId;
    map['Specific_Task_Id'] = specificTaskId;
    //map['AnswerCount'] = answerCount;
    
    // p //map['Explanation'] = explanation;
    
    return map;
  }

  SM.fromMapObject(Map<String, dynamic> map):super.empty() {
    this._id = map['Id'];
    //this.answerCount = map['AnswerCount'];
    //this._question = map['Question'];
    this._englishSentence= map['EnglishSentence'];
    this._banglaSentence = map['BanglaSentence'];
    this.taskId = map['Task_Id'];
    this.specificTaskId = map['Specific_Task_Id'];
    //this._explanation = map['Explanation'];
  }
  /*
  String toString()
  {
    String res='';
    print(_id.toString());
    
    res+=_id.toString();
    res+=_question;
  */
}
