import '../utils/downloader.dart';
import 'package:Dimik/config.dart';

class TopicList {
  List<Topic> topics;

  TopicList({
    this.topics,
  });

  factory TopicList.fromJson(List<dynamic> parsedJson) {
    List<Topic> topics = new List<Topic>();
    topics = parsedJson.map((i) => Topic.fromJson(i)).toList();
    return new TopicList(topics: topics);
  }

  List<Topic> get Topics => topics;
  void downloadImages() async {
    for (int i = 0; i < topics.length; i++) {
      //it may be possible to further optimize this
      await topics[i].downloadImage();
    }
  }
}

class Topic {
  //final int _topicId;
  int _id;
  String _name;
  String _imageLink;
  int _progress;
  int _level;
  int _isLoved;

  Topic._(
      {int id,
      String name,
      String imageLink,
      dynamic progress,
      dynamic isLoved,
      int level})
      : _id = id,
        _name = name,
        _imageLink = imageLink,
        _progress = progress,
        _isLoved = isLoved,
        _level = level;
  //Topic._({this._id,this.name,this.imageLink,this.progress,this.isLoved});

  factory Topic.fromJson(Map<String, dynamic> json) {
    var dataList = json['progress'];
    print(dataList.runtimeType);

    var v1 = json['topic_image'];
    print(v1.runtimeType);

    var v2 = json['is_loved'];
    print(v2.runtimeType);

    //during loading from net, we will need to download the image.
    //This is expressed by the following code
    /*
    Downloader downloader=new Downloader();
    String tempImageLink=json['topic_image'];
    tempImageLink=await downloader.downloadImg(tempImageLink, json['topic_name']);
    */

    //For current downloader, image is in jpg

    return new Topic._(
        id: json['topic_id'],
        name: json['topic_name'],
        imageLink: json['topic_image'],
        progress: json['progress'],
        isLoved: json['is_loved'],
        level: json['level_id']);
  }

  //getter
  int get id => _id;

  String get name => _name;

  String get imageLink => _imageLink;

  int get progress => _progress;

  int get isLoved => _isLoved;

  int get level => _level;

  //setters

  set id(int topicId) {
    this._id = topicId;
  }

  set name(String topicName) {
    this._name = topicName;
  }

  set level(int value) {
    this._level = value;
  }

  set imageLink(String imageLink) {
    this._imageLink = imageLink;
  }

  set progress(int progress) {
    this._progress = progress;
  }

  set isLoved(int isLoved) {
    this._isLoved = isLoved;
  }

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (_id != null) {
      map['Id'] = _id;
    }
    map['Topic_Name'] = _name;
    map['Image_Link'] = _imageLink;
    map['Topic_Progress'] = _progress;
    map['Is_Loved'] = _isLoved;
    map['Level'] = _level;
    return map;
  }

  // Extract a Note object from a Map object
  Topic.fromMapObject(Map<String, dynamic> map) {
    _id = map['Id'];
    _name = map['Topic_Name'];
    _imageLink = map['Image_Link'];
    _progress = map['Topic_Progress'];
    _isLoved = map['Is_Loved'];
    _level = map['Level'];
  }

  //may need to put this somewhere else
  void downloadImage() async {
    Downloader downloader = new Downloader();
    _imageLink = IMAGE_URL + _imageLink;
    String filename = _name + '.jpg'; //extension may change
    print(_imageLink);
    _imageLink = await downloader.downloadImg(_imageLink, filename);
    print(_imageLink);
  }

  void printData() {
    print(name + "\n");
  }

  // Topic(this._token);

  // Topic.map(dynamic obj) {
  //   this._token = obj["topic_name"];
  // }

  // String get token => _token;

  // Map<String, dynamic> toMap() {
  //   var map = new Map<String, dynamic>();
  //   map["topic_name"] = _token;

  //   return map;
  // }
}
