import 'package:Dimik/databaseChange/mcqData.dart';
import 'package:flutter/material.dart';
import '../mcq_task/mcq_task_controller.dart';




class MCQStats extends StatelessWidget{

  //final String title;
  MCQDataBase titleTemp;
  //final Function getFunc;
  //final bool isLoaded;
  GlobalKey<ScaffoldState> scaffoldKey;
  MCQStats(this.titleTemp,this.scaffoldKey);

  @override
  Widget build(BuildContext context) {
    
    
    return controllerClass(title:titleTemp,scaffoldKey: scaffoldKey);
  }
}