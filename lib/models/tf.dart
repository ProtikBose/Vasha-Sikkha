import 'package:Dimik/models/task.dart';

class TFList {
  List<TF> _tfs;

  TFList._({List<TF> tfs}) : _tfs = tfs;

  factory TFList.fromJson(List<dynamic> parsedJson) {
    List<TF> tfs = new List<TF>();
    tfs = parsedJson.map((i) => TF.fromJson(i)).toList();

    return new TFList._(tfs: tfs);
  }

  List<TF> get tfs => _tfs;

  void setTopicId(int topicId) {
    for (int i = 0; i < tfs.length; i++) tfs[i].topicId = topicId;
  }
}

class TF extends Task {
  int _id;
  //int _answerCount;
  String _question;
  int _answer;
  String _explanation;
  int _topicId;
  //String _explanation;

  TF._({String taskname,int taskId,int specificTaskId,int id, String question, int answer, String explanation, int topicId})
      : 
        _id = id,
        _question = question,
        _answer = answer,
        _explanation = explanation,
        _topicId = topicId,
        super(taskname,taskId,specificTaskId);

  @override
  String get taskname {
    return "True False";
  }

  factory TF.fromJson(Map<String, dynamic> json) {
    //var dataList=json['data'];
    /*
    var temp= json['Options'];
    List<String>optionList= new List<String>.from(temp);
    var temp1= json['Answers'];
    List<String>answerList = new List<String>.from(temp1);
    */
    //var g=int.parse(json['id']);//Id of MockApi returns as a string.Will be changed when taking data from laravel
    //print(g.runtimeType);

    return new TF._(
      //id: g,
      taskname: json['Task_Name'],
      taskId: json['task_id'],
      specificTaskId: json['specific_task_id'],
      question: json['question'],
      answer: json['answer'],
      explanation: json['explanation'],
    );
  }

  //getter
  int get id => _id;

  String get question => _question;

  int get answer => _answer;

  String get explanation => _explanation;

  int get topicId => _topicId;

  //String get explanation => _explanation;
  //setter
  set id(int tfId) {
    this._id = tfId;
  }

  set question(String tfQuestion) {
    this._question = tfQuestion;
  }

  set answer(int tfAnswer) {
    this._answer = tfAnswer;
  }

  set explanation(String explanation) {
    this._explanation = explanation;
  }

  set topicId(int topicId) {
    this._topicId = topicId;
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
    if (_id != null) {
      map['Id'] = id;
    }
    if (_topicId != null) {
      map['Topic_Id'] = _topicId; //should not be null through
    }
    map['Question'] = _question;
    map['Answer'] = _answer;
    map['Explanation'] = _explanation;
    //map['AnswerCount'] = answerCount;
    //map['Explanation'] = explanation;

    return map;
  }

  TF.fromMapObject(Map<String, dynamic> map):super.empty() {
    this._id = map['Id'];
    //this.answerCount = map['AnswerCount'];
    this._question = map['Question'];
    this._answer = map['Answer'];
    this._explanation = map['Explanation'];
    //this._explanation = map['Explanation'];
  }

  String toString() {
    String res = '';
    print(_id.toString());

    //res+=_id.toString();
    res += _question + '__';
    res += _answer.toString() + '__';
    res += _explanation;
    //res+=_explanation;
    return res;
  }
}
