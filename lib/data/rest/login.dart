import 'dart:async';
import 'package:Dimik/models/token.dart';
import 'package:Dimik/config.dart';
import 'package:Dimik/utils/network_util.dart';
import '../../models/user.dart';
import '../../utils/logErrorParser.dart';

//import 'package:mobile_application/models/token.dart';
//import 'package:mobile_application/models/token.dart';
class LoginRest {
  NetworkUtil _netUtil = new NetworkUtil();

  Future<Token> login(String username, String password) {
    String t1 = "application/x-www-form-urlencoded";
    String t2 = "application/json";
    Map<String, String> headers = new Map<String, String>();
    headers["Content-Type"] = t1;
    headers["Accept"] = t2;

    return _netUtil.post(LOGIN_URL,
        headers: headers,
        body: {"email": username, "password": password}).then((dynamic res) {
      /*
      print("DEBUG :=====================\n"+
      res.toString()+"\n=====================\n");
      */
      print(res.runtimeType.toString());
      LogErrorParser parser = new LogErrorParser.fromJson(res);
      print("Naoto");
      if (parser.errorMessage == "Unauthorized") {
        print("Jafsafsa");
        throw new Exception("Unauthorized");
      } else if (parser.errorMessage ==
          "The email must be a valid email address") {
        print("Zekrom");
        throw new Exception(parser.errorMessage);
      }
      print("HaiHai");

      print(res);

      return new Token.fromJson(res);
      //This is extremely bad coding practice. But we are short on time and can't find
      //what is wrong.
      /*
      if(res.containsKey("message")==true)
      {   
          if(res.containsKey("error"))
            token="The email must be a valid email address";
          else
            token="Unauthorized";
      }
      else
      {
          token = res["token_type"]+' '+res["access_token"];
      }
      print(token);
      return token;
      */
      //return new Token.fromJson(res);
    });
  }

  Future<User> getUserDetails(String token) {
    String t1 = "application/x-www-form-urlencoded";
    String t2 = "application/json";
    String accessToken = token;
    Map<String, String> headers = new Map<String, String>();
    headers["Content-Type"] = t1;
    headers["Accept"] = t2;
    headers["Authorization"] = accessToken;

    return _netUtil.get(DETAILS_URL, headers: headers).then((dynamic res) {
      print("DEBUG :=====================\n" +
          res.toString() +
          "\n=====================\n");
      if (res["error"] == "Unauthorised") throw new Exception(res["error"]);

      print("Hello World");
      User user = User.fromJson(res);
      return user;
    });
  }

  Future<String> logout(String token) {
    String t1 = "application/x-www-form-urlencoded";
    String t2 = "application/json";
    Map<String, String> headers = new Map<String, String>();
    headers["Content-Type"] = t1;
    headers["Accept"] = t2;
    headers["Authorization"] = token;

    return _netUtil.get(LOG_OUT, headers: headers).then((dynamic res) {
      print("DEBUG :=====================\n" +
          res.toString() +
          "\n=====================\n");
      if (res["error"] == "Unauthorised") throw new Exception(res["error"]);

      return 'Logout Successful';
    });
  }

  Future<String> register(
      String email, String username, String password, String passwordConfirm) {
    String t1 = "application/x-www-form-urlencoded";
    String t2 = "application/json";
    Map<String, String> headers = new Map<String, String>();
    headers["Content-Type"] = t1;
    headers["Accept"] = t2;

    return _netUtil.post(REG_URL, headers: headers, body: {
      "name": username,
      "email": email,
      "password": password,
      "password_confirmation": passwordConfirm,
    }).then((dynamic res) {
      print("DEBUG :=====================|||||||\n" +
          res.toString() +
          "\n=====================\n");
      //if(res["error"] == "Unauthorised") throw new Exception(res["error"]);
      if (res["message"] == "The given data was invalid") {
        //need to write the errors here
        print("Errors were found baby");
        throw new Exception("The given data was invalid");
      } else if (res["message"] == "Successfully created user!") {
        print("Hello Register");
      }

      //return new Token.fromJson(res);
      return res["message"];
    });
  }
}
