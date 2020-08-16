import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:Dimik/ScopedModel/mainmodel.dart';

class DragGapsView extends StatefulWidget {
  String _text;
  final double _distanceFromTop;
  final String _acceptText;
  int buttonNum;
  int position;
  
  final Function getFunc;
  final Function getFunc2;
  bool value1=true;
  bool value2=false;
  //final Function notification;
  bool isDisabled;

  DragGapsView(this._text, this._acceptText, this._distanceFromTop,this.getFunc,this.getFunc2,this.position,this.isDisabled);

  @override
  State<StatefulWidget> createState() {
    return DragGapsStats();
  }
}

class DragGapsStats extends State<DragGapsView> {
  //MainModel model;
  Color buttonColor = Colors.white;
  double PadNum=0.5;
  String accept;

  String choseText(BuildContext context,Color col,String accept){
    if(col==Colors.red){
      return accept;
    } 
    else return widget._text;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
   
    if (widget.isDisabled == false) {
      String text=widget._text; 
      print("Text "+widget._text);
      return ScopedModelDescendant<MainModel>(
        builder: (BuildContext context, Widget child, MainModel model) {
      return Container(
          child: DragTarget(
              builder: (context, accepted, rejected) => FlatButton(
                  onPressed: () {},
                  color: buttonColor,

                  //key: UniqueKey(),
                  padding: EdgeInsets.only(left:PadNum),
                  
                  //width: widget._text.length,
                  
                  child: Text(
                    //text,
                    choseText(context, buttonColor, accept),
                    //textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 12,
                    ),
                    //textAlign: TextAlign.left,
                  ),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(23))),
              onAccept: (String val) {
                 List<String>temp=new List();
                  temp=val.split("#");
                  String acceptTed=temp.elementAt(0);
                  int button=int.parse(temp.elementAt(1));
                setState(() {
                 
                  if (acceptTed == widget._acceptText) {
                    //dragged.isDisAbled = true;
                    print("hoise");
                    buttonColor = Colors.green;
                    widget._text = acceptTed;
                    PadNum=0.0;
                    
                    widget.isDisabled = true;
                    widget.getFunc(widget.value1,model,widget.position,widget._acceptText);
                    widget.isDisabled=true;
                    text = acceptTed;
                    widget.getFunc2(button);
                  } else {
                    buttonColor = Colors.red;
                   // text = widget._text;
                    widget._text = acceptTed;
                    text = widget._text;
                    accept=acceptTed;
                    //print(acceptTed);
                    PadNum=0.0;
                   widget.getFunc(widget.value2,model,widget.position,acceptTed);
                   widget._text = acceptTed;
                    text = widget._text;
                    buttonColor = Colors.red;
                    accept=acceptTed;
                   //text = widget._text;
                    //widget._text = acceptTed;
                   //widget._text = text;
                   //buttonColor = Colors.white;
                   //widget.getFunc2();
                   //widget.isDisabled=false;
                  }
                });

                Timer(Duration(milliseconds: 1500), () {
                  setState(() {
                    buttonColor = Colors.white;
                    //print("prev: "+prevText+" text: "+widget._text);
                    /* if (acceptTed == widget._acceptText) {
                      //widget._text = prevText;
                      widget.isDisabled = true;
                      text = acceptTed;
                      PadNum=2.0;
                    } */
                    if(acceptTed != widget._acceptText) {
                      //widget._text = text;
                      PadNum=2.0;
                      //widget.getFunc(widget.value2,model,widget.position,acceptTed);
                    }
                  });
                }
                );
              }));});
    }
    return RaisedButton(
      onPressed: () {},
      child: Text(widget._acceptText,
          style: TextStyle(
            fontSize: 15, color: Colors.green
          )),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      disabledElevation: 0.3,
      disabledColor: Colors.grey[700],
    );
  }
}
