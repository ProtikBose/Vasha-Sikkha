// import 'package:Dimik/data/controller/jumbled_sentence.dart';
// import 'package:Dimik/databaseChange/jumbleSentence.dart';
// import 'package:Dimik/models/jumbled_sentence.dart';
// import 'package:scoped_model/scoped_model.dart';
// import '../config.dart';
// import '../models/jumbled_sentence.dart';

// class JumbledModel extends Model {
//   JumbledList _jumbledSentences;
//   bool _isLoaded = false;
//   String _topic;
//   int _solved = 0;
//   List<jumbleSentence> _val;

//   JumbledList get getJumbledSentences => _jumbledSentences;
//   bool get getIsLoaded => _isLoaded;
//   String get getTopicID => _topic;
//   int get getSolved => _solved;
//   List<jumbleSentence> get getJSVal => _val; 

//   void set setJumbledSentences(List<jumbleSentence> jl) {
//     this._val = List.from(jl);
//   }

//   void set setIsLoaded(bool l) {
//     this._isLoaded = l;
//   }

//   void set setTopic(String t) {
//     this._topic = t;
//   }

//   void set setSolved(int s) {
//     this._solved = s;
//   }

//   void set setVal(List<jumbleSentence> js) {
//     this._val = js;
//   }

//   void addToVal(jumbleSentence js){
//     this._val.add(js);
//   }
// }
