import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
//import '../task/TaskStats.dart';


class TaskView extends StatefulWidget{
  final List<String> cards;
  
  TaskView({this.cards});

  @override
  State<StatefulWidget> createState() {
    
    return _TaskViewState(cards: cards);
  }
}
 
 
 class _TaskViewState extends State<TaskView> with TickerProviderStateMixin{
  
  AnimationController animationController;
  Animation<Offset> _moveOutOfTheScreen;
  Animation<double> _rotate;
  CurvedAnimation curvedAnimation;
  List<String> cards = [];
  int index, length;
  bool isPressed;

  _TaskViewState({this.cards});
  
  @override
  void initState() {
    
    super.initState();
    length = cards.length;
    index = 0;
    isPressed = false;

    // if(length>0)
    //   cards.add(cards[0]);

    animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 800)
    );

    curvedAnimation = CurvedAnimation(parent: animationController, curve: Curves.easeOut);
    _moveOutOfTheScreen = new Tween<Offset>(
      begin: Offset(0.0,0.0),
      end: Offset(-500.0,200.0)
    ).animate(curvedAnimation)..addListener(() {
    setState(() {
      //animationController.reset();
    });
  });
   _rotate = new Tween<double>(
       begin: 0,
       end: -1
     ).animate(curvedAnimation);//..addListener(() {
  //   setState(() {});
  // });

  }
  
  @override
    Widget build(BuildContext context) {
      
      return Stack(
        children: <Widget>[
          Positioned(
            top: 49,
            //bottom: 650,
            left: 20,
            //right: 20,
            width: 194,
            height: 49,
            child: Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(29.5)),
              child:Stack(
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
                  )
                ],
              )
            )
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

          // Positioned(
          //   top: 144,
          //   bottom: 143,
          //   left: 20,
          //   right: 20,
          //   child:TaskStats()
             
          // ),
          Positioned(
            top: 144,
            bottom: 143,
            left: 20,
            right: 20,
            child: Stack(children: cards.reversed.map((card){
                if(cards.indexOf(card)<2){
                   return(Transform.translate(
                    offset: moveValue(card),
                    child: Transform.rotate(
                      angle: rotateValue(card),
                     // child: TaskStats(title: card)
                    )
                  ));
              
                }

            }).toList()
            )
          ),

          Positioned(
            top: 675,
            //bottom: 0,
            left: 20,
            width: 320,
            height: 63,
            child: RaisedButton(
              onPressed: (){
                isPressed = true;
                animationController.forward().whenComplete((){
                 setState((){
                    animationController.reset();
                    String removedCard = cards.removeAt(0);
                    cards.add(removedCard);
                    isPressed = false;
                 });
                });
                
                
                // if(length>0){
                //   index = (index+1)%length;

                // }
              }, 
              child: Stack(
                children: <Widget>[
                  Positioned(
                    
                    top:18,
                    bottom: 28,
                    left: 122.5,
                    child: Text("Get next", style: TextStyle(fontSize: 15, ),),
                  )
                ],
              ),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(23)),
              textColor: Colors.white,
              //highlightColor: Colors.red,
              color: Color(0xFF8577E2),
              //elevation: 1,
              //highlightElevation: 0.5,
              
            ),          
          )
        ],
      );
    }

    Offset moveValue(card){
      
      if(cards.indexOf(card) == 0 && isPressed)
        return _moveOutOfTheScreen.value;
      return Offset(0.0,0.0);
    }

    double rotateValue(card){
      if(cards.indexOf(card) == 0 && isPressed)
        return _rotate.value;
      return 0.0;
    }
}

