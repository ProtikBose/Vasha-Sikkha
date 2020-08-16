import 'package:Dimik/ScopedModel/mainmodel.dart';
import 'package:Dimik/ui/task/TrueFalse/true_false_task.dart';
import 'package:flutter/material.dart';
import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:scoped_model/scoped_model.dart';

class KidsBoxIntroCard extends StatefulWidget {
  final List<String> hint;

  KidsBoxIntroCard(
      {@required this.hint});

  @override
  State<StatefulWidget> createState() {
    return KidsBoxIntroCardState();
  }
}

class KidsBoxIntroCardState extends State<KidsBoxIntroCard> {

  @override
  void initState() {
    super.initState();
  }
  
  List<Widget> getList(){
    List<Widget> widgets = new List<Widget>();

    for(int i=0;i<widget.hint.length;i++){
      widgets.add(Text((i+1).toString()+'. '+widget.hint[i],style: TextStyle(fontSize: 28),));
    }

    return widgets ;
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant(
      builder: (BuildContext context, Widget child, MainModel model) {
        return Container(child:Container(margin: EdgeInsets.all(30),child: Column(children: getList(),mainAxisAlignment: MainAxisAlignment.spaceAround,crossAxisAlignment: CrossAxisAlignment.center,),),
            margin: EdgeInsets.all(20),
            height: (453.0 / 740.0) * MediaQuery.of(context).size.height,
            width: (320.0 / 360.0) * MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: new BorderRadius.all(const Radius.circular(30)),
              boxShadow: [new BoxShadow(blurRadius: 20,color: Color.fromRGBO(133, 119, 226, 1).withOpacity(0.25),offset: Offset(10, 15))]
            ));
      },
    );
  }
}
