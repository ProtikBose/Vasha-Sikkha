import 'package:Dimik/data/rest/lb.dart';
import 'package:Dimik/models/leaderboard.dart';

class LBController {
  LBRest topicRest = new LBRest();
  LBList lbList;
  Future<List<LB>> getTopicList(String token) async {
    //int count = await topicDatabaseHelper.getCount();

    if (true) //count == 0) //table is empty
    {
      lbList = await topicRest.getAllTopics(token).catchError((Object onError) {
        print(onError.toString());
        print("Pour some sugar on me");
      });
      lbList.downloadImages();
      //await _insertTopicList(topicList);
    }
    List<LB> result = lbList.tfs; //await topicDatabaseHelper.getTopicList();
    return result;
  }
}
