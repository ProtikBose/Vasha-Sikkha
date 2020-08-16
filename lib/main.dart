import 'package:Dimik/ScopedModel/mainmodel.dart';
import 'package:Dimik/data/db/main.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import './routes.dart';

/*
void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModel<MainModel>(
      model: MainModel(),
      child: new MaterialApp(
        title: 'Dimik',
        theme: new ThemeData(primarySwatch: Colors.blue, fontFamily: 'Avenir'),
        routes: routes,
      ),
    );
  }
}
*/

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    MainDatabaseHelper();
    return new ScopedModel(
        model: MainModel(),
        child: MaterialApp(
          title: 'Dimik',
          theme:
              new ThemeData(primarySwatch: Colors.blue, fontFamily: 'Avenir'),
          routes: routes,
        ));
  }
}
