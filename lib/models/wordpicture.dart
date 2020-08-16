import 'package:Dimik/models/task.dart';
import 'package:Dimik/utils/downloader.dart';
import 'package:Dimik/config.dart';

class WordPictureList {
  List<WordPicture> _wpList;

  WordPictureList._({List<WordPicture> wpList}) : _wpList = wpList;

  factory WordPictureList.fromJson(List<dynamic> parsedJson) {
    List<WordPicture> wpList = new List<WordPicture>();
    wpList = parsedJson.map((i) => WordPicture.fromJson(i)).toList();

    return new WordPictureList._(wpList: wpList);
  }

  List<WordPicture> get wpList => _wpList;

  void setTopicId(int topicId) {
    for (int i = 0; i < wpList.length; i++) wpList[i].topicId = topicId;
  }

  void downloadImages() async {
    for (int i = 0; i < wpList.length; i++) {
      //it may be possible to further optimize this
      for (int j = 0; j < wpList[i].imgLinks.length; j++) {
        String name = 'WP-Topic' +
            '-' +
            wpList[i].topicId.toString() +
            '-' +
            (i + 1).toString() +
            '-' +
            (j + 1).toString();
        await wpList[i].downloadImage(name, j);
      }
    }
  }
}

class WordPicture extends Task {
  int _id;
  String _word;
  List<String> _imgLinks;
  int _correctOption;
  String _explanation;
  int _topicId;

  WordPicture._(
      {String taskname,
      int taskId,
      int specificTaskId,
      String word,
      List<String> imgLinks,
      String correctImage,
      String explanation,
      int correctOption})
      : _word = word,
        _imgLinks = imgLinks,
        _correctOption = correctOption,
        _explanation = explanation,
        super(taskname, taskId, specificTaskId);

  factory WordPicture.fromJson(Map<String, dynamic> json) {
    var temp = json['Options'];
    List<String> imageLinks = new List<String>.from(temp);
    return new WordPicture._(
        taskname: json['Task_Name'],
        taskId: json['task_id'],
        specificTaskId: json['specific_task_id'],
        word: json['Word'],
        imgLinks: imageLinks,
        correctOption: json['Answer'],
        explanation: json['Meaning']);
  }

  String printOptions() {
    String res = '';
    for (int i = 0; i < _imgLinks.length; i++) res += _imgLinks[i] + ' ';
    return res;
  }

  String toString() {
    String res = '';
    res += 'Word: ' + word + '\t';
    res += 'Pictures: ' + _concatenateListElements(imgLinks) + '\t';
    res += explanation;
    return res;
  }

  void downloadImage(String name, int index) async {
    Downloader downloader = new Downloader();
    _imgLinks[index] = IMAGE_URL + _imgLinks[index];
    String filename = name + index.toString() + '.jpg'; //extension may change
    //String img;
    imgLinks[index] = await downloader.downloadImg(imgLinks[index], filename);
    print(imgLinks[index]);
  }

  int get id => _id;

  List<String> get imgLinks => _imgLinks;

  int get correctOption {
    print(_correctOption);
    return _correctOption;
  }

  String get word => _word;

  String get explanation => _explanation;

  int get topicId => _topicId;

    @override
  String get taskname{
    return "WP";
  }

  set id(int id) {
    this._id = id;
  }

  set word(String word) {
    this._word = word;
  }

  set imgLinks(List<String> imgLinks) {
    this._imgLinks = imgLinks;
  }

  set explanation(String explanation) {
    this._explanation = explanation;
  }

  set topicId(int topicId) {
    this._topicId = topicId;
  }

  String _concatenateListElements(List<String> list) {
    if (list == null) return '';
    String res = '';
    for (int i = 0; i < list.length; i++) {
      if (i != list.length - 1)
        res = res + list[i] + '#';
      else
        res = res + list[i];
    }
    return res;
  }

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (id != null) {
      map['Id'] = _id;
    }
    map['Word'] = _word;
    map['Image_Options'] = _concatenateListElements(imgLinks);
    map['Explanation'] = _explanation;
    map['Topic_Id'] = _topicId;
    return map;
  }

  WordPicture.fromMapObject(Map<String, dynamic> map) : super.empty() {
    this._id = map['Id'];
    this.taskname = map["Task_Name"];
    this.taskId = map['task_id'];
    this.specificTaskId = map['specific_task_id'];
    this._word = map['Word'];
    this._imgLinks = map['Image_Options'].split('#');
    this._explanation = map['Meaning'];
  }
}
