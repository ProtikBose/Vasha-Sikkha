import 'dart:async';
import 'dart:io' as io;

class MCQDataBase {
  String question;
  List<String> option;
  List<String> correctAns;
  int task_id;
  int specific_id;
  String explanation;

  MCQDataBase(this.question, this.option, this.correctAns,this.task_id,this.specific_id,this.explanation);

  set getQuestion(String str){
    this.question=str;
  }

  int get taskID {
    return task_id;
  }

  set taskId(int id){
    this.task_id=id;
  }

  int get specifiTtaskID {
    return specific_id;
  }

  set specificTaskId(int id){
    this.specific_id=id;
  }

   String get explanationString {
    return explanation;
  }

  set explanationString(String id){
    this.explanation=id;
  }

  String get getQuestion {
    //String str=question;
    return question;
  }

  set setOption(List<String>list){
    this.option=list;
  }

  List<String> get getOption {
    return option;
  }

  set setCorrect(List<String>list){
    this.correctAns=list;
  }

  List<String> get getCorrect {
    return correctAns;
  }

  
}
