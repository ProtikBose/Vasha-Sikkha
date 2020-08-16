class TaskElementSM{
  String _sentence;
  int _taskID;
  int _specificTaskID;

  TaskElementSM(String s, int t, int st){
    this._sentence = s;
    this._taskID = t;
    this._specificTaskID = st;
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