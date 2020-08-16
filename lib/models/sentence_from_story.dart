import 'package:Dimik/utils/downloader.dart';
import 'task.dart';
//picture to sentence
class SFS extends Task {
  String _imgLink;
  List<int> _answers;
  List<String> _options;
  String _explanation;

  SFS._(
      {String taskName,
      int taskId,
      int specificTaskId,
      String imgLink,
      List<String> options,
      List<int> answers,
      String explanation})
      : _imgLink = imgLink,
        _options = options,
        _answers = answers,
        _explanation = explanation,
        super(taskName, taskId, specificTaskId);

  //SFS({this.imgLink, this.options, this.answers, this.explanation});
  SFS(
      {String taskName,
      int taskId,
      int specificTaskId,
      String imgLink,
      List<String> options,
      List<int> answers,
      String explanation})
      : super(taskName, taskId, specificTaskId) {
    _imgLink = imgLink;
    _options = options;
    _answers = answers;
    _explanation = explanation;
  }
  //factory SFS.fromJson(Map<Dynamic,String>json)
  // {

  // }

  String get imgLink => _imgLink;
  List<int> get answers => _answers;
  List<String> get options => _options;
  String get explanation => _explanation;
      @override
  String get taskname{
    return "SFS";
  }

  void downloadImage(String name) async {
    Downloader downloader = new Downloader();
    String filename = name + '.jpg'; //extension may change
    print(_imgLink);
    _imgLink = await downloader.downloadImg(_imgLink, filename);
    print(_imgLink);
  }
}
