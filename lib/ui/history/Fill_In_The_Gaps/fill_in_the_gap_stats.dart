import 'package:Dimik/databaseChange/FBGapData.dart';
import 'package:flutter/material.dart';
import 'package:Dimik/ui/history/Fill_In_The_Gaps/fill_in_the_gaps_controller.dart';




class FillTheGapsStats extends StatelessWidget{

  //final String title;
  FbGap titleTemp;
  final Function getFunc;
  final bool isLoaded;
  int positionNumber;
  FillTheGapsStats(this.titleTemp,this.getFunc,this.isLoaded,this.positionNumber);

  @override
  Widget build(BuildContext context) {
    
    
    return dragableFG(title:titleTemp,getFunc: getFunc,isLoaded: isLoaded,positionNumber:positionNumber);
  }
}