import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:simple_animations/simple_animations.dart';


class FadeIn extends StatelessWidget {
  const FadeIn({Key key, this.delay, this.child}) : super(key: key);
  final double delay;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final tween = MultiTrackTween([
      Track("opacity").add(Duration(milliseconds: 350), Tween(begin: 0.0, end: 1.0)),
      Track("translateX").add(Duration(milliseconds: 350), Tween(begin: 130.0, end:0.0),curve: Curves.easeOut)
    ]);
    return ControlledAnimation(
      delay: Duration(milliseconds: (200* delay).round()),
      duration: tween.duration,
      tween: tween,
      child: child,
      builderWithChild: (context, child, animation) => Opacity(
        opacity: animation["opacity"],
        child: Transform.translate(
        offset: Offset(animation["translateX"], 0), child: child,
      ),)
    );
  }
}


class HeaderImageAnimation extends StatelessWidget {
  const HeaderImageAnimation({Key key, this.delay, this.child}) : super(key: key);
  final double delay;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final tween = MultiTrackTween([
      Track("opacity").add(Duration(milliseconds: 350), Tween(begin: 0.0, end: 1.0)),
      Track("sizeUp").add(Duration(milliseconds: 350), Tween(begin: 0.0, end: ScreenUtil.getInstance().setHeight(180),),curve: Curves.easeIn)
    ]);
    return ControlledAnimation(
      delay: Duration(milliseconds: (200* delay).round()),
      duration: tween.duration,
      tween: tween,
      child: child,
      builderWithChild: (context, child, animation) => Opacity(
        opacity: animation["opacity"],
        child: Container(child: child,
        height: animation["sizeUp"],
        width: animation["sizeUp"],),)
    );
  }
}

class RoundedCornerAnimation extends StatelessWidget {
  const RoundedCornerAnimation({Key key, this.delay, this.child}) : super(key: key);
  final double delay;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final tween = MultiTrackTween([
      Track("opacity").add(Duration(milliseconds: 350), Tween(begin: 0.0, end: 1.0)),
    ]);
    return ControlledAnimation(
      delay: Duration(milliseconds: (200* delay).round()),
      duration: tween.duration,
      tween: tween,
      child: child,
      builderWithChild: (context, child, animation) => Opacity(
        opacity: animation["opacity"],
        child: child,
      ),
    );
  }
}
