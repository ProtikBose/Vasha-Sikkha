import 'package:Dimik/databaseChange/jumbleSentence.dart';
import 'package:flutter/material.dart';
import '../jumble_Sentence/jumble_SentenceDraggable.dart';




class jumbleSentenceStats extends StatelessWidget{

  //final String title;
  jumbleSentence titleTemp;
  //final Function getFunc;
  GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  //final bool isLoaded;
  //jumbleSentenceStats(this.titleTemp,this.getFunc, this.isLoaded);
  jumbleSentenceStats(this.titleTemp,this.scaffoldKey);

  @override
  Widget build(BuildContext context) {
    
    
    //return dragableFG(title:titleTemp,getFunc: getFunc,isLoaded: isLoaded);
    return dragableFGJum(title:titleTemp,scaffoldKey:scaffoldKey);
  }
}