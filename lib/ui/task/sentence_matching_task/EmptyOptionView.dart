import 'package:flutter/material.dart';

class EmptyOptionView extends StatelessWidget{
  
  final double _distanceFromTop;

  EmptyOptionView( this._distanceFromTop);

  @override
  Widget build(BuildContext context) {
    
   
    // return Positioned(
    //   top: _distanceFromTop,
    //   left: 20,
    //   right: 20,
    //   height: 63,
    //      child:
     return  RaisedButton(
                    onPressed: (){},
            
                     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                     //textColor: Colors.white,
                     //highlightColor: Colors.red,
                     color: Colors.grey,
                     elevation: 1,
                     //highlightElevation: 0.5,
                  );//,
    //);
  }
}