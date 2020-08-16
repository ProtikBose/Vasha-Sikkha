import 'package:Dimik/models/task.dart';
import 'package:Dimik/models/topic.dart';

class TopicTaskState {
  Topic _topic;
  List<Task> _task_list;
  int _current_task;

  TopicTaskState(Topic topic, List<Task> task_list) {
    this._topic = topic;
    this._task_list = task_list;
    _current_task = 0;
  }

  double get completion => _topic.progress.toDouble();

  void incrementTaskCount() {
    //print(_task_list.length);
    _current_task++;
  }

  void normalize() {
    _current_task--;
  }

  Topic get topic => _topic;
  String currentTask() {
    return _task_list[_current_task].taskname;
  }

  int get current_task_num => _current_task;
  int get task_len => _task_list.length;

  void addTask(List<Task> list) {
    _task_list.addAll(list);
  }
}
