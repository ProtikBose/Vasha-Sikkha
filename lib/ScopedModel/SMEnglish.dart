import 'package:Dimik/ScopedModel/mainmodel.dart';
import 'package:Dimik/models/sme.dart';
import 'package:scoped_model/scoped_model.dart';
import '../ui/task/sentence_matching_task_eng/TaskElement.dart';

class SMEnglish extends Model{
  bool _smEIsLoaded = false;
  bool _smEIsPressed = false;
  int _smETotalTasks = 0;
  int _smECurrentTask = 0;
  int _smESolved=0;
  int _smETotalQuestions=0;
  String _smEButtonText = "Get Next";
  List<Map<TaskElementSME,TaskElementSME>> _smECards = new List<Map<TaskElementSME,TaskElementSME>>();
  List<int> _orderSME =[4,3,0,2,5,1];
  List<String> _explanationSME= ["","","","","",""];
  

  bool get smEIsLoaded => _smEIsLoaded;
  bool get smEIsPressed => _smEIsPressed;
  int get smETotalTasks => _smETotalTasks;
  int get smECurrentTask => _smECurrentTask;
  int get smESolved => _smESolved;
  int get smETotalQuestions => _smETotalQuestions;
  String get smEButtonText => _smEButtonText;
  List<Map<TaskElementSME,TaskElementSME>> get smEQuestionList => _smECards;
  List<int> get orderSME => _orderSME;
  List<String> get explanationSME => _explanationSME;

  void set smEIsLoaded(bool b){
    this._smEIsLoaded = b;
  }

  void set smEIsPressed(bool b){
    this._smEIsPressed = b;
  }

  void set smETotalTasks(int t){
    this._smETotalTasks = t;
  }

  void set smECurrentTask(int t){
    this._smECurrentTask = t;
  }

  void set smESolved(int t){
    this._smESolved = t;
  }

  void set smETotalQuestions(int t){
    this._smETotalQuestions = t;
  }

  void set smEButtonText(String s){
    this._smEButtonText = s;
  }

  void set smEQuestionList(List<Map<TaskElementSME,TaskElementSME>> sm){
    this._smECards = sm;
  }

  set orderSME(List<int> l){
    this._orderSME = l;
  }

   void setSMEQuestions(MainModel model, SMEList smeList) async {
    
    List<SME> qsList = new List<SME>();
    qsList = smeList.sms;
    // SME sm1 = new SME.fromParam(first: "A",last: "B",topicId: 1, taskId: 1, specificTaskId: 31);
    // SME sm2 = new SME.fromParam(first: "C",last: "D",topicId: 1, taskId: 1, specificTaskId: 32);
    // SME sm3 = new SME.fromParam(first: "E",last: "F",topicId: 1, taskId: 1, specificTaskId: 33);

    // qsList.add(sm1);
    // qsList.add(sm2);
    // qsList.add(sm3);
    // smc = new SMController();
    // //print("Topic :" +topic);
    // smc.getSMList(model.user.token, model.currentTopic.id).then((qsList) {
      // setState(() {
        model.smEIsLoaded = true;
        // _isLoaded = true;
        // timeController.reverse(
        //     from: timeController.value == 0 ? 1 : timeController.value);

        int jsonSetArrived = 1;
        // int jsonSetArrived = qsList.length ~/ 3;
        // model.smTotalTasks = jsonSetArrived;
        // model.smCurrentTask = 1;
        // model.smTotalQuestions = model.smTotalTasks * 3;
        //model.smESolved = 0;

        model.smEQuestionList = new List<Map<TaskElementSME, TaskElementSME>>();
        for (int i = 0; i < jsonSetArrived; i++) {
          // _options[i] = new Map<String, String>();
          model.smEQuestionList.add(new Map<TaskElementSME, TaskElementSME>());
        }

        int jsonNo = 0, index;
        qsList.forEach((qs) {
          index = (jsonNo ~/ 3);
          TaskElementSME first =
              TaskElementSME(sentence: qs.firstSegment, taskId: qs.taskId, specificTaskId: qs.specificTaskId);
          TaskElementSME last =
              TaskElementSME(sentence: qs.lastSegment, taskId: qs.taskId, specificTaskId: qs.specificTaskId);

          model.smEQuestionList.elementAt(index)[first] = last;
          //jsonNo++;
        });
    //   });
    // });
  }
}