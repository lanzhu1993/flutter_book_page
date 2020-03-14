import 'package:flutter/material.dart';

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


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(

        title: Text("手势滑动"),
      ),
      body: GestureDetector(
        onHorizontalDragStart: (startValue){
          print("开始值：$startValue");
        },
        onHorizontalDragEnd: (endValue){
          print("结束值：$endValue");
        },
        onHorizontalDragUpdate: (updateValue){
          print("更新值：${updateValue.globalPosition.dx}");
          print("更新值：${updateValue.globalPosition.dy}");


        },
        child: Container(
            color: Color.fromARGB(255, 220, 220, 220),
            child: new Center(
              child: new Text("Flutter手势"),
            )
        ),
      ),
    );
  }
}
