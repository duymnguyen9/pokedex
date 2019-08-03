import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';
import "dart:math" show pi;
import 'package:flutter/widgets.dart';

enum LoadingScreenType { pokemon, move }

class LoadingScreenBuild extends StatelessWidget {
  const LoadingScreenBuild({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final tween = MultiTrackTween([
      Track("opacity").add(
          Duration(milliseconds: 300), Tween(begin: 0.0, end: 1.0),
          curve: Curves.fastOutSlowIn),
      Track("size").add(
          Duration(milliseconds: 400), Tween(begin: 0.0, end: 1.0),
          curve: Curves.easeOutBack),
    ]);

    return ControlledAnimation(
        tween: tween,
        duration: tween.duration,
        playback: Playback.PLAY_FORWARD,
        delay: Duration(milliseconds: 200),
        child: LoadingScreen(),
        builderWithChild: (context, child, animation) {
          return Transform.scale(
            scale: animation["size"],
            child:LoadingScreen(),
          );
        });
  }
}

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final tween = MultiTrackTween([
      Track("bouncing").add(
          Duration(milliseconds: 500), Tween(begin: -60.0, end: 60.0),
          curve: Curves.easeIn),
      Track("rotate").add(
          Duration(milliseconds: 500), Tween(begin: -pi / 8, end: pi / 8),
          curve: Curves.easeIn),
      Track("shadow").add(
          Duration(milliseconds: 500), Tween(begin: 20.0, end: 50.0),
          curve: Curves.easeIn),
    ]);
    Size screenDimension = MediaQuery.of(context).size;
    return Stack(
      overflow: Overflow.visible,
      fit: StackFit.passthrough,
      children: <Widget>[
        Container(
          width: screenDimension.width,
          height: screenDimension.height,
          child: Stack(
            children: <Widget>[
              Positioned(
                top: 100,
                child: Container(
                  width: screenDimension.width,
                  child: Center(
                    child: Column(
                      children: <Widget>[
                        Container(
                          child: PokemonLogo(),
                        ),
                        Container(
                          child: Stack(
                            children: <Widget>[
                              Container(
                                alignment: Alignment.bottomCenter,
                                child: BouncingShadow(
                                  tween: tween,
                                ),
                              ),
                              Container(
                                alignment: Alignment.center,
                                child: PokeBallBouncingAnimation(
                                  tween: tween,
                                ),
                              ),
                            ],
                          ),
                          height: 170,
                          width: 150,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class BouncingShadow extends StatelessWidget {
  const BouncingShadow({
    Key key,
    @required this.tween,
  }) : super(key: key);

  final MultiTrackTween tween;

  @override
  Widget build(BuildContext context) {
    return ControlledAnimation(
      playback: Playback.MIRROR,
      child: ClipOval(
        child: Container(
          height: 10,
          width: 50,
          color: Colors.grey,
        ),
      ),
      duration: tween.duration,
      tween: tween,
      builderWithChild: (context, child, animation) => ClipOval(
        child: Container(
          height: 10,
          width: animation["shadow"],
          color: Colors.black45,
        ),
      ),
    );
  }
}

class PokeBallBouncingAnimation extends StatelessWidget {
  const PokeBallBouncingAnimation({
    Key key,
    @required this.tween,
  }) : super(key: key);

  final MultiTrackTween tween;

  @override
  Widget build(BuildContext context) {
    return ControlledAnimation(
      playback: Playback.MIRROR,
      duration: tween.duration,
      tween: tween,
      child: PokeBallLoading(),
      builderWithChild: (context, child, animation) => Transform.translate(
        offset: Offset(0, animation["bouncing"]),
        child: Transform.rotate(
            angle: animation["rotate"], child: PokeBallLoading()),
      ),
    );
  }
}

class PokeBallLoading extends StatelessWidget {
  const PokeBallLoading({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Image(
      image: AssetImage('assets/img/pokeball2.png'),
      width: 50,
      height: 50,
    ));
  }
}

class PokemonLogo extends StatelessWidget {
  const PokemonLogo({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(bottom: 30),
        child: Image(
          image: AssetImage('assets/img/pokemon_logo.png'),
          width: 300,
          height: 100,
        ));
  }
}
