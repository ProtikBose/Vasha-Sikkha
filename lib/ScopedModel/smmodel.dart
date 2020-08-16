import 'package:Dimik/models/task.dart';
import 'package:scoped_model/scoped_model.dart';
import '../ScopedModel/mainmodel.dart';
import '../models/sm.dart';
import '../ui/task/sentence_matching_task/TaskElement.dart';
import 'package:flutter/material.dart';

class SMModel extends Model {
  bool _smIsLoaded = false;
  bool _smIsPressed = false;
  bool _randomizeSM = true;
  int _smTotalTasks = 0;
  int _smCurrentTask = 0;
  int _smSolved=0;
  int _smTotalQuestions=0;
  String _smButtonText = "Get Next";
  List<Map<TaskElementSM, TaskElementSM>> _smCards =
      new List<Map<TaskElementSM, TaskElementSM>>();
  List<int> _orderSM =[4,3,0,2,5,1];
  List<String> _explanationSM= ["","","","","",""];

  //getters
  bool get smIsLoaded => _smIsLoaded;
  bool get smIsPressed => _smIsPressed;
  int get smTotalTasks => _smTotalTasks;
  int get smCurrentTask => _smCurrentTask;
  int get smSolved => _smSolved;
  int get smTotalQuestions => _smTotalQuestions;
  String get smButtonText => _smButtonText;
  List<Map<TaskElementSM, TaskElementSM>> get smQuestionList => _smCards;
  List<int> get orderSM => _orderSM;
  bool get randomizeSM => _randomizeSM;
  List<String> get explanationSM => _explanationSM;


  void set smIsLoaded(bool b) {
    this._smIsLoaded = b;
  }


  void set smIsPressed(bool b) {
    this._smIsPressed = b;
  }

  void set smTotalTasks(int t) {
    this._smTotalTasks = t;
  }

  void set smCurrentTask(int t) {
    this._smCurrentTask = t;
  }

  void set smSolved(int t) {
    this._smSolved = t;
  }

  void set smTotalQuestions(int t) {
    this._smTotalQuestions = t;
  }

  void set smButtonText(String s) {
    this._smButtonText = s;
  }

  void set smQuestionList(List<Map<TaskElementSM, TaskElementSM>> sm) {
    this._smCards = sm;
  }

  set orderSM(List<int> l){
    this._orderSM = l;
  }

  set randomizeSM(bool b){
    this._randomizeSM = b;
  }



  void setSMQuestions(MainModel model, SMList smList) async {
    
    List<SM> qsList = new List<SM>();
    qsList = smList.sms;
    // SM sm1 = new SM.fromParam(bangla: "আ",english: "A",topicId: 1, taskId: 1, specificTaskId: 31);
    // SM sm2 = new SM.fromParam(bangla: "ক",english: "K",topicId: 1, taskId: 1, specificTaskId: 32);
    // SM sm3 = new SM.fromParam(bangla: "খ",english: "KHA",topicId: 1, taskId: 1, specificTaskId: 33);

    // qsList.add(sm1);
    // qsList.add(sm2);
    // qsList.add(sm3);
    // smc = new SMController();
    // //print("Topic :" +topic);
    // smc.getSMList(model.user.token, model.currentTopic.id).then((qsList) {
      // setState(() {
        model.smIsLoaded = true;
        // _isLoaded = true;
        // timeController.reverse(
        //     from: timeController.value == 0 ? 1 : timeController.value);

        int jsonSetArrived = 1;
        // int jsonSetArrived = qsList.length ~/ 3;
        // model.smTotalTasks = jsonSetArrived;
        // model.smCurrentTask = 1;
        // model.smTotalQuestions = model.smTotalTasks * 3;
        //model.smSolved = 0;
        if(randomizeSM == true){
          orderSM.shuffle();
          randomizeSM = false;
        }

        model.smQuestionList = new List<Map<TaskElementSM, TaskElementSM>>();
        for (int i = 0; i < jsonSetArrived; i++) {
          // _options[i] = new Map<String, String>();
          model.smQuestionList.add(new Map<TaskElementSM, TaskElementSM>());
        }

        int jsonNo = 0, index;
        qsList.forEach((qs) {
          index = (jsonNo ~/ 3);
          TaskElementSM ban =
              TaskElementSM(qs.banglaSentence, qs.taskId, qs.specificTaskId);
          TaskElementSM eng =
              TaskElementSM(qs.englishSentence, qs.taskId, qs.specificTaskId);

          model.smQuestionList.elementAt(index)[ban] = eng;
          //jsonNo++;
        });
    //   });
    // });
  }
}
