import 'package:Dimik/ScopedModel/mergedmodel.dart';
import 'package:Dimik/ui/leaderboard/leaderboard_view.dart';
import 'package:Dimik/ui/mix_task/mix_task_view.dart';
import 'package:Dimik/ui/settings/settings.dart';
import 'package:Dimik/ui/task/Fill_in_the_gaps_words/fb_word_view.dart';
import 'package:Dimik/ui/task/TrueFalse/true_false_task.dart';
import 'package:Dimik/ui/homePage/home.dart';
import 'package:Dimik/ui/gameover/gameover_view.dart';
import 'package:Dimik/ui/login/login_page.dart';
import 'package:Dimik/ui/task/kids_box/kids_box_intro.dart';
import 'package:Dimik/ui/task/kids_box/kids_box_task.dart';
import 'package:Dimik/ui/task/listening_game/listening_task.dart';
import 'package:Dimik/ui/task/pictureWord/picture_word_task.dart';
import 'package:Dimik/ui/profile/profile_view.dart';
import 'package:Dimik/ui/task/sentence_from_story/sentence_from_story_task.dart';
import 'package:Dimik/ui/task/wordPicture/word_picture_task.dart';
import 'package:Dimik/ui/task_history/task_history_view.dart';
import 'package:flutter/material.dart';
import 'package:Dimik/ui/task/jumble_Sentence/jumble_Sentence_view.dart';
import 'package:Dimik/ui/task/Fill_in_the_gaps/Fill_in_the_gaps_view.dart';
import 'package:Dimik/ui/task/mcq_task/mcq_task_view.dart';
import 'package:Dimik/ui/task/memory_game/memory_game_view.dart';
import 'package:Dimik/ui/history/Fill_In_The_Gaps/fill_in_the_gaps_view.dart';

final routes = {
  '/gameover': (BuildContext context) => new GameOver(),
  '/home': (BuildContext context) => new HomePage(),
  '/': (BuildContext context) => new LogInPage(),
  //'/': (BuildContext context) => new MixTask(),
  '/wordpicture': (BuildContext context) => WordPictureTask(),
  '/pictureword': (BuildContext context) => new PictureWordTask(),
  '/truefalse': (BuildContext context) => TrueFalseTask(),
  '/profile': (BuildContext context) => ProfilePage(),
  '/kbintro': (BuildContext context) => KidsBoxIntro(),
  '/kbtask': (BuildContext context) => KidsBox(),
  '/lwtask': (BuildContext context) => ListeningTask(),
  //'/smtask': (BuildContext context) => new SentenceMatchingView(),
  '/mixtask': (BuildContext context) => new MixTask(),
  //'/': (BuildContext context) => new FillTheGapsView(),
  '/sfs': (BuildContext context) => new SentenceFromStoryTask(),
  //'/sm': (BuildContext context) => new SentenceMatchingView(),
  //'/sme': (BuildContext context) => new SentenceMatchingViewEng(),
  '/jumbled': (BuildContext context) => new jumbleSentenceView(),
  '/fillTheGaps': (BuildContext context) => new FillTheGapsView(),
  "/mcqTask": (BuildContext context) => new MCQView(),
  "/memoryGame": (BuildContext context) => new MemoryGameView(),
  '/fillThegapsHistory': (BuildContext context) => new FillTheGapsViewHistory(),
  '/fbword': (BuildContext context) => new FB_Word_Task(),
  '/settings': (BuildContext context) => new Settings(),
  '/history': (BuildContext context) => new TaskHistoryView(),
  '/leaderboard': (BuildContext context) => new LeaderBoard(),
};
