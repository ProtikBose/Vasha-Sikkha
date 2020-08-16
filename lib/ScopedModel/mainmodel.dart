import 'package:scoped_model/scoped_model.dart';
import 'package:Dimik/ScopedModel/mergedmodel.dart';
import './smmodel.dart';
import 'package:Dimik/ScopedModel/SMEnglish.dart';

class MainModel extends Model
    with
        MergedModel,
        TopicModel,
        TruefalseModel,
        PictureWordModel,
        WordPictureModel,
        ListeningTaskModel,
        QuizModel,
        SFSModel,
        SMModel,
        SMEnglish,
        JumbledModel,
        FillInTheGaps,
        MCQScoped,
        FBwordModel,
        MemoryGameModel {
  MainModel() {}
}
