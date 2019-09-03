import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';
import 'dart:async';

class FadeIn extends StatelessWidget {
  const FadeIn({Key key, this.delay, this.child}) : super(key: key);
  final double delay;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final tween = MultiTrackTween([
      Track("opacity")
          .add(Duration(milliseconds: 350), Tween(begin: 0.0, end: 1.0)),
      Track("translateX").add(
          Duration(milliseconds: 350), Tween(begin: 130.0, end: 0.0),
          curve: Curves.easeOut)
    ]);
    return ControlledAnimation(
        delay: Duration(milliseconds: (200 * delay).round()),
        duration: tween.duration,
        tween: tween,
        child: child,
        builderWithChild: (context, child, animation) => Opacity(
              opacity: animation["opacity"],
              child: Transform.translate(
                offset: Offset(animation["translateX"], 0),
                child: child,
              ),
            ));
  }
}

class ListItemAnimation extends StatelessWidget {
  const ListItemAnimation({Key key, this.child, this.index}) : super(key: key);
  final Widget child;
  final int index;

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    final tween = MultiTrackTween([
      Track("opacity")
          .add(Duration(milliseconds: 200), Tween(begin: 0.4, end: 1.0)),
      Track("translateY").add(
          Duration(milliseconds: 200), Tween(begin: screenHeight / 2, end: 0.0),
          curve: Curves.easeOut)
    ]);
    return ControlledAnimation(
      delay: Duration(milliseconds: 700+ (100* index)),
      duration: tween.duration,
      tween: tween,
      child: child,
      builderWithChild: (context, child, animation) => Opacity(
          opacity: animation["opacity"],
          child: Transform.translate(
            offset: Offset(0, animation["translateY"]),
            child: child,
          )),
    );
  }
}

class ListDelayAnimation extends StatelessWidget {
  const ListDelayAnimation({Key key, this.child}) : super(key: key);
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final tween = MultiTrackTween([
      Track("color").add(Duration(milliseconds: 450),
          ColorTween(begin: Colors.black, end: Colors.white)),
    ]);
    return ControlledAnimation(
      duration: tween.duration,
      tween: tween,
      child: child,
      builderWithChild: (context, child, animation) =>
          Container(color: animation["color"], child: child),
    );
  }
}

class PokemonBottomSheetAnimation extends StatelessWidget {
  const PokemonBottomSheetAnimation(
      {Key key, this.child, this.startPosition, this.endPosition})
      : super(key: key);
  final Widget child;
  final double startPosition;
  final double endPosition;

  @override
  Widget build(BuildContext context) {
    return ControlledAnimation(
      duration: Duration(milliseconds: 500),
      delay: Duration(seconds: 1),
      tween: Tween(begin: startPosition, end: endPosition),
      curve: Curves.easeOut,
      builder: (context, value) => Positioned(
        top: value,
        child: Container(
          child: child,
        ),
      ),
    );
  }
}

class BottomPanelAnimation extends StatefulWidget {
  BottomPanelAnimation(
      {Key key, this.child, this.startPosition, this.endPosition})
      : super(key: key);
  final Widget child;
  final double startPosition;
  final double endPosition;
  _BottomPanelAnimationState createState() => _BottomPanelAnimationState();
}

class _BottomPanelAnimationState extends State<BottomPanelAnimation>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

  Animation<RelativeRect> positionedAnimation;

  bool shouldStart = false;

  @override
  initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    positionedAnimation = RelativeRectTween(
      begin: RelativeRect.fromLTRB(0, widget.startPosition, 0, 0),
      end: RelativeRect.fromLTRB(0, widget.endPosition, 0,
          (widget.startPosition - widget.endPosition)),
      //       begin:  RelativeRect.fromLTRB(0, 200, 0, 0),
      // end:  RelativeRect.fromLTRB(0, widget.endPosition, 0, -400),
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic))
      ..addListener(() {
        setState(() {});
      });
    animationdelay();
  }

  void animationdelay() async {
    await Future.delayed(Duration(seconds: 1));
    _controller.forward();
  }

  @override
  dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PositionedTransition(
      rect: positionedAnimation,
      child: widget.child,
    );
  }
}


class DelayWrapper extends StatefulWidget {
  DelayWrapper({Key key, this.delay,@required this.child, this.waiting}) : super(key: key);
  final Duration delay;
  final Widget child;
  final Widget waiting;

  _DelayWrapperState createState() => _DelayWrapperState();
}

class _DelayWrapperState extends State<DelayWrapper> {
  bool isCompleted = false;
  @override
  void initState(){
    if(widget.delay == null){
      setState(() {
        isCompleted = true;
      });
    }
    else{
      animationDelay(widget.delay);
    }
    super.initState();
  }
  void animationDelay(Duration delay) async {
    await Future.delayed(delay);
    setState(() {
            isCompleted = true;
    });
  }
  Widget isCompletedWidget(){
    if(isCompleted){
      return widget.child;
    }
    else{
      return widget.waiting;
    }
  }

  @override
  Widget build(BuildContext context) {
    return isCompletedWidget();
  }
}

