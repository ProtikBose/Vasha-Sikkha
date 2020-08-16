import '../utils/downloader.dart';

import 'package:Dimik/config.dart';

//As there will be only one user, there is no need to make a userlist class

class User {
  int _id;
  String _username;
  String _email;
  int _age;
  int _experienceId;
  String _imageLink;
  String _token;
  String _tokentype;
  String _expiryDate;
  //String _password;
  //int _level;
  /*
  int _privilege;
  Date _deletedAt;
  Date _createdAt;
  Date _updatedAt;
  */
  User();

  User._(
      {int id,
      String username,
      String email,
      int age,
      int experienceId,
      String imageLink,
      String token})
      : _id = id,
        _username = username,
        _email = email,
        _age = age,
        _experienceId = experienceId,
        _imageLink = imageLink,
        _token = token;

  factory User.fromJson(Map<String, dynamic> json) {
    //var dataList=json['data'];
    var v1 = json['user_id'];
    //var  v2= json['user_id'],
    var v3 = json['name'];
    var v4 = json['email'];
    var v5 = json['age'];
    var v6 = json['experience_id'];
    var v7 = json['latest_image'];
    //var v8=json['']
    if (v5 == null) v5 = -1;
    if (v6 == null) v6 = -1;
    if (v7 == null) v7 = "null";
    /*
    print(v1.runtimeType);
    print(v3.runtimeType);
    print(v4.runtimeType);
    print(v5.runtimeType);
    print(v6.runtimeType);
    print(v7.runtimeType);
    */

    return new User._(
      id: json['user_id'],
      username: json['name'],
      email: json['email'],
      age: v5,
      experienceId: v6,
      imageLink: v7,
      //token: json['Token']
    );
  }

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (_id != null) {
      map['Id'] = _id;
    }
    map['Username'] = _username;
    map['Email'] = _email;
    map['Age'] = _age;
    map['ExperienceId'] = _experienceId;
    map['Image_Link'] = _imageLink;
    map['Token'] = _token;
    return map;
  }

  User.fromMapObject(Map<String, dynamic> map) {
    this._id = map['Id'];
    this._username = map['Username'];
    this._email = map['Email'];
    this._age = map['Age'];
    this._experienceId = map['ExperienceId'];
    this._imageLink = map['Image_Link'];
    this._token = map['Token'];
  }

  //may need to put this somewhere else
  void downloadImage() async {
    Downloader downloader = new Downloader();
    String filename = IMAGE_URL + _username + '.jpg'; //extension may change
    _imageLink = await downloader.downloadImg(_imageLink, filename);
  }
  //getters

  int get id => _id;

  String get username => _username;

  String get email => _email;

  int get age => _age;

  int get experienceId => _experienceId;

  String get imageLink => _imageLink;

  String get token => _token;

  //setters

  set id(int id) {
    this._id = id;
  }

  set username(String username) {
    this._username = username;
  }

  set email(String email) {
    this._email = email;
  }

  /*
  set level(int level){
    this.level=level;
  }
  */
  set experienceId(int experienceId) {
    this._experienceId = experienceId;
  }

  set imageLink(String imageLink) {
    this._imageLink = imageLink;
  }

  set token(String token) {
    this._token = token;
  }
}
