class Vocabulary {
  final int dictionaryID;
  final String banglaWord;
  final String englishWord;
  final String imageLink;

  Vocabulary._({this.dictionaryID,this.banglaWord,this.englishWord,this.imageLink});

  factory Vocabulary.fromJson(Map<String, dynamic> json) {
    return new Vocabulary._(
      dictionaryID: json['dictionaryID'],
      banglaWord: json['banglaWord'],
      englishWord: json['englishWord'],
      imageLink: json['imageLink'],
    );
  }

  String getBanglaWord(){
    return banglaWord;
  }


  String getEnglishWord(){
    return englishWord;
  }

  String getImg(){
    return imageLink;
  }
  // Vocabulary(this._token);

  // Vocabulary.map(dynamic obj) {
  //   this._token = obj["topic_name"];
  // }

  // String get token => _token;

  // Map<String, dynamic> toMap() {
  //   var map = new Map<String, dynamic>();
  //   map["topic_name"] = _token;

  //   return map;
  // }
}