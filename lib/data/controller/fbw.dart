import 'package:Dimik/data/rest/fbw.dart';
import 'package:Dimik/models/fb_word.dart';

class FBWController {
  FBWRest fbwRest = new FBWRest();
  FBWList fbwList;

  Future<List<FB_Word>> getFBList(String token, int topicId) async {
    if (true) //table is empty
    {
      fbwList =
          await fbwRest.getAllFB(token, topicId).catchError((Object onError) {
        print(onError.toString());
        print("Pour some sugar on me");
      });
    }
    List<FB_Word> result = fbwList.fbs;

    return result;
  }
}
