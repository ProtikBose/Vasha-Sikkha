import 'dart:ui';

import 'package:Dimik/models/task.dart';
import 'package:Dimik/models/topic.dart';
import 'package:flutter/widgets.dart';

class QuizItem{
  String quiz_name;
  Color card_color;
  Color text_color;
  List<Task> tasks;
  List<Topic> topics;

  QuizItem(
      {@required this.quiz_name,
      @required this.tasks,
      @required this.topics,
      this.card_color,
      this.text_color});

  
}
