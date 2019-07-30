import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';

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
  const ListItemAnimation({Key key, this.child}) : super(key: key);
  final Widget child;

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    final tween = MultiTrackTween([
      Track("opacity")
          .add(Duration(milliseconds: 400), Tween(begin: 0.0, end: 1.0)),
      Track("translateY").add(
          Duration(milliseconds: 400), Tween(begin: screenHeight / 2, end: 0.0),
          curve: Curves.easeOut)
    ]);
    return ControlledAnimation(
      delay: Duration(milliseconds: 150),
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
  const ListDelayAnimation({Key key,  this.child}) : super(key: key);
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final tween = MultiTrackTween([
      Track("color")
          .add(Duration(milliseconds: 450), ColorTween(begin: Colors.black, end: Colors.white)),

    ]);
    return ControlledAnimation(
      duration: tween.duration,
      tween: tween,
      child: child,
      builderWithChild: (context, child, animation) => Container(color: animation["color"],child: child),
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
    final tween = MultiTrackTween([
      Track("moveDown").add(Duration(milliseconds: 500),
          Tween(begin: startPosition, end: endPosition),
          curve: Curves.easeOut),
    ]);

    return ControlledAnimation(
      duration: tween.duration,
      tween: tween,
      child: child,
      builderWithChild: (context, child, animation) => Positioned(
        top: animation["moveDown"],
        child: Container(
          child: child,
        ),
      ),
    );
  }
}
