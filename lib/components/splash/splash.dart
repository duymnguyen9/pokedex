import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: CustomPaint(
      foregroundPainter: PokeballPainter(),
      painter: GradientPainter(),
      child: Container(),
    ));
  }
}

class GradientPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var backgroundRect = Rect.fromLTWH(0, 0, size.width, size.height);
    final Gradient gradient = LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        stops: [
          -0.1,
          0.3,
          0.7,
          1.1
        ],
        colors: [
          const Color(0xff6E95FD),
          const Color(0xff6FDEFA),
          const Color(0xff8DE061),
          const Color(0xff51E85E),
        ]);
    final backgroundGradient = Paint()
      ..shader = gradient.createShader(backgroundRect);
    canvas.drawRect(backgroundRect, backgroundGradient);
  }

  @override
  bool shouldRepaint(GradientPainter oldDelegate) => false;

  @override
  bool shouldRebuildSemantics(GradientPainter oldDelegate) => false;
}

class PokeballPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var center = Offset(size.width / 2, size.height / 2);

    canvas.saveLayer(Offset.zero & size, Paint());
    canvas.drawColor(Color(0xCCFAFAFA), BlendMode.dstATop);

    final outerBall = Paint();
    //outerBall.color = Color(0x0DFAFAFA);
    outerBall.blendMode = BlendMode.clear;
    canvas.drawCircle(center, 52.5, outerBall);

    final rectangleLine = Paint();
    rectangleLine.color = Color(0xCCFAFAFA);
    var rect = Rect.fromLTWH(
        (size.width / 2) - 52.5, (size.height / 2) - 7.75, 105, 15.5);
    canvas.drawRect(rect, rectangleLine);

    final innerBallOutline = Paint();
    innerBallOutline.color = Color(0xCCFAFAFA);
    canvas.drawCircle(center, 20.5, innerBallOutline);

    final innerBall = Paint();
    innerBall.blendMode = BlendMode.clear;
    canvas.drawCircle(center, 14.5, innerBall);

    canvas.restore();
  }

  @override
  bool shouldRepaint(PokeballPainter oldDelegate) => false;

  @override
  bool shouldRebuildSemantics(PokeballPainter oldDelegate) => false;
}
