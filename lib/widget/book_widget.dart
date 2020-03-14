import 'package:flutter/material.dart';
import 'package:fluttergesture/entity/point_entity.dart';
import 'package:extended_math/extended_math.dart';
import 'package:fluttergesture/entity/slide_type.dart';


class BookWidget extends StatelessWidget {

  Widget child;
  SlideType type = SlideType.STYLE_TOP_RIGHT;

  BookWidget(this.child,{this.type});

  Point a,b,c,d,e,f,g,h,i,j,k;
  double _viewWidth;
  double _viewHeight;

  double lPathAShadowDis = 0;//A区域左阴影矩形短边长度参考值
  double rPathAShadowDis = 0;//A区域右阴影矩形短边长度参考值

  init(BuildContext context){
    _viewWidth = MediaQuery.of(context).size.width;
    _viewHeight = MediaQuery.of(context).size.height;
    a = Point();
    b = Point();
    c= Point();
    d = Point();
    e = Point();
    f = Point();
    g = Point();
    h = Point();
    i = Point();
    j = Point();
    k = Point();
  }

  @override
  Widget build(BuildContext context) {
    return Container(

    );
  }


  /// 计算各点坐标
  _calcPointsXY(Point a,Point f){
    g.x = (a.x + f.x) / 2;
    g.y = (a.y + f.y) / 2;

    e.x = g.x - (f.y - g.y) * (f.y - g.y) / (f.x - g.x);
    e.y = f.y;

    h.x = f.x;
    h.y = g.y - (f.x - g.x) * (f.x - g.x) / (f.y - g.y);

    c.x = e.x - (f.x - e.x) / 2;
    c.y = f.y;

    j.x = f.x;
    j.y = h.y - (f.y - h.y) / 2;

    b = _getIntersectionPoint(a,e,c,j);
    k = _getIntersectionPoint(a,h,c,j);

    d.x = (c.x + 2 * e.x + b.x) / 4;
    d.y = (2 * e.y + c.y + b.y) / 4;

    i.x = (j.x + 2 * h.x + k.x) / 4;
    i.y = (2 * h.y + j.y + k.y) / 4;

    //计算d点到ae的距离
    double lA = a.y-e.y;
    double lB = e.x-a.x;
    double lC = a.x*e.y-e.x*a.y;

    lPathAShadowDis = ((lA*d.x+lB*d.y+lC).abs()/hypot(lA,lB));

    //计算i点到ah的距离
    double rA = a.y-h.y;
    double rB = h.x-a.x;
    double rC = a.x*h.y-h.x*a.y;
    rPathAShadowDis = ((rA*i.x+rB*i.y+rC).abs()/hypot(rA,rB));
  }

  ///计算两点之间的交点坐标
  _getIntersectionPoint(Point one,Point two,Point three,Point four){
    double x1,y1,x2,y2,x3,y3,x4,y4;
    x1 = one.x;
    y1 = one.y;
    x2 = two.x;
    y2 = two.y;
    x3 = three.x;
    y3 = three.y;
    x4 = four.x;
    y4 = four.y;

    double pointX =((x1 - x2) * (x3 * y4 - x4 * y3) - (x3 - x4) * (x1 * y2 - x2 * y1))
        / ((x3 - x4) * (y1 - y2) - (x1 - x2) * (y3 - y4));
    double pointY =((y1 - y2) * (x3 * y4 - x4 * y3) - (x1 * y2 - x2 * y1) * (y3 - y4))
        / ((y1 - y2) * (x3 - x4) - (x1 - x2) * (y3 - y4));
    return Point(x: pointX,y: pointY);
  }



}


