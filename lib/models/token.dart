class Token {
  String _token;
  String _tokenType;
  String _expirationDate;
  Token._({String token,String tokenType,String expirationDate}):
  _token=token,
  _tokenType=tokenType,
  _expirationDate=expirationDate;

  factory Token.fromJson(Map<String,dynamic>json)
  { 
    /*
    var obj=json["access_token"];
    var obj2=json["token_type"];
    var obj3=json["expires_at"];
    //print(reflect(obj).type.reflectedType.toString());
    //print(obj.runtimeType);
    //print(obj2.runtimeType);
    //print(obj3.runtimeType);
    */
    return Token._(
      token:json["access_token"],
      tokenType: json["token_type"],
      expirationDate: json["expires_at"]

    );
  
  }

  
  String get token => _tokenType+' '+_token;

  //String get
  
  set token(String token){
    this._token=token;
  }

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map["token"] = _token;

    return map;
  }


}