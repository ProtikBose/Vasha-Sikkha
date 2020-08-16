import 'dart:math';

import 'package:Dimik/data/controller/fbw.dart';
import 'package:Dimik/data/controller/lb.dart';
import 'package:Dimik/data/controller/lw.dart';
import 'package:Dimik/data/controller/pictureword.dart';
import 'package:Dimik/data/controller/task.dart';
import 'package:Dimik/data/controller/tf.dart';
import 'package:Dimik/data/controller/topic.dart';
import 'package:Dimik/data/controller/wordpicture.dart';
import 'package:Dimik/models/arcade_item.dart';
import 'package:Dimik/models/fb_word.dart';
import 'package:Dimik/models/leaderboard.dart';
import 'package:Dimik/models/listening_item.dart';
import 'package:Dimik/models/pictureword.dart';
import 'package:Dimik/models/quiz_item.dart';
import 'package:Dimik/models/sentence_from_story.dart';
import 'package:Dimik/models/sm.dart';
import 'package:Dimik/models/task_history.dart';
import 'package:Dimik/models/tf.dart';
import 'package:Dimik/models/topic_task_state.dart';
import 'package:Dimik/models/user.dart';
import 'package:Dimik/models/wordpicture.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:Dimik/models/task.dart';
import 'package:Dimik/models/topic.dart';
import 'package:Dimik/databaseChange/jumbleSentence.dart';
import 'package:Dimik/models/jumbled_sentence.dart';
import 'package:Dimik/databaseChange/FBGapData.dart';
import 'package:Dimik/models/fb.dart';
import 'package:Dimik/databaseChange/mcqData.dart';
import 'package:Dimik/data/controller/memoryGame.dart';
import '../models/memorygame.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/widgets.dart';
import 'dart:async';
import 'package:Dimik/config.dart';
import '../models/sme.dart';

class MergedModel extends Model {
  List<Topic> _topics = [];
  final List<TopicTaskState> map = [];
  List<ArcadeItem> _arcade_items = [];
  List<Topic> _favs = [];
  List<TF> _truefalselist = [];
  List<SFS> _listsfs = [];
  List<PictureWord> _picturewordlist = [];
  List<WordPicture> _wordpicturelist = [];
  List<ListeningItem> _listeningitemlist = [];
  List<FB_Word> _listfbword = [];
  List<Task> _listmixtask = [];
  List<QuizItem> _quizlist = [];
  List<Task_History> _taskHistory = [];
  List<LB> _listlb = [];
  bool isPA = false;

  List<Task_History> get taskHistory => _taskHistory;

  bool _gotUser = false;
  bool _isLoading = false;
  bool _isPressed = false;
  bool successfulLogin = true;

  bool _isQuizActive = false;
  QuizItem _currentQuiz;
  int _current_quiz_tracker;

  int _current = 0;
  int _tasklen = 0;

  int get tasklen => _tasklen;
  void set tasklen(int value) {
    _tasklen = value;
  }

  bool _isTrueFalseLoading = false;
  bool _isFavLoading = false;
  bool _isPWLoading = false;
  bool _isWPLoading = false;
  bool _isLTLoading = false;
  bool _isLBLoading = false;
  bool _isSFSLoading = false;
  bool _isFBWLoading = false;
  bool _isQuizLoading = false;
  bool _isMixLoading = false;
  bool _isTopicGenerated = false;
  bool _changeToBangla = false;

  bool get isLBLoading => _isLBLoading;

  void set isLBLoading(bool value) {
    _isLBLoading = value;
  }

  bool get changeToBangla => _changeToBangla;

  bool get isTopicGenerated => _isTopicGenerated;

  void set changeToBangla(bool value) {
    _changeToBangla = value;
  }

  List<LB> get listlb => List.from(_listlb);

  void generateLeaderBoard() async {
    if (isLBLoading) {
      _listlb = await LBController().getTopicList(user.token);
      isLBLoading = false;
      notifyListeners();
    }
  }

  int get current => _current;
  bool get gotUser => _gotUser;
  void set gotUser(bool flag) {
    _gotUser = flag;
    notifyListeners();
  }

  void clearHistory() {
    _taskHistory.clear();
  }

  void addTaskHistory(Task_History th) {
    _taskHistory.add(th);
    print('task history added');
    notifyListeners();
  }

  void set isTopicGenerated(bool flag) {
    this._isTopicGenerated = flag;
  }

  void set current(int c) {
    this._current = c;
    notifyListeners();
  }

  TopicTaskState _currentState;
  Topic _currenttopic;

  int _trueFalseScore = 0;
  int _tfcorrect = 0;
  int _tfincorrect = 0;

  int _pwScore = 0;
  int _pwcorrect = 0;
  int _pwincorrect = 0;

  int _wpScore = 0;
  int _wpcorrect = 0;
  int _wpincorrect = 0;

  int _ltScore = 0;
  int _ltcorrect = 0;
  int _ltincorrect = 0;

  int _sfsScore = 0;
  int _sfscorrect = 0;
  int _sfsincorrect = 0;

  int _fbwScore = 0;
  int _fbwcorrect = 0;
  int _fbwincorrect = 0;

  User user;
  final List<String> halloffame = [
    'True False Master',
    'Cross Word Rookie',
    'WP Semi Pro'
  ];
  final List<String> Achievements = [
    'Fasted True False Solve at Level 1',
    'Fasted Crossword at Level 2',
    'Fasted MCQ Solve at Level 4',
    'Fasted Word to Picture at Level 3',
  ];

  void set currentTopic(Topic t) {
    _currenttopic = t;
  }

  void set currentState(TopicTaskState state) {
    _currentState = state;
    _currenttopic = state.topic;
  }

  void getLevel() async {
    int index = -1;
    int level = await TopicController().getLevel(_currenttopic.id, user.token);
    for (int i = 0; i < _topics.length; i++) {
      if (_topics[i].id == _currenttopic.id) {
        index = i;
      }
    }
    _topics[index].level = level;
    _isLoading = false;
    notifyListeners();
  }

  void change_fav_state(int index) {
    if (_topics[index].isLoved == 1) {
      _favs.remove(_topics[index]);
      _topics[index].isLoved = 0;
      notifyListeners();
      TopicController().postFavTopic(_topics[index], 0, user.token);
    } else {
      _favs.add(_topics[index]);
      _topics[index].isLoved = 1;
      notifyListeners();
      TopicController().postFavTopic(_topics[index], 1, user.token);
    }
  }

  void generateSFS() async {
    if (_isSFSLoading) {
      SFS temp = new SFS(
          imgLink: 'http://192.168.0.105:8000/images/topicImages/spiderman.png',
          options: [
            'Spiderman is flying',
            'Spiderman is flying',
            'Spiderman is flying',
            'Spiderman is flying',
            'Spiderman is flying'
          ],
          answers: [1, 3, 5],
          explanation: 'Data');
      await temp.downloadImage('temp');
      _listsfs.add(temp);
      _isSFSLoading = false;
      notifyListeners();
    }
  }

  void generateFBWord() async {
    if (_isFBWLoading) {
      FBWController fbwController = new FBWController();
      _listfbword = await fbwController.getFBList(user.token, _currenttopic.id);
    }
    _isFBWLoading = false;
    _tasklen = _listfbword.length;
    notifyListeners();
  }

  Future<WordPicture> downloadImages(WordPicture wp) async {
    //it may be possible to further optimize this
    print(wp.imgLinks.length);
    for (int i = 0; i < wp.imgLinks.length; i++) {
      String name = 'WP-Topic' +
          '-' +
          wp.topicId.toString() +
          '-' +
          (i + 1).toString() +
          '-' +
          (i + 1).toString();
      await wp.downloadImage(name, i);
    }
    return wp;
  }

  void getPercentage() async {
    int index = -1;
    double percentage =
        await TopicController().getPercentage(_currenttopic.id, user.token);
    for (int i = 0; i < _topics.length; i++) {
      if (_topics[i].id == _currenttopic.id) {
        index = i;
      }
    }
    _topics[index].progress = percentage.toInt();
    _isLoading = false;
    notifyListeners();
  }

  void generateMixTask() async {
    _listmixtask.clear();
    _isMixLoading = true;
    // _currentState.topic.id=1;
    if (_isMixLoading) {
      TaskController taskController = new TaskController();
      _listmixtask =
          await taskController.getTaskList(user.token, _currenttopic.id);
      for (int i = 0; i < _listmixtask.length; i++) {
        // if(_listmixtask[i].taskname == "MCQ"){
        //   print(_listmixtask[i].taskId.toString());
        //   print(_listmixtask[i].specificTaskId.toString());
        // }
        if (_listmixtask[i].taskname == "PW") {
          PictureWord pw = _listmixtask[i];
          await pw.downloadImage(Random().nextInt(1000000).toString());
          _listmixtask[i] = pw;
        } else if (_listmixtask[i].taskname == "WP") {
          WordPicture wordPicture = _listmixtask[i];
          _listmixtask[i] = await downloadImages(wordPicture);
        } else if (_listmixtask[i].taskname == "Memory Game") {
          MG mg = _listmixtask[i];
          print("IN MERGED MODEL: " +
              _listmixtask[i].taskId.toString() +
              "," +
              _listmixtask[i].specificTaskId.toString());
          await mg.downloadImage("mg" + i.toString());
          _listmixtask[i] = mg;
        }
      }
    }
    _isMixLoading = false;
    _tasklen = _listmixtask.length;
    mix_active = true;
    notifyListeners();
  }

  bool mix_active = false;

  void postVerdict(Task task, int verdict) async {
    if (mix_active) {
      await TaskController()
          .postVerdict(_currenttopic, task, verdict, user.token);
    }
  }

  void generateArcadeList() {
    _arcade_items.clear();
    _arcade_items.add(new ArcadeItem(
      game: 'True False',
      c1: Color.fromRGBO(116, 235, 213, 1),
      c2: Color.fromRGBO(172, 182, 229, 1),
    ));
    _arcade_items.add(new ArcadeItem(
      game: 'Word to Picture',
      c1: Color.fromRGBO(115, 3, 192, 1),
      c2: Color.fromRGBO(253, 239, 259, 1),
    ));
    _arcade_items.add(new ArcadeItem(
      game: 'Picture to Word',
      c1: Color.fromRGBO(102, 125, 182, 1),
      c2: Color.fromRGBO(0, 130, 200, 1),
    ));
    _arcade_items.add(new ArcadeItem(
      game: 'Listen to Word',
      c1: Color.fromRGBO(225, 238, 195, 1),
      c2: Color.fromRGBO(240, 80, 83, 1),
    ));
    _arcade_items.add(new ArcadeItem(
      game: 'Fill in the Blanks Word',
      c1: Color.fromRGBO(34, 193, 195, 1),
      c2: Color.fromRGBO(253, 187, 45, 1),
    ));
  }

  void generateTopics() async {
    _topics.clear();
    if (_isLoading) {
      TopicController tController = new TopicController();
      List<Topic> list = await tController.getTopicList(user.token);
      _topics = list;
      await generateFavs();
      await generateTasks();
      generateArcadeList();
      print('Fav leng' + _favs.length.toString());
      //fix api
      for (int i = 0; i < _favs.length; i++) {
        for (int j = 0; j < _topics.length; j++) {
          if (_favs[i].id == _topics[j].id) {
            _favs[i] = _topics[j];
          }
        }
      }
      _isLoading = false;
      notifyListeners();
    }
  }

  List<ArcadeItem> get listarcadeitem => List.from(_arcade_items);

  void generateFavs() async {
    _favs.clear();
    if (_isFavLoading) {
      TopicController tController = new TopicController();
      List<Topic> favList = await tController.getFavouriteTopics(user.token);
      _favs = favList;
      _isFavLoading = false;
      notifyListeners();
    }
  }

  List<Topic> get favs => List.from(_favs);

  bool get isFavLoading => _isFavLoading;

  void generateTasks() {
    map.clear();
    for (int i = 0; i < _topics.length; i++) {
      final List<Task> tasks = [];
      //options to add specific task or mix task
      //get tasks for each topic using async and await call from API
      Task t1 = Task('Mix Task', 1, 1);
      tasks.add(t1);
      TopicTaskState state = new TopicTaskState(_topics[i], tasks);
      map.add(state);
    }
    /*
    Task t3 = Task(name: 'Kid\'s Box');
    Task t4 = Task(name: 'Picture to Word');
    Task t5 = Task(name: 'Listen to Word');
    Task t6 = Task(name: 'Synonym Antonym Matching');
    Task t7 = Task(name: 'Sentence Matching');
    */
    /*
      Task t1 = Task(name: 'Sentence Matching');
    Task t2 = Task(name: 'Sentence Matching English');
    Task t3 = Task(name: 'Jumbled Sentence');
    Task t4 = Task(name: 'Fill in The Gaps');
    Task t5 = Task(name: 'Multiple Choice Question'); 
    Task t6= Task(name: 'Memory Game');

    tasks.add(t1);
    tasks.add(t2);
    tasks.add(t3);
    tasks.add(t4);
    tasks.add(t5);
    tasks.add(t6);
    */
  }

  void increment() {
    int index = map.indexOf(_currentState);
    map[index].incrementTaskCount();
    _currentState = map[index];
    notifyListeners();
  }

  void normalize() {
    int index = map.indexOf(_currentState);
    _topics.removeAt(index);
    map.removeAt(index);
    notifyListeners();
  }

  TopicTaskState get currentState => _currentState;

  int get current_task_length => _currentState.task_len;
  int get current_task_num => _currentState.current_task_num;

  String getTaskName(int index) {
    return map[index].currentTask();
  }

  TopicTaskState getTopicStatet(Topic t) {
    return map[_topics.indexOf(t)];
  }

  int task_topic(Topic t) {
    int index = _topics.indexOf(t);
    return map[index].task_len;
  }

  void generateTrueFalse() async {
    if (_isTrueFalseLoading) {
      TFController tfController = new TFController();
      _truefalselist =
          await tfController.getTFList(user.token, _currenttopic.id);
    }
    _tasklen = _truefalselist.length;
    print(_tasklen);
    _isTrueFalseLoading = false;
    notifyListeners();
  }

  void generateListeningItems() async {
    if (_isLTLoading) {
      LWController lwController = new LWController();
      _listeningitemlist =
          await lwController.getLWList(user.token, _currenttopic.id);
    }
    _tasklen = _listeningitemlist.length;
    _isLTLoading = false;
    notifyListeners();
  }

  bool get isMixLoading => _isMixLoading;

  void set mixloading(bool value) {
    _isMixLoading = value;
  }

  List<Task> get mixtasks {
    return List.from(_listmixtask);
  }

  void generatePicturetoWord() async {
    if (_isPWLoading) {
      PWController pwController = new PWController();
      _picturewordlist =
          await pwController.getPWList(user.token, currentTopic.id);
    }
    _tasklen = _picturewordlist.length;
    _isPWLoading = false;
    notifyListeners();
  }

  void generateWordtoPicture() async {
    if (_isWPLoading) {
      WPController wpController = new WPController();
      _wordpicturelist =
          await wpController.getWPList(user.token, currentTopic.id);
    }
    _tasklen = _wordpicturelist.length > 10 ? 10 : _wordpicturelist.length;
    _isWPLoading = false;
    notifyListeners();
  }

  void logOut() {
    _gotUser = false;
    _isTopicGenerated = false;
    _isLoading = true;
    _isTrueFalseLoading = true;
    _isPWLoading = true;
    _isWPLoading = true;
    _isLTLoading = true;
    _isFavLoading = true;
    _isMixLoading = true;
  }

  @override
  void addListener(listener) {
    super.addListener(listener);
    _isTopicGenerated = false;
    _isLoading = true;
    _isTrueFalseLoading = true;
    _isPWLoading = true;
    _isWPLoading = true;
    _isLTLoading = true;
    _isFavLoading = true;
    _isMixLoading = true;
  }

  bool get isLoading => _isLoading;
  bool get isPressed => _isPressed;
  void set isLoading(bool f) {
    _isLoading = f;
  }

  Topic get currentTopic => _currenttopic;
}

class TopicModel extends MergedModel {
  List<Topic> get AllTopic {
    return List.from(_topics);
  }
}

class UserModel extends MergedModel {
  User get currentUser {
    return user;
  }

  void set username(String name) {
    user.username = (name);
  }

  void set email(String email) {
    user.email = (email);
  }
}

class TruefalseModel extends MergedModel {
  void incrementTFScore() {
    _trueFalseScore += 10;
    _tfcorrect++;
  }

  void decrementTFScore() {
    _tfincorrect++;
  }

  void set scoreTF(int s) {
    _trueFalseScore = s;
  }

  void set correctTF(int s) {
    _tfcorrect = s;
  }

  void set tfloading(bool t) {
    _isTrueFalseLoading = t;
    notifyListeners();
  }

  void set incorrectTF(int s) {
    _tfincorrect = s;
  }

  int get trueFalseScore => _trueFalseScore;
  int get tfcorrect => _tfcorrect;
  int get tfincorrect => _tfincorrect;

  bool get isTFLoading => _isTrueFalseLoading;

  List<TF> get truefalselist {
    return List.from(_truefalselist);
  }
}

class PictureWordModel extends MergedModel {
  void incrementPWScore() {
    _pwScore += 10;
    _pwcorrect++;
  }

  void decrementPWScore() {
    _pwincorrect++;
  }

  void set scorePW(int s) {
    _pwScore = s;
  }

  void set correctPW(int s) {
    _pwcorrect = s;
  }

  void set pwloading(bool t) {
    _isPWLoading = t;
    notifyListeners();
  }

  void set incorrectPW(int s) {
    _pwincorrect = s;
  }

  int get pwScore => _pwScore;
  int get pwcorrect => _pwcorrect;
  int get pwincorrect => _pwincorrect;

  bool get isPWLoading => _isPWLoading;
  List<PictureWord> get picturewordlist {
    return List.from(_picturewordlist);
  }
}

class SFSModel extends MergedModel {
  void incrementSFSScore() {
    _sfsScore += 10;
    _sfscorrect++;
  }

  void decrementSFSScore() {
    _sfsincorrect++;
  }

  void set scoreSFS(int s) {
    _sfsScore = s;
  }

  void set correctSFS(int s) {
    _sfscorrect = s;
  }

  void set sfsloading(bool t) {
    _isSFSLoading = t;
    notifyListeners();
  }

  void set incorrectSFS(int s) {
    _sfsincorrect = s;
  }

  int get sfsScore => _sfsScore;
  int get sfscorrect => _sfscorrect;
  int get sfsincorrect => _sfsincorrect;

  bool get isSFSLoading => _isSFSLoading;
  List<SFS> get sfslist {
    return List.from(_listsfs);
  }
}

class FBwordModel extends MergedModel {
  void incrementFBWScore() {
    _fbwScore += 10;
    _fbwcorrect++;
  }

  void decrementFBWScore() {
    //_fbwincorrect++;
    _fbwScore += -2;
  }

  void set scoreFBW(int s) {
    _fbwScore = s;
  }

  void set correctFBW(int s) {
    _fbwcorrect = s;
  }

  void set fbwloading(bool t) {
    _isFBWLoading = t;
    notifyListeners();
  }

  void set incorrectFBW(int s) {
    _fbwincorrect = s;
  }

  int get fbwScore => _fbwScore;
  int get fbwcorrect => _fbwcorrect;
  int get fbwincorrect => _fbwincorrect;

  bool get isFBWLoading => _isFBWLoading;
  List<FB_Word> get fbwordlist {
    return List.from(_listfbword);
  }
}

class WordPictureModel extends MergedModel {
  void incrementWPScore() {
    _wpScore += 10;
    _wpcorrect++;
  }

  void decrementWPScore() {
    _wpincorrect++;
  }

  void set scoreWP(int s) {
    _wpScore = s;
  }

  void set correctWP(int s) {
    _wpcorrect = s;
  }

  void set wploading(bool t) {
    _isWPLoading = t;
    notifyListeners();
  }

  void set incorrectWP(int s) {
    _wpincorrect = s;
  }

  int get wpScore => _wpScore;
  int get wpcorrect => _wpcorrect;
  int get wpincorrect => _wpincorrect;

  bool get isWPLoading => _isWPLoading;
  List<WordPicture> get wordpicturelist {
    return List.from(_wordpicturelist);
  }
}

class ListeningTaskModel extends MergedModel {
  void incrementLTScore() {
    _ltScore += 10;
    _ltcorrect++;
  }

  void decrementLTScore() {
    _ltincorrect++;
  }

  void set scoreLT(int s) {
    _ltScore = s;
  }

  void set correctLT(int s) {
    _ltcorrect = s;
  }

  void set ltloading(bool t) {
    _isLTLoading = t;
    notifyListeners();
  }

  void set incorrectLT(int s) {
    _ltincorrect = s;
  }

  int get ltScore => _ltScore;
  int get ltcorrect => _ltcorrect;
  int get ltincorrect => _ltincorrect;

  bool get isLTLoading => _isLTLoading;
  List<ListeningItem> get ltitemlist {
    return List.from(_listeningitemlist);
  }
}

class QuizModel extends MergedModel {
  bool get isQuizActive => _isQuizActive;
  QuizItem get currentQuizItem => _currentQuiz;
  int get current_quiz_tracker => _current_quiz_tracker;

  void set current_quiz_tracker(int t) {
    _current_quiz_tracker = t;
  }

  void set isQuizActive(bool t) {
    _isQuizActive = t;
  }

  void set currentQuizItem(QuizItem q) {
    _currentQuiz = q;
  }

  void set quizloading(bool t) {
    _isWPLoading = t;
    notifyListeners();
  }

  bool get isQuizLoading => _isQuizLoading;

  List<QuizItem> get quizlist {
    return List.from(_quizlist);
  }
}

class JumbledModel extends Model {
  JumbledList _jumbledSentences;
  bool _isLoaded = false;
  String _topic;
  int _solved = 0;
  List<jumbleSentence> _val;
  int _jumbledtotalScore = 0;
  int _jumbledcorrect = 0;
  bool _jumbledHistory = false;
  List<jumbleSentence> _jumbledSolution;
  List<jumbleSentence> _jumbledTempStore;

  JumbledList get getJumbledSentences => _jumbledSentences;
  bool get getIsLoaded => _isLoaded;
  String get getTopicID => _topic;
  int get getSolved => _solved;
  List<jumbleSentence> get getVal => _val;
  int get jumbledtotalScore => _jumbledtotalScore;
  int get jumbledcorrect => _jumbledcorrect;
  bool get jumbledHistory => _jumbledHistory;
  List<jumbleSentence> get jumbledSolution => _jumbledSolution;
  List<jumbleSentence> get jumbledTempStore => _jumbledTempStore;

  void set setJumbledSentences(List<jumbleSentence> jl) {
    this._val = List.from(jl);
  }

  void set setIsLoaded(bool l) {
    this._isLoaded = l;
  }

  void set setTopic(String t) {
    this._topic = t;
  }

  void set setSolved(int s) {
    this._solved = s;
  }

  void set setVal(List<jumbleSentence> js) {
    this._val = js;
  }

  void addToVal(jumbleSentence js) {
    this._val.add(js);
  }

  void set jumbledtotalScore(int totalScore) {
    this._jumbledtotalScore = totalScore;
  }

  void set jumbledcorrect(int correct) {
    this._jumbledcorrect = correct;
  }

  void set jumbledHistory(bool flag) {
    this._jumbledHistory = flag;
  }

  void set jumbledSolution(List<jumbleSentence> fb) {
    this._jumbledSolution = fb;
  }

  void set jumbledTempStore(List<jumbleSentence> fb) {
    this._jumbledTempStore = fb;
  }
}

class FillInTheGaps extends Model {
  FBList _fbList;
  bool _isFBLoaded = false;
  String _fbtopic;
  int _fbsolved = 0;
  List<FbGap> _fbval;
  int _fbtotalScore = 0;
  int _fbcorrect = 0;
  bool _fbHistory = false;
  List<FbGap> _fbSolution;
  List<FbGap> _fbTempStore;
  List<String> _fbTempSolution = new List();

  FBList get getFillBlanks => _fbList;
  bool get getFBIsLoaded => _isFBLoaded;
  String get getFBTopicID => _fbtopic;
  int get getFBSolved => _fbsolved;
  List<FbGap> get getFBVal => _fbval;
  int get fbtotalScore => _fbtotalScore;
  int get fbcorrect => _fbcorrect;
  bool get fbHistory => _fbHistory;
  List<FbGap> get fbSolution => _fbSolution;
  List<FbGap> get fbTempStore => _fbTempStore;
  List<String> get fbTempSolution => _fbTempSolution;

  void set setFBFillBlanks(List<FbGap> fb) {
    this._fbval = List.from(fb);
  }

  void set setFBIsLoaded(bool l) {
    this._isFBLoaded = l;
  }

  void set setFBTopic(String t) {
    this._fbtopic = t;
  }

  void set setFBSolved(int s) {
    this._fbsolved = s;
  }

  void set setFBVal(List<FbGap> fb) {
    this._fbval = fb;
  }

  void addFBToVal(FbGap fb) {
    this._fbval.add(fb);
  }

  void set fbtotalScore(int totalScore) {
    this._fbtotalScore = totalScore;
  }

  void set fbcorrect(int correct) {
    this._fbcorrect = correct;
  }

  void set fbHistory(bool flag) {
    this._fbHistory = flag;
  }

  void set fbSolution(List<FbGap> fb) {
    this._fbSolution = fb;
  }

  void set fbTempStore(List<FbGap> fb) {
    this._fbTempStore = fb;
  }

  void set fbTempSolution(List<String> val) {
    this._fbTempSolution = val;
  }

  void fbsaveSolution(String solutions) {
    _fbTempSolution.add(solutions);
  }
}

class MCQScoped extends Model {
  MCQDataBase _mcqList;
  bool _ismcqLoaded = false;
  String _mcqtopic;
  int _mcqsolved = 0;
  List<MCQDataBase> _mcqval;
  int _mcqtotalScore = 0;
  int _mcqcorrect = 0;
  bool _mcqHistory = false;
  List<MCQDataBase> _mcqSolution;
  List<MCQDataBase> _mcqTempStore;
  List<String> _mcqTempSolution = new List();

  MCQDataBase get getMCQ => _mcqList;
  bool get getMCQIsLoaded => _ismcqLoaded;
  String get getMCQTopicID => _mcqtopic;
  int get getMCQSolved => _mcqsolved;
  List<MCQDataBase> get getMCQVal => _mcqval;
  int get mcqtotalScore => _mcqtotalScore;
  int get mcqcorrect => _mcqcorrect;
  bool get mcqHistory => _mcqHistory;
  List<MCQDataBase> get mcqSolution => _mcqSolution;
  List<MCQDataBase> get mcqTempStore => _mcqTempStore;
  List<String> get mcqTempSolution => _mcqTempSolution;

  void set setMCQ(List<MCQDataBase> mcq) {
    this._mcqval = List.from(mcq);
  }

  void set setMCQIsLoaded(bool l) {
    this._ismcqLoaded = l;
  }

  void set setmcqTopic(String t) {
    this._mcqtopic = t;
  }

  void set setMCQSolved(int s) {
    this._mcqsolved = s;
  }

  void set setMCQVal(List<MCQDataBase> mcq) {
    this._mcqval = mcq;
  }

  void addMCQToVal(MCQDataBase mcq) {
    this._mcqval.add(mcq);
  }

  void set mcqtotalScore(int totalScore) {
    this._mcqtotalScore = totalScore;
  }

  void set mcqcorrect(int correct) {
    this._mcqcorrect = correct;
  }

  void set fbHistory(bool flag) {
    this._mcqHistory = flag;
  }

  void set mcqSolution(List<MCQDataBase> fb) {
    this._mcqSolution = fb;
  }

  void set mcqTempStore(List<MCQDataBase> fb) {
    this._mcqTempStore = fb;
  }

  void set mcqTempSolution(List<String> val) {
    this._mcqTempSolution = val;
  }

  void mcqsaveSolution(String solutions) {
    _mcqTempSolution.add(solutions);
  }
}

class MemoryGameModel extends Model {
  String topic;
  int _mgTotalTasks = 0;
  int _mgCurrentTask = 0;
  //int _totalMGs = 0;

  int _mgSolved = 0;
  int _currSolvedMG = 0;
  int _mgTotalQuestions = 0;
  bool _mgIsLoaded = true;
  bool _mgIsPressed = false;
  List<MG> _mgQuestionList = new List<MG>();
  List<bool> _flip;
  List<GlobalKey<FlipCardState>> _mgFlipKey;

  bool get mgIsLoaded => _mgIsLoaded;
  List<MG> get mgQuestionList => _mgQuestionList;
  List<GlobalKey<FlipCardState>> get mgFlipKey => _mgFlipKey;
  bool get mgIsPresed => _mgIsPressed;
  int get mgCurrentTask => _mgCurrentTask;
  int get mgTotalTask => _mgTotalTasks;
  int get totalMGs => totalMGs;
  int get solvedMG => _mgSolved;
  int get currSolvedMG => _currSolvedMG;
  int get totalQuestionsMG => _mgTotalQuestions;

  set totalQuestionsMG(int t) {
    this._mgTotalQuestions = t;
  }

  set solvedMG(int t) {
    this._mgSolved = t;
  }

  set currSolvedMG(int t) {
    this._currSolvedMG = t;
  }

  // set totalMGs(int t){
  //   this._totalMGs = t;
  // }

  void set mgIsLoaded(bool loaded) {
    this._mgIsLoaded = loaded;
  }

  void set mgTotalTask(int loaded) {
    this._mgTotalTasks = loaded;
  }

  void set mgCurrentTask(int loaded) {
    this._mgCurrentTask = loaded;
  }

  void set mgQuestionList(List<MG> qs) {
    this._mgQuestionList = qs;
  }

  void set mgFlipKey(List<GlobalKey<FlipCardState>> fk) {
    this._mgFlipKey = fk;
  }

  void set mgIsPressed(bool b) {
    this._mgIsPressed = b;
  }

  void mgIncrementCurrent() {
    _mgCurrentTask++;
    // notifyListeners();
  }

  void popMGQuestionList() {
    _mgQuestionList.removeAt(0);
    //print("in pop"+ _mgQuestionList.elementAt(0).imageLink);
    //notifyListeners();
  }

  void generateMemoryGame() async {
    MG mg1 = new MG.fromParam(
        link: "assets/img/spiderman.jpeg",
        ops: ["cat", "dog", "mat", "batman", "Bangladesh"],
        correct: ["mat", "Bangladesh"],
        taskId: 1,
        specificTaskId: 2);
    MG mg2 = new MG.fromParam(
        link: "assets/img/spiderman.jpeg",
        ops: ["cat", "dog", "mat", "batman", "Bangladesh"],
        correct: ["mat", "Bangladesh"],
        taskId: 1,
        specificTaskId: 2);
    // print(mg1.imageLink);
    // print(mg1.options);
    // print(mg1.correctAnswers);
    _mgQuestionList.add(mg1);
    _mgQuestionList.add(mg2);
    //  print(_mgQuestionList.elementAt(0).imageLink);
    // if (_mgIsLoaded) {
    //   MGController mgController = new MGController();
    //   _mgQuestionList = await mgController.getPWList(TOKEN, 1);
    //   print(_mgQuestionList);
    // }
    _mgIsLoaded = false;
  }

  void mgCardMixTask(MG mg) {
    _mgTotalTasks = 1;
    mgQuestionList.add(mg);
    initListsMG();
  }

  // @override
  // void addListener(listener) {
  //   super.addListener(listener);
  void initListsMG() {
    _flip = new List<bool>(_mgTotalTasks);
    _mgFlipKey = new List<GlobalKey<FlipCardState>>(_mgTotalTasks);
    for (int i = 0; i < _mgTotalTasks; i++) {
      _mgFlipKey[i] = GlobalKey<FlipCardState>();
      _flip[i] = true;
    }
  }

  void mgFlipCard(int index) async {
    print("In mgFlipCard. Index: " + index.toString());
    Timer(Duration(milliseconds: 5000), () {
      if (_flip[index] == true) {
        _mgFlipKey.elementAt(index).currentState.toggleCard();
        //notifyListeners();
        _flip[index] = false;
      }
    });
  }
}
