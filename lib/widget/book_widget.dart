import 'package:flutter/material.dart';
import 'package:fluttergesture/entity/point_entity.dart';
import 'package:extended_math/extended_math.dart';
import 'package:fluttergesture/entity/slide_type.dart';

class BookPainter extends CustomPainter {
  SlideType type = SlideType.STYLE_TOP_RIGHT;

  final PageController pageController;

  Paint painter;

  Paint pointAPaint;
  Paint pointBPaint;
  Paint pointCPaint;

  Path pathA;
  Path pathB;
  Path pathC;

  double aX = -1;
  double aY = -1;

  BookPainter(BuildContext context,
      {this.type, this.pageController, this.aX = -1, this.aY = -1})
      : super(repaint: pageController) {
    painter = Paint()
      ..color = Color(0xFFFFFF)
      ..style = PaintingStyle.fill;
    init(context);
  }

  Point a, b, c, d, e, f, g, h, i, j, k;
  double _viewWidth = 0;
  double _viewHeight = 0;

  double lPathAShadowDis = 0; //A区域左阴影矩形短边长度参考值
  double rPathAShadowDis = 0; //A区域右阴影矩形短边长度参考值

  init(BuildContext context) {
    _viewWidth = MediaQuery.of(context).size.width;
    _viewHeight = MediaQuery.of(context).size.height;
    a = Point(x: aX, y: aY);
    f = Point(x: _viewWidth, y: _viewHeight);

    b = Point();
    c = Point();
    d = Point();
    e = Point();
    g = Point();
    h = Point();
    i = Point();
    j = Point();
    k = Point();

    pointAPaint = new Paint();
    pointAPaint..color = Colors.green;
    pointAPaint..style = PaintingStyle.fill;

    pointBPaint = new Paint();
    pointBPaint..color = Colors.blue;
    pointBPaint..style = PaintingStyle.fill;

    pointCPaint = new Paint();
    pointCPaint..color = Colors.yellow;
    pointCPaint..style = PaintingStyle.fill;

    pathA = Path();
    pathB = Path();
    pathC = Path();
    _calcPointsXY(a, f);
  }

  ///计算C点的X值
  double _calcPointCX(Point a,Point f){
    Point g,e;
    g = new Point();
    e = new Point();
    g.x = (a.x + f.x) / 2;
    g.y = (a.y + f.y) / 2;

    e.x = g.x - (f.y - g.y) * (f.y - g.y) / (f.x - g.x);
    e.y = f.y;

    return e.x - (f.x - e.x) / 2;

  }

  /// 计算各点坐标
  _calcPointsXY(Point a, Point f) {
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

    b = _getIntersectionPoint(a, e, c, j);
    k = _getIntersectionPoint(a, h, c, j);

    d.x = (c.x + 2 * e.x + b.x) / 4;
    d.y = (2 * e.y + c.y + b.y) / 4;

    i.x = (j.x + 2 * h.x + k.x) / 4;
    i.y = (2 * h.y + j.y + k.y) / 4;

    //计算d点到ae的距离
    double lA = a.y - e.y;
    double lB = e.x - a.x;
    double lC = a.x * e.y - e.x * a.y;

    lPathAShadowDis = ((lA * d.x + lB * d.y + lC).abs() / hypot(lA, lB));

    //计算i点到ah的距离
    double rA = a.y - h.y;
    double rB = h.x - a.x;
    double rC = a.x * h.y - h.x * a.y;
    rPathAShadowDis = ((rA * i.x + rB * i.y + rC).abs() / hypot(rA, rB));
  }

  ///计算两点之间的交点坐标
  _getIntersectionPoint(Point one, Point two, Point three, Point four) {
    double x1, y1, x2, y2, x3, y3, x4, y4;
    x1 = one.x;
    y1 = one.y;
    x2 = two.x;
    y2 = two.y;
    x3 = three.x;
    y3 = three.y;
    x4 = four.x;
    y4 = four.y;

    double pointX =
        ((x1 - x2) * (x3 * y4 - x4 * y3) - (x3 - x4) * (x1 * y2 - x2 * y1)) /
            ((x3 - x4) * (y1 - y2) - (x1 - x2) * (y3 - y4));
    double pointY =
        ((y1 - y2) * (x3 * y4 - x4 * y3) - (x1 * y2 - x2 * y1) * (y3 - y4)) /
            ((y1 - y2) * (x3 - x4) - (x1 - x2) * (y3 - y4));
    return Point(x: pointX, y: pointY);
  }

  Path getPathAFromLowerRight() {
    pathA.reset();
    pathA.lineTo(0, _viewHeight); //移动到左下角
    pathA.lineTo(c.x, c.y); //移动到c点
    pathA.quadraticBezierTo(e.x, e.y, b.x, b.y); //从c到b画贝塞尔曲线，控制点为e
    pathA.lineTo(a.x, a.y); //移动到a点
    pathA.lineTo(k.x, k.y); //移动到k点
    pathA.quadraticBezierTo(h.x, h.y, j.x, j.y); //从k到j画贝塞尔曲线，控制点为h
    pathA.lineTo(_viewWidth, 0); //移动到右上角
    pathA.close(); //闭合区域
    return pathA;
  }

  Path getPathAFromTopRight() {
    pathA.reset();
    pathA.lineTo(c.x, c.y); //移动到c点
    pathA.quadraticBezierTo(e.x, e.y, b.x, b.y); //从c到b画贝塞尔曲线，控制点为e
    pathA.lineTo(a.x, a.y); //移动到a点
    pathA.lineTo(k.x, k.y); //移动到k点
    pathA.quadraticBezierTo(h.x, h.y, j.x, j.y); //从k到j画贝塞尔曲线，控制点为h
    pathA.lineTo(_viewWidth, _viewHeight); //移动到右下角
    pathA.lineTo(0, _viewHeight); //移动到左下角
    pathA.close();
    return pathA;
  }

  Path getPathDefault() {
    pathA.reset();
    pathA.lineTo(0, _viewHeight);
    pathA.lineTo(_viewWidth, _viewHeight);
    pathA.lineTo(_viewWidth, 0);
    pathA.close();
    return pathA;
  }

  Path getPathB() {
    pathB.reset();
    pathB.lineTo(0, _viewHeight); //移动到左下角
    pathB.lineTo(_viewWidth, _viewHeight); //移动到右下角
    pathB.lineTo(_viewWidth, 0); //移动到右上角
    pathB.close(); //闭合区域
    return pathB;
  }

  Path getPathC() {
    pathC.reset();
    pathC.moveTo(i.x, i.y); //移动到i点
    pathC.lineTo(d.x, d.y); //移动到d点
    pathC.lineTo(b.x, b.y); //移动到b点
    pathC.lineTo(a.x, a.y); //移动到a点
    pathC.lineTo(k.x, k.y); //移动到k点
    pathC.close(); //闭合区域
    return pathC;
  }

  double getViewWidth() => _viewWidth;

  double getViewHeight() => _viewHeight;

  void setDefaultPath() {
    aX = -1;
    aY = -1;
    a.x = aX;
    a.y = aY;
  }

  void setTouchPoint(double x, double y, SlideType type) {
    switch (type) {
      case SlideType.STYLE_TOP_RIGHT:
        f.x = _viewWidth;
        f.y = 0;
        break;
      case SlideType.STYLE_LOWER_RIGHT:
        f.x = _viewWidth;
        f.y = _viewHeight;
        break;
    }
    //如果大于0则设置a点坐标重新计算各标识点位置，否则a点坐标不变
    Point touchPoint = Point(x: x,y: y);
    if(_calcPointCX(touchPoint, f) > 0 ){
      aX = x;
      aY = y;
      a.x = aX;
      a.y = aY;
    }
    _calcPointsXY(a, f);
  }

  @override
  void paint(Canvas canvas, Size size) {
//    final pos = pageController.position;
//    double fullExtent = (pos.maxScrollExtent - pos.minScrollExtent + pos.viewportDimension);
//
//    double pageOffset = pos.extentBefore / fullExtent;
//    print("pageOffset is $pageOffset");
//    aX = pageOffset * _viewWidth;
//    aY = pageOffset * _viewHeight;
//    a.x = aX;
//    a.y = aY;
//    _drawText("a",canvas, Rect.fromLTRB(0, 0, a.x, a.y));
//    _drawText("f",canvas, Rect.fromLTRB(0, 0, f.x, f.y));
//    _drawText("g",canvas, Rect.fromLTRB(0, 0, g.x, g.y));
//
//
//    _drawText("e",canvas, Rect.fromLTRB(0, 0, e.x, e.y));
//    _drawText("h",canvas, Rect.fromLTRB(0, 0, h.x, h.y));
//
//    _drawText("c",canvas, Rect.fromLTRB(0, 0, c.x, c.y));
//    _drawText("j",canvas, Rect.fromLTRB(0, 0, j.x, j.y));
//
//    _drawText("b",canvas, Rect.fromLTRB(0, 0, b.x, b.y));
//    _drawText("k",canvas, Rect.fromLTRB(0, 0, k.x, k.y));
//
//
//    _drawText("d",canvas, Rect.fromLTRB(0, 0, d.x, d.y));
//    _drawText("i",canvas, Rect.fromLTRB(0, 0, i.x, i.y));
    canvas.drawPath(getPathB(), pointBPaint);
    print("ax is ${a.x}");

    if (a.x == -1 && a.y == -1) {
      canvas.drawPath(getPathDefault(), pointAPaint);
    } else {
      if (f.x == _viewWidth && f.y == 0) {
        canvas.drawPath(getPathAFromTopRight(), pointAPaint);
      } else {
        canvas.drawPath(getPathAFromLowerRight(), pointAPaint);
      }
      canvas.drawPath(getPathC(), pointCPaint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }

  _drawText(String text, Canvas canvas, Rect rect) {
    canvas.restore();
    var textPainter = TextPainter(
        text: TextSpan(text: text, style: TextStyle(fontSize: 10.0)),
        textAlign: TextAlign.end,
        textScaleFactor: 1,
        textDirection: TextDirection.ltr,
        maxLines: 1)
      ..layout(maxWidth: rect.width);

    textPainter.paint(
        canvas,
        Offset(rect.left + (rect.width - textPainter.width),
            rect.top + (rect.height - textPainter.height)));
    canvas.save();
  }
}
