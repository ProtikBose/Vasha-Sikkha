import 'package:Dimik/models/task.dart';

import 'task.dart';

class FBWList {
  List<FB_Word> _fbs;

  FBWList._({List<FB_Word> fbs}) : _fbs = fbs;

  factory FBWList.fromJson(List<dynamic> parsedJson) {
    List<FB_Word> fbs = new List<FB_Word>();
    fbs = parsedJson.map((i) => FB_Word.fromJson(i)).toList();

    return new FBWList._(fbs: fbs);
  }

  void setTopicId(int topicId) {
    for (int i = 0; i < fbs.length; i++) {
      fbs[i].topicId = topicId;
    }
  }

  List<FB_Word> get fbs => _fbs;
}

class FB_Word extends Task {
  String _incompleteWord;
  List<String> _options;
  List<String> _answer;
  String _explanation;

  FB_Word._(
      {String taskname,
      int taskId,
      int specificTaskId,
      String incompleteWord,
      List<String> options,
      List<String> answer,
      String explanation})
      : super(taskname, taskId, specificTaskId) {
    this._incompleteWord = incompleteWord;
    this._options = options;
    this._answer = answer;
    this._explanation = explanation;
  }

  factory FB_Word.fromJson(Map<String, dynamic> json) {
    var temp = json['Options'];
    var temp2 = json['Answers'];
    List<String> options = new List<String>.from(temp);
    List<String> answers = new List<String>.from(temp2);

    FB_Word fb_word = new FB_Word._(
        taskname: json["Task_Name"],
        taskId: json["task_id"],
        incompleteWord: json['incompleteWord'],
        specificTaskId: json["specific_task_id"],
        options: options,
        answer: answers,
        explanation: json['Explanation']);
    return fb_word;
  }

  String get incompleteWord => _incompleteWord;
  List<String> get options => _options;
  List<String> get answer => _answer;
  String get explanation => _explanation;
    @override
  String get taskname{
    return "FBW";
  }
}
