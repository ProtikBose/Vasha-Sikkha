import 'package:Dimik/databaseChange/FBGapData.dart';
import 'package:flutter/material.dart';
import '../Fill_in_the_gaps/fillGapsControllerDragable.dart';




class FillTheGapsStats extends StatelessWidget{

  //final String title;
  FbGap titleTemp;
  GlobalKey<ScaffoldState> scaffoldKey;
  //final Function getFunction;
  
  FillTheGapsStats(this.titleTemp,this.scaffoldKey);

  @override
  Widget build(BuildContext context) {
    
    
    return dragableFG.draggableFB(title:titleTemp,scaffoldKey: scaffoldKey);
  }
}