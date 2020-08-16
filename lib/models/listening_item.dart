import 'package:Dimik/models/task.dart';

class LWList{
    List<ListeningItem> _lws;

  LWList._({List<ListeningItem>lws}):
  _lws=lws;

  factory LWList.fromJson(List<dynamic> parsedJson) {

    List<ListeningItem> lws = new List<ListeningItem>();
    lws = parsedJson.map((i)=>ListeningItem.fromJson(i)).toList();

    return new LWList._(
      lws: lws
    );
  }

  List<ListeningItem> get lws => _lws;

}

class ListeningItem extends Task {
  int _id;
  List<String> _options;
  String _correct;
  String _explanation;
  String _topicId;

  ListeningItem._({String taskname,int taskId,int specificTaskId,int id,List<String>options, String correct,String explanation}):
  _id = id,
  _options = options,
  _correct = correct,
  _explanation = explanation,
  super(taskname,taskId,specificTaskId);

  factory ListeningItem.fromJson(Map<String,dynamic>json)
  { 
    print(json.toString());
    var temp= json['options'];
    List<String>optionList= new List<String>.from(temp);

    var temp1,temp2;
    if(json.containsKey("Task_Name")==false)
      temp1="Listening Game";
    else
      temp1=json['Task_Name'];

    if(json.containsKey("Explanation")==false)
      temp2="Idiot";
    else
      temp2=json['Explanation'];
    /*
    print(temp1.runtimeType);
    if (temp1==null)
    {
        temp1='Listening Word';
        print("One piece");
    }
      
  */
    return new ListeningItem._(
      taskname : temp1,
      taskId : json['task_id'],
      specificTaskId : json['specific_task_id'],
      options : optionList,
      correct : json['Answer'],
      explanation : temp2
      
    );
  }
  
  //getter
  int get id => _id;
  
  List<String> get options => _options;
  
  String get correct => _correct;
  
  String get explanation => _explanation;

      @override
  String get taskname{
    return "LW";
  }

  //Setter
  set id(int id)
  {
      _id = id;
  }

  set options(List<String>options)
  {
      _options = options;
  }
  
  set correct(String correct)
  {
      _correct = correct;
  }

  set explanation(String explanation)
  {
      _explanation = explanation;
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

  Map<String, dynamic> toMap() {

    var map = Map<String, dynamic>();
    if (id != null) {
      map['Id'] = id;
    }
    map['Options'] = _concatenateListElements(options);
    map['Answer'] = correct;
    //map['AnswerCount'] = answerCount;
    map['Explanation'] = explanation;
    //map['Topic_Id']=_topicId;
    
    return map;
  }
  
  ListeningItem.fromMapObject(Map<String, dynamic> map):super.empty() {
    this._id = map['Id'];
    //this.answerCount = map['AnswerCount'];
    
    this._options= map['Options'].split('#');
    this._correct = map['Answers'].split('#');
    this._explanation = map['Explanation'];
    //this._topicId = map['Topic_Id'];
  }
  /*
  ListeningItem(String taskname, int taskId, int specificTaskId,
      List<String> items, int correct)
      : super(taskname, taskId, specificTaskId) {
    this._options = items;
    this._correct = correct;
  }
  */
}
