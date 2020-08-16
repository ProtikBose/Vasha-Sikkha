import 'dart:async';
import 'dart:io' as io;

class jumbleSentence {
  String question;
  List<String> questionPart;
  List<String> correctAnsPart;
  String correctSentence;
  int task_id;
  int specific_id;
  //String explanation;

  jumbleSentence(this.question, this.questionPart, this.correctSentence,this.correctAnsPart,this.task_id,this.specific_id/*,this.explanation*/);

  set getQuestion(String str){
    this.question=str;
  }

  String get getQuestion {
    //String str=question;
    return question;
  }

  set setQuestionPart(List<String>list){
    this.questionPart=list;
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

  //  String get explanationString {
  //   return explanation;
  // }

  // set explanationString(String id){
  //   this.explanation=id;
  // }

  List<String> get getQuestionPart {
    return questionPart;
  }

  set setCorrect(List<String>list){
    this.correctAnsPart=list;
  }

  List<String> get getCorrect {
    return correctAnsPart;
  }

  set setCorrectSentence(String str){
    this.correctSentence=str;
  }

  String get getCorrectSentence {
    //String str=question;
    return correctSentence;
  }

  
}
