class LogErrorParser{
  String _errorMessage;
  
  LogErrorParser._(String errorMessage):
  _errorMessage = errorMessage;
  factory LogErrorParser.fromJson(Map<String,dynamic> json)
  {   
      String result;
      print("In constructor");
      bool b=json.containsKey("message");
      print(b);
      if(b==false)
        result="Valid";
      else
      {
          if(json["message"] == "Unauthorized")
            result = "Unauthorized";
          else
            result = "The email must be a valid email address";
      }
      return new LogErrorParser._(result);
  }

  String get errorMessage=> _errorMessage;

}