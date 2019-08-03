import 'package:flutter/material.dart';

class PokedexTopPanel extends StatelessWidget {
  const PokedexTopPanel({
    Key key,
    @required this.topBarHeight,
  }) : super(key: key);

  final double topBarHeight;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: PokedexTopPainter(),
      size: Size(
        MediaQuery.of(context).size.width,
        topBarHeight,
      ),
    );
  }
}

class PokeDexBottom extends StatelessWidget {
  const PokeDexBottom({
    Key key,
    @required this.topBarHeight,
  }) : super(key: key);

  final double topBarHeight;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height - (topBarHeight/2),
        width: MediaQuery.of(context).size.width,
        child: Stack(
                    overflow: Overflow.visible,

          children: <Widget>[
            Positioned(
              top: 0,
              left: 0,
                          child: CustomPaint(
                painter: PokedexBottomPainter(topBarHeight: topBarHeight),
                size: Size(
                  MediaQuery.of(context).size.width,
                  MediaQuery.of(context).size.height - (topBarHeight/2),
                ),
              ),
            ),
            Positioned(
              top: topBarHeight / 10,
              left: ((8* MediaQuery.of(context).size.width)/10)- 5,
              child: Container(
                width: (2* MediaQuery.of(context).size.width)/10,
                child: Image.asset(
                  "assets/img/pokeball2.png",
                  width: topBarHeight / 2,
                  height: topBarHeight / 2,
                ),
              ),
            )
          ],
        )
        );
  }
}

class PokedexTopPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    double setRelativeWidth(double value) {
      return value * size.width / 100;
    }

    double setRelativeHeight(double value) {
      return value * size.height / 17;
    }

    //Variable Declaration
    final topHeight = size.height - 10;
    final curvePointX1 = setRelativeWidth(60);
    final curveMidPointX2 = setRelativeWidth(70);
    final curvePointY2 = setRelativeHeight(13) - 10;
    final curvePointX2 = setRelativeWidth(80);
    final double blueLightLocationX = setRelativeWidth(15);
    final double blueLightLocationY = setRelativeHeight(8);
    final double blueLightRadius = setRelativeHeight(3.5);
    final double smallLightRadius = setRelativeHeight(1.5);
    final double smallLightLocationY =
        blueLightLocationY - blueLightRadius + smallLightRadius + 5;
    final double smallLightLocationX = setRelativeWidth(30);

    void drawSeparator() {
      final double separatorHeight = (size.height / 5);

      Path topSeparatorPath() {
        Path pathOutput = Path();

        pathOutput.moveTo(0, topHeight + separatorHeight);

        pathOutput.lineTo(0, topHeight);
        pathOutput.lineTo(curvePointX1, topHeight);
        pathOutput.cubicTo(curveMidPointX2, topHeight, curveMidPointX2,
            curvePointY2, curvePointX2, curvePointY2);
        pathOutput.lineTo(size.width, curvePointY2);

        pathOutput.lineTo(size.width, curvePointY2 + separatorHeight);
        pathOutput.lineTo(curvePointX2, curvePointY2 + separatorHeight);
        pathOutput.cubicTo(
            curveMidPointX2,
            curvePointY2 + separatorHeight,
            curveMidPointX2,
            topHeight + separatorHeight,
            curvePointX1,
            topHeight + separatorHeight);
        pathOutput.lineTo(0, topHeight + separatorHeight);

        return pathOutput;
      }

      final outlineBorder = Paint()..color = Color(0xFFA20006);

      canvas.drawShadow(topSeparatorPath(), Color(0xFF000000), 4, true);

      canvas.drawPath(topSeparatorPath(), outlineBorder);
    }

    void drawBackgroundTop() {
      Path backgroundPath() {
        Path basePath = Path();
        basePath.lineTo(0, topHeight);
        basePath.lineTo(curvePointX1, topHeight);
        basePath.cubicTo(curveMidPointX2, topHeight, curveMidPointX2,
            curvePointY2, curvePointX2, curvePointY2);
        basePath.lineTo(size.width, curvePointY2);
        basePath.lineTo(size.width, 0);
        return basePath;
      }

      Gradient backgroundGradient = LinearGradient(
        // Where the linear gradient begins and ends
        begin: Alignment.topRight,
        end: Alignment.bottomLeft,
        stops: [0.4, 0.8],
        colors: [
          // Colors are easy thanks to Flutter's Colors class.
          Color(0XFFC00009),
          Color(0xFFF1020D),
        ],
      );
      Rect gradientBox = Rect.fromLTWH(0, 0, size.width, topHeight);
      final basePaint = Paint()
        ..shader = backgroundGradient.createShader(gradientBox);

      canvas.drawPath(backgroundPath(), basePaint);
    }

    void drawBlueLight() {
      final blueLightOutline = Paint()..color = Colors.white;
      final Offset blueLightLocation =
          Offset(blueLightLocationX, blueLightLocationY);
      final blueLightPaint = Paint()..color = Color(0xFF01A9D9);

      final Offset shinyLocation =
          Offset(blueLightLocationX, blueLightLocationY + blueLightRadius / 2);
      final shinyPaint = Paint()..color = Color(0xC8FEFCFB);
      Path path = Path()
        ..addOval(Rect.fromCircle(
            center: blueLightLocation, radius: blueLightRadius));
      canvas.drawShadow(path, Colors.black87, 5, true);
      canvas.drawCircle(blueLightLocation, blueLightRadius, blueLightOutline);
      canvas.drawCircle(blueLightLocation, blueLightRadius - 5, blueLightPaint);
      canvas.drawCircle(shinyLocation, 4, shinyPaint);
    }

    void drawSmallLight({double index, Color color}) {
      final light = Paint()..color = color;
      Offset smallLightLocation = Offset(
          smallLightLocationX + (3 * (index - 1)) * smallLightRadius,
          smallLightLocationY);

      final borderlight = Paint()..color = Colors.white30;
      Path path = Path()
        ..addOval(Rect.fromCircle(
            center: smallLightLocation, radius: smallLightRadius));
      canvas.drawShadow(path, Colors.black87, 3, true);
      canvas.drawCircle(smallLightLocation, smallLightRadius, borderlight);
      canvas.drawCircle(smallLightLocation, smallLightRadius - 2, light);
    }

    drawBackgroundTop();
    drawSeparator();
    drawBlueLight();
    drawSmallLight(index: 1.0, color: Color(0xFFd50000));
    drawSmallLight(index: 2.0, color: Color(0xFFFFD63D));
    drawSmallLight(index: 3.0, color: Color(0xFF7FEC55));
  }

  @override
  bool shouldRepaint(PokedexTopPainter oldDelegate) => false;

  @override
  bool shouldRebuildSemantics(PokedexTopPainter oldDelegate) => false;
}

class PokedexBottomPainter extends CustomPainter {
  final double topBarHeight;

  PokedexBottomPainter({this.topBarHeight});
  @override
  void paint(Canvas canvas, Size size) {
    double setRelativeWidth(double value) {
      return value * size.width / 100;
    }

    double setRelativeHeight(double value) {
      return value * topBarHeight / 17;
    }

    //Variable Declaration
    final topHeight = topBarHeight - setRelativeHeight(13);
    final curvePointX1 = setRelativeWidth(60);
    final curveMidPointX2 = setRelativeWidth(70);
    final curvePointY2 = 0.0;
    final curvePointX2 = setRelativeWidth(80);

    void drawBackgroundTop() {
      Path backgroundPath() {
        Path basePath = Path();
        basePath.moveTo(0, topHeight);
        basePath.lineTo(curvePointX1, topHeight);
        basePath.cubicTo(curveMidPointX2, topHeight, curveMidPointX2,
            curvePointY2, curvePointX2, curvePointY2);
        basePath.lineTo(size.width, curvePointY2);
        basePath.lineTo(size.width, size.height);
        basePath.lineTo(0, size.height);
        return basePath;
      }

      Gradient backgroundGradient = LinearGradient(
        // Where the linear gradient begins and ends
        begin: Alignment.bottomRight,
        end: Alignment.topLeft,
        stops: [0.4, 0.8],
        colors: [
          // Colors are easy thanks to Flutter's Colors class.
          Color(0XFFC00009),
          Color(0xFFF1020D),
        ],
      );
      Rect gradientBox = Rect.fromLTWH(0, 0, size.width, topHeight);
      final basePaint = Paint()
        ..shader = backgroundGradient.createShader(gradientBox);
      canvas.drawShadow(backgroundPath().shift(Offset(0, - setRelativeHeight(2))), Colors.black87, 4, true);
      canvas.drawPath(backgroundPath(), basePaint);
    }

    void drawTriangleMid() {
      final double topTriangleX = size.width / 40;
      final double topTriangleY = size.height / 2;
      final double rightTriangleSideX = size.width / 10;
      final double triangleSideHeight = topTriangleY + size.height / 10;
      final double triangleSideWidth = topTriangleY + size.height / 20;

      Path trianglePath = Path();
      trianglePath.moveTo(topTriangleX, topTriangleY);
      trianglePath.lineTo(topTriangleX, triangleSideHeight);
      trianglePath.lineTo(rightTriangleSideX, triangleSideWidth);
      trianglePath.lineTo(topTriangleX, size.height / 2);
      trianglePath.close();
      final Paint trianglePaint = Paint()..color = Color(0xFFff8f00);
      canvas.drawShadow(trianglePath, Colors.black, 5, true);

      canvas.drawPath(trianglePath, trianglePaint);
    }

    void drawBottomOvalRing() {
      Radius radius = Radius.circular(size.height / 40);
      RRect rectangle = RRect.fromLTRBR(
          2 * size.width / 10,
          16 * size.height / 20,
          8 * size.width / 10,
          17 * size.height / 20,
          radius);
      Paint ovalRingPaint = Paint()
        ..color = Color(0xFFA20006)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 5.0;

      canvas.drawRRect(rectangle, ovalRingPaint);
    }

    drawBackgroundTop();
    drawTriangleMid();
    drawBottomOvalRing();
  }

  @override
  bool shouldRepaint(PokedexBottomPainter oldDelegate) => false;

  @override
  bool shouldRebuildSemantics(PokedexBottomPainter oldDelegate) => false;
}
