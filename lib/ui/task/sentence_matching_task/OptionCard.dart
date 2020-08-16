import 'package:Dimik/ui/task/sentence_matching_task/TaskElement.dart';
import 'package:flutter/material.dart';
import './OptionView.dart';

class OptionCardSM extends StatelessWidget{

  final Map<TaskElementSM, TaskElementSM> _options;
  final double _initialDistFromTop = 0;
  final List<int> order;
  GlobalKey<ScaffoldState> scaffoldKey;
  //final Function notification;
  List<TaskElementSM> arrangedOptions = new List<TaskElementSM>(6) ;
  
  

  OptionCardSM(this._options, this.order, this.scaffoldKey);
  

  @override
  Widget build(BuildContext context) {

    // print("In optionCard");
    // print(_options);
    arrangeOptions(this.order);

    
    return Stack(
                    children: <Widget>[
                    OptionView(arrangedOptions[0], acceptString(arrangedOptions[0]), _initialDistFromTop,scaffoldKey),
                    OptionView(arrangedOptions[1], acceptString(arrangedOptions[1]),_initialDistFromTop+78,scaffoldKey),
                    OptionView(arrangedOptions[2],acceptString(arrangedOptions[2]),_initialDistFromTop+78*2,scaffoldKey),
                    OptionView(arrangedOptions[3],acceptString(arrangedOptions[3]),_initialDistFromTop+78*3,scaffoldKey),
                    OptionView(arrangedOptions[4], acceptString(arrangedOptions[4]),_initialDistFromTop+78*4,scaffoldKey),
                    OptionView(arrangedOptions[5], acceptString(arrangedOptions[5]),_initialDistFromTop+78*5,scaffoldKey),
                    ]
                  );
  }

  TaskElementSM acceptString(TaskElementSM s){
    //print("in as: "+s);

    if(_options[s] != null)
      return _options[s];
    return _options.keys.firstWhere(
      (k) => _options[k] == s, orElse: () => null);

  }

  void arrangeOptions(List<int>order){
    // List<int> order =[4,3,0,2,5,1];
    // order.shuffle();
    int index = 0;
    
    _options.forEach((k,v){
      //print("here: "+k+" "+v+" "+index.toString());
      arrangedOptions[order[index++]] = k;
      arrangedOptions[order[index++]] = v;
      
    });
    
  }
}