import 'dart:math';

import 'package:Dimik/config.dart';
import 'package:Dimik/utils/downloader.dart';

class LBList {
  List<LB> _tfs;

  LBList._({List<LB> tfs}) : _tfs = tfs;

  factory LBList.fromJson(List<dynamic> parsedJson) {
    List<LB> tfs = new List<LB>();
    tfs = parsedJson.map((i) => LB.fromJson(i)).toList();

    return new LBList._(tfs: tfs);
  }
  void downloadImages() async {
    for (int i = 0; i < _tfs.length; i++) {
      //it may be possible to further optimize this
      if (_tfs[i].imgLink == null) {
        _tfs[i].imgLink = 'assets/img/profile.jpg';
      } else {
        await _tfs[i].downloadImage();
      }
    }
  }

  List<LB> get tfs => _tfs;
}

class LB {
  String _username;
  //int _answerCount;
  int _level;
  double _progress;
  String _imgLink;
  //int _topicId;

  String get username => _username;
  String get imgLink => _imgLink;
  double get progress => _progress;
  int get level => _level;

  void set imgLink(String imgLink) {
    _imgLink = imgLink;
  }

  LB._({String username, int level, double score, String imgLink}) {
    this._username = username;
    this._level = level;
    this._progress = score;
    this._imgLink = imgLink;
  }

  factory LB.fromJson(Map<String, dynamic> json) {
    return new LB._(
        level: int.parse(json['Level'].toString()),
        imgLink: json['Image_Link'],
        score: double.parse(json['Score'].toString()),
        username: json['User_Name'].toString());
  }

  void downloadImage() async {
    Downloader downloader = new Downloader();
    _imgLink = IMAGE_URL + _imgLink;
    String filename = _username.replaceAll(' ', '') +
        Random().nextInt(1000).toString() +
        '.jpg'; //extension may change
    print(filename);
    _imgLink = await downloader.downloadImg(_imgLink, filename);
    print(_imgLink);
  }
}
