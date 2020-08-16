import 'task.dart';

class MCQList extends Task {
  List<MCQ> _mcqs;

  MCQList() : super('MCQList', 0, 0);
  MCQList._({List<MCQ> mcqs})
      : _mcqs = mcqs,
        super.empty();

  factory MCQList.fromJson(List<dynamic> parsedJson) {
    List<MCQ> tempMcqs = new List<MCQ>();
    tempMcqs = parsedJson.map((i) => MCQ.fromJson(i)).toList();

    return new MCQList._(mcqs: tempMcqs);
  }

  void set topicId(int topicId) {
    for (int i = 0; i < mcqs.length; i++) {
      mcqs[i].topicId = topicId;
    }
  }

  List<MCQ> get mcqs => _mcqs;
  set mcqs(List<MCQ> sms) {
    _mcqs = sms;
  }
}

class MCQ extends Task {
  //final int _mcqId;
  int _id;
  String _question;
  List<String> _options;
  List<String> _answer;
  String _explanation;
  int _topicId;
  int _taskId;
  int _specificTaskId;

  factory MCQ.fromParam(
      {question,
      option,
      answer,
      explanation,
      taskName,
      taskId,
      topicId,
      specificTaskId}) {
    return new MCQ._(
        //id: g,
        taskname: taskName,
        taskId: taskId,
        specificTaskId: specificTaskId,
        id: topicId,
        question: question,
        options: option,
        answer: answer,
        explanation: explanation);
  }

  MCQ._(
      {String taskname,
      int taskId,
      int specificTaskId,
      int id,
      String question,
      List<String> options,
      List<String> answer,
      String explanation})
      : super(taskname, taskId, specificTaskId) {
    _id = id;
    _question = question;
    _options = options;
    _answer = answer;
    _explanation = explanation;
    _taskId = taskId;
    _specificTaskId = specificTaskId;
  }

  factory MCQ.fromSegment(
      Map<String, dynamic> segment, String taskName, int taskId) {
    return new MCQ._(
      taskname: taskName,
      taskId: taskId,
      specificTaskId: segment['specific_task_id'],
      //question: json['broken_sentence'],
      explanation: segment["Explanation"],
      question: segment["Question"],
      options: segment["Options"],
      answer: segment['Answer'],
    );
  }

  factory MCQ.fromJson(Map<String, dynamic> json) {
    var temp = json["Options"];
    List<String> optionList = new List<String>.from(temp);
    List<String> answerList = new List<String>.from(json['Answer']);
    //for(int i=0;i<optionList.length;i++)
    //print(optionList[i]);

    return new MCQ._(
        //return new MCQ._(
        //id: json["Id"],
        taskname: json['Task_Name'],
        taskId: json['task_id'],
        specificTaskId: json['specific_task_id'],
        question: json["Question"],
        options: optionList,
        answer: answerList,
        explanation: json["Explanation"]);
  }
  //getters and setters

  //getter
  int get id => _id;

  String get question => _question;

  List<String> get options => _options;

  List<String> get answer => _answer;

  String get explanation => _explanation;

  int get topicId => _topicId;

  int get taskId => _taskId;

  int get specificTaskId => _specificTaskId;
  //setters
  set id(int mcqId) {
    this._id = mcqId;
  }

  set question(String mcqQuestion) {
    this._question = mcqQuestion;
  }

  set options(List<String> mcqOptions) {
    this._options = mcqOptions;
  }

  set answer(List<String> mcqAnswer) {
    this._answer = mcqAnswer;
  }

  set topicId(int t) {
    this._topicId = t;
  }

  set taskId(int t) {
    this.taskId = t;
  }

  set specificTaskId(int t) {
    this.specificTaskId = t;
  }

  @override
  String get taskname {
    return "MCQ";
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
      map['Id'] = _id;
    }
    map['Question'] = _question;
    map['Options'] = _concatenateListElements(options);
    map['Answer'] = _concatenateListElements(answer);
    map['Explanation'] = _explanation;
    map['Topic_Id'] = _topicId;

    return map;
  }

  MCQ.fromMapObject(Map<String, dynamic> map) : super.empty() {
    this._id = map['Id'];
    this._question = map['Question'];
    this._options = map['Options'].split('#');
    this._answer = map['Answer'].split('#');
    this._explanation = map['Explanation'];
    this._topicId = map['Topic_Id'];
  }

  String toString() {
    String res = '';
    res += question + ' ';
    res += _concatenateListElements(options);
    res += _concatenateListElements(answer);
    res += explanation;
    return res;
  }

  String printOptions() {
    String res = '';
    for (int i = 0; i < options.length; i++) res += options[i] + ' ';
    return res;
  }
}
