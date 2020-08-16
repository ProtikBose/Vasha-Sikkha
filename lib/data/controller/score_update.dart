import 'package:Dimik/models/score_update.dart';

import '../rest/score_update.dart';

class ScoreUpdateController {
  ScoreUpdateRest scoreRest = new ScoreUpdateRest();

  Future<String> postVerdict(String token, ScoreUpdate score) async {
    String message = await scoreRest.postScoreUpdate(token, score).catchError((Object onError) {
      print(onError.toString());
      print("Pour some sugar on me");
    });

    return message;
  }
}
