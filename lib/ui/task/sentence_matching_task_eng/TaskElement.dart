class TaskElementSME{
  String _sentence;
  int _taskID;
  int _specificTaskID;

  TaskElementSME({String sentence, int taskId, int specificTaskId}){
    this._sentence = sentence;
    this._taskID = taskId;
    this._specificTaskID = specificTaskId;
  }

  String get sentence => _sentence;
  int get taskID => _taskID;
  int get specificTaskID => _specificTaskID;

  void set sentence(String s){
    this._sentence = s;
  }

  void set taskID(int t){
    this._taskID = t;
  }

  void set specificTaskID(int t){
    this._specificTaskID = t;
  }
}