import 'package:Dimik/models/task.dart';

class Task_History {
  Task _task;
  int _correctIndex;
  int _inputIndex;

  Task_History({Task task, int correctIndex, int inputIndex}) {
    this._task = task;
    this._correctIndex = correctIndex;
    this._inputIndex = inputIndex;
  }

  void set correctIndex(int value) {
    _correctIndex = value;
  }

  void set inputIndex(int value) {
    _inputIndex = value;
  }

  Task get task => _task;
  int get correctIndex => _correctIndex;
  int get inputIndex => _inputIndex;
}
