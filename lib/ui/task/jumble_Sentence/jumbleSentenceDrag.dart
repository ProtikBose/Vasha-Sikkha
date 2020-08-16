import 'dart:async';

import 'package:Dimik/ui/task/jumble_Sentence/jumbleSentenceButtonDrag.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:Dimik/ScopedModel/mainmodel.dart';
import 'package:scoped_model/scoped_model.dart';

class DragGapsView extends StatefulWidget {
  String _text;
  final double _distanceFromTop;
  final int _pos;
  int buttonNum;
  
  final Function getFunc;
  final Function getFunc2;
  bool value1=true;
  bool value2=false;
  //final Function notification;
  bool isDisabled ;

  DragGapsView(this._text,this._pos, this._distanceFromTop,this.getFunc,this.getFunc2,this.isDisabled);

  @override
  State<StatefulWidget> createState() {
    return DragGapsStats();
  }
}

class DragGapsStats extends State<DragGapsView> {
  
  Color buttonColor = Colors.white;
  double PadNum=0.5;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    String text=widget._text;
    if (widget.isDisabled == false) {
      String text = widget._text;
      return ScopedModelDescendant<MainModel>(builder: (BuildContext context, Widget child, MainModel model){
      return Container(
          child: DragTarget(
              builder: (context, accepted, rejected) => FlatButton(
                  onPressed: () {},
                  color: buttonColor,

                  //key: UniqueKey(),
                  padding: EdgeInsets.only(left:PadNum),
                  
                  //width: widget._text.length,
                  child: Text(
                    text,
                    //textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 15,
                    ),
                    //textAlign: TextAlign.left,
                  ),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(23))),
              onAccept: (DragGapsButtonView _view) {
                 
                setState(() {
                 
                  
                    //dragged.isDisAbled = true;
                    print("hoise");
                    //buttonColor = Colors.green;
                    widget._text = _view.text+" ";
                    PadNum=0.0;
                    //widget.getFunc(widget.value1);
                    widget.isDisabled=true;
                    setState(() {
                      _view.isDisabled=true;  
                    });
                    
                    widget.getFunc2(_view.text,widget._pos,model);
                  
                });

                
              }));});
    }
    return RaisedButton(
      onPressed: () {},
      child: Text(text,
          style: TextStyle(
            fontSize: 15, color: Colors.blue
          )),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      disabledElevation: 0.3,
      disabledColor: Colors.grey[700],
    );
  }
}
