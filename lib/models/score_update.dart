class ScoreUpdate {
  int _topicID;
  int _taskID;
  int _specificTaskID;
  int _verdict;


  ScoreUpdate(int tpid, int tid, int stid, int v){
    this._topicID = tpid;
    this._taskID = tid;
    this._specificTaskID = stid;
    this._verdict = v;
  }



int get topicID => _topicID;
int get taskID => _taskID;
int get specificTaskID => _specificTaskID;
int get verdict => _verdict;

void set topicID(int t){
  this._topicID = t;
}

void set taskID(int t){
  this._taskID = t;
}

void set specificTaskID(int t){
  this._specificTaskID = t;
}

void set verdict(int t){
  this._verdict = t;
}

}