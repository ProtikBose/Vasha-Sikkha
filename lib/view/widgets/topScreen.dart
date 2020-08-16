import 'package:flutter/material.dart';

class TaskTopScreen extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    
    return Stack(
                children: <Widget>[
                  Positioned(
                    left: 5,
                    width: 10,
                    top: -2,
                    child: IconButton(
                      onPressed: (){},
                      
                      icon: Icon(Icons.arrow_back_ios),
                    ),
                  ),

                  Positioned(
                    left: 52,
                    right: 76,
                    top: 14,
                    bottom: 13,
                    child:  Text(
                    "Remaining",style: TextStyle(color: Color(0xFF2E303E), fontSize: 12)),
                  
                  ),
                  Positioned(
                    left: 136,
                    right: 26,
                    top: 14,
                    bottom: 13,
                    child: Text("1:20",style: TextStyle(color: Color(0xFFE27777), fontSize: 12),),
                  ),
                  Positioned(
                  top: 49,
                  //bottom: 650,
                  left: 243,
                  //right: 20,
                  width: 97,
                  height: 49,
                  child: Card(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(29.5)),
                    child: Row(mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text("20"),Text("/",style: TextStyle(color: Color.fromARGB(51,46, 48, 62))),Text("16")
                      ],
                    )
                  )
                ),
              ],
            );
  }
    
}

class RemainingTasks extends StatelessWidget{

  final int _totalTasks, _currentTask;

  RemainingTasks(this._totalTasks, this._currentTask);

  @override
  Widget build(BuildContext context) {
    
    return  Positioned(
            top: 49,
            //bottom: 650,
            left: 243,
            //right: 20,
            width: 97,
            height: 49,
            child: Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(29.5)),
              child: Row(mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(_currentTask.toString()),Text("/",style: TextStyle(color: Color.fromARGB(51,46, 48, 62))),Text(_totalTasks.toString())
                ],
              )
            )
          );
  }
}