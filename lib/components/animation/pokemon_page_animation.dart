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
      Track("opacity").add(Duration(milliseconds: 250), Tween(begin: 0.0, end: 1.0)),
      Track("translateX").add(Duration(milliseconds: 250), Tween(begin: 130.0, end:0.0),curve: Curves.easeOut)
    ]);
    return ControlledAnimation(
      delay: Duration(milliseconds: (150* delay).round()),
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


class StatBarPanelAnimation extends StatelessWidget {
  const StatBarPanelAnimation({Key key, this.child, this.statValue, this.pokemonColor, this.pokemonGradient}) : super(key: key);
  final Widget child;
  final double statValue;
  final Color pokemonColor;
  final Gradient pokemonGradient;

  @override
  Widget build(BuildContext context) {
    final tween = MultiTrackTween([
      Track("fillup").add(Duration(milliseconds: 500), Tween(begin: ScreenUtil.getInstance().setHeight(15), end: statValue), curve: Curves.bounceOut),
    ]);
    return ControlledAnimation(
      delay: Duration(milliseconds: (1000).round()),
      duration: tween.duration,
      tween: tween,
      child: child,
      builderWithChild: (context, child, animation) => 
                     Container(
                height: ScreenUtil.getInstance().setHeight(8),
                width: animation["fillup"],
                decoration: BoxDecoration(
                     gradient: pokemonGradient,
                    color: pokemonColor,
                    borderRadius: BorderRadius.circular(
                        ScreenUtil.getInstance().setHeight(4))),
                        child:child,
              ),
      
    );
  }
}