import 'package:Dimik/models/leaderboard.dart';
import 'package:Dimik/utils/network_util.dart';
import 'package:Dimik/config.dart';

class LBRest {
  LBList lbList;
  NetworkUtil _netUtil = new NetworkUtil();

  Future<LBList> getAllTopics(String token) {
    String t1 = "application/x-www-form-urlencoded";
    String t2 = "application/json";
    Map<String, String> headers = new Map<String, String>();

    headers["Content-Type"] = t1;
    headers["Accept"] = t2;
    headers["Authorization"] = token;
    headers['topic_id'] = 1.toString();
    //headers["user_id"]=userId.toString();
    return _netUtil.get(LB_URL, headers: headers).then((dynamic res) {
      print("DEBUG :=====================\n" +
          res.toString() +
          "\n=====================\n");
      lbList = new LBList.fromJson(res);

      return lbList;
    });
  }
}
