import 'package:flutter/material.dart';
import 'package:fluttergesture/entity/slide_type.dart';
import 'package:fluttergesture/widget/book_widget.dart';

import 'widget/book_widget.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {


  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  BookPainter painter;

  double aX =-1;
  double aY = -1;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: GestureDetector(
        onHorizontalDragUpdate: (value){
          setState(() {
            //从上半部分翻页
            aX = value.globalPosition.dx;
            aY = value.globalPosition.dy;
          });
        },
        onHorizontalDragStart: (value){
          setState(() {
            //从上半部分翻页
            aX = value.globalPosition.dx;
            aY = value.globalPosition.dy;
          });        },
        onHorizontalDragEnd: (value){
          setState(() {
            //从上半部分翻页
            aX =-1;
            aY = -1;
          });        },
        child: ConstrainedBox(
            constraints: BoxConstraints.expand(),
          child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: CustomPaint(
                painter: painter = BookPainter(context,aX: aX,aY: aY),
              )
          ),
      ),
    )
    );
  }
}
