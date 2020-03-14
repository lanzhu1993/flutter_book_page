
import 'package:flutter/cupertino.dart';
import 'package:fluttergesture/entity/point_entity.dart';

class PointUtils{


  double _viewWidth;
  double _viewHeight;

  init(BuildContext context){
    _viewWidth = MediaQuery.of(context).size.width;
    _viewHeight = MediaQuery.of(context).size.height;
  }

  static calcPointsXY(Point a,Point b){

  }

}