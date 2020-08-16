import 'package:flutter/material.dart';

class TaskStats extends StatelessWidget{

  final String title;

  TaskStats({this.title});

  @override
  Widget build(BuildContext context) {
    
    return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0)
            ),
            child: Stack(
              children: <Widget>[
                Positioned(
                  top: 113,
                  bottom: 270,
                  left: 20,
                  right: 20,
                  //width: 280,
                  //height: 70,
                  child: Text(title,
                    style: TextStyle(fontSize: 18,
                      //fontFamily: ,
                      letterSpacing: -0.654545
                    ),
                  ),
                ),
                Positioned(
                  top: 237.63,
                  
                  left: 20,
                  width: 132,
                  height: 70,
                  child: RaisedButton(
                    onPressed: (){},
                    child: Text("Option 1", style: TextStyle(fontSize: 15, ),),
                     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(23)),
                     textColor: Colors.white,
                     //highlightColor: Colors.red,
                     color: Color(0xFFFF8383),
                     //elevation: 1,
                     //highlightElevation: 0.5,
                  ),
                ),
                Positioned(
                  top: 237.63,
                  
                  right: 20,
                  width: 132,
                  height: 70,
                  child: RaisedButton(
                    onPressed: (){},
                    child: Text("Option 2", style: TextStyle(fontSize: 15, ),),
                     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(23)),
                     //textColor: Colors.white,
                     //highlightColor: Colors.red,
                     color: Colors.white,
                     //elevation: 1,
                     //highlightElevation: 0.5,
                  ),
                ),
                Positioned(
                  bottom: 43.6,
                  
                  left: 20,
                  width: 132,
                  height: 70,
                  child: RaisedButton(
                    onPressed: (){},
                    child: Text("Option 3", style: TextStyle(fontSize: 15, ),),
                     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(23)),
                     //textColor: Colors.white,
                     //highlightColor: Colors.red,
                     color: Colors.white,
                     //elevation: 1,
                     //highlightElevation: 0.5,
                    
                  ),
                ),
                Positioned(
                  bottom: 43.6,
                  
                  right: 20,
                  width: 132,
                  height: 70,
                  child: new RaisedButton(
                    onPressed: (){},
                    child: Text("Option 4", style: TextStyle(fontSize: 15, ),),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(23)),
                    textColor: Colors.white,
                    //highlightColor: Colors.red,
                    color: Color(0xFF53C36F),
                    //elevation: 1,
                    //highlightElevation: 0.5,
                  ),
                ),
              ],
            ),
          );
  }
}