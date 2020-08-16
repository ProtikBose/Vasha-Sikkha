import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:Dimik/ScopedModel/mainmodel.dart';
import 'package:scoped_model/scoped_model.dart';

class DragGapsButtonView extends StatefulWidget {
  String text;

  //final Function notification;
  bool isDisabled;

  DragGapsButtonView(this.text,this.isDisabled);

  @override
  State<StatefulWidget> createState() {
    return DragGapsButtonStats();
  }
}

class DragGapsButtonStats extends State<DragGapsButtonView> {
  Color buttonColor = Colors.white;
  //bool isDisabled;

  //DragGapsButtonStats(this.isDisabled);
  
  double PadNum = 0.5;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    String text = widget.text;
    //isDisabled=widget.isDisabled;

    print(widget.isDisabled);

    if (widget.isDisabled==false) {
      
      return Draggable(
        data: widget,
        child: RaisedButton(
          onPressed: () {},
          //disabledColor: Colors.red,
          key: UniqueKey(),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(23)),
          child: Text(widget.text),
        ),
        feedback: Container(
            child: RaisedButton(
                onPressed: () {},
                //disabledColor: Colors.green,
                child: Text(
                  widget.text,
                  style: TextStyle(
                    fontSize: 15, /*color: Color(0x2E303E)*/
                  ),
                  textAlign: TextAlign.center,
                ),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
                //textColor: Colors.white,
                //highlightColor: Colors.red,
                color: Colors.white,
                elevation: 1
                //highlightElevation: 0.5,
                )),
                onDragCompleted: (){
                  if(widget.isDisabled==true){
                    setState(() {
                      
                    });
                  }
                },
      );
    } else {
      return RaisedButton(
          onPressed: () {},
          //disabledColor: Colors.green,
          child: Text(
            widget.text,
            style: TextStyle(
              fontSize: 15, /*color: Color(0x2E303E)*/
            ),
            textAlign: TextAlign.center,
          ),
          //disabledColor: Colors.blue,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          //textColor: Colors.white,
          //highlightColor: Colors.red,
          color: Colors.blue,
          elevation: 1

          //highlightElevation: 0.5,
          );
    }
  }
}
