import 'package:Dimik/ScopedModel/mainmodel.dart';
import 'package:Dimik/data/db/user.dart';
import 'package:scoped_model/scoped_model.dart';
import '../../models/token.dart';
import '../../data/rest/login.dart';
import '../../models/user.dart';

class UserController {
  LoginRest loginRest = new LoginRest();
  //UserDatabaseHelper userDatabaseHelper = new UserDatabaseHelper();
  User user;
  //This will return the details of
  Future<User> login(String username, String password, MainModel model) async {
    int count = 0;
    User user = new User();
    Token token;
    if (true) {
      print("Heho");
      token =
          await loginRest.login(username, password).catchError((Object error) {
        print("Zezeze");
      });
      print("FauFau");
      /*
       token;
      token = await loginRest.login(username, password).catchError((Object error){
          print(error.toString());
      });
      if(token == "Invalid Username or Password")
        throw new Exception(token);
      */
      if (token != null) {
        user.token = token.token;
        return user;
      } else {
        return null;
      }
      //dynamic token =await loginRest.login(username,password);
      //print(token.runtimeType);
      /*
      Token token =
          await loginRest.login(username, password).catchError((Object error) {
        print(error.toString());
      });
      */
      //String accessToken="Bearer "+token.token;

      //String accessToken="Bearer "+token.token;

      //user = await loginRest.getUserDetails(token).catchError((Object error) {
      //print(error.toString());
      //});
      //await user.downloadImage(); Image downloading going on here
      //print("Baby");
      //await userDatabaseHelper.insertUser(user);
    }

    return user;
  }

  Future<void> logout(String token) async {
    String result = await loginRest.logout(token).catchError((Object error) {
      print(error.toString());
    });

    print(result);
  }

  Future<User> getUser(String token) async {
    User user = await loginRest.getUserDetails(token);
    return user;
  }
}
