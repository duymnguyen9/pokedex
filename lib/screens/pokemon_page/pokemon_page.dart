//Flutter Package
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

//Addition Package
import 'package:flutter_screenutil/flutter_screenutil.dart';

//Internal Package
import 'package:pokedex/models/pokemon.dart';
import 'package:pokedex/components/pokemon_page/pokemon_page_comp.dart';
import 'package:pokedex/screens/pokemon_page/pokemon_page_header.dart';
import 'package:simple_animations/simple_animations.dart';



const double pokemonSheetTopPosition = 222;

class PokemonPage extends StatelessWidget {
  const PokemonPage({Key key, this.pokemon}) : super(key: key);
  final Pokemon pokemon;
  PokemonPageUltility pokemonPageUltility() => PokemonPageUltility(pokemon);

  @override
  Widget build(BuildContext context) {
    //Set up Resolution Scaling depending on user's device resolutions
    double defaultScreenWidth = 375.0;
    double defaultScreenHeight = 812.0;

    ScreenUtil.instance = ScreenUtil(
      width: defaultScreenWidth,
      height: defaultScreenHeight,
      allowFontScaling: true,
    )..init(context);
    ScreenUtil screenUtil = ScreenUtil.instance;

    print(pokemon.types[0].typeName);
    return Material(
      elevation: 5,
        child: Stack(
      children: <Widget>[
        Container(
            height: screenUtil.setHeight(screenUtil.height),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                gradient: pokemonPageUltility().pokemonColorGradient())),
        AnimatedBottomSheet(
          screenUtil: screenUtil
        ),

        PokemonPageHeader(pokemon: pokemon,)
      ],
    ));
  }
}

class AnimatedBottomSheet extends StatelessWidget {
  AnimatedBottomSheet({Key key, this.screenUtil}) : super(key: key);

  final ScreenUtil screenUtil;



  @override
  Widget build(BuildContext context) {
    MultiTrackTween tween = MultiTrackTween([
    Track("sheetPosition").add(
        Duration(milliseconds: 500),
        Tween(begin: screenUtil.setHeight(screenUtil.height), end: screenUtil.setHeight(pokemonSheetTopPosition)),
        curve: Curves.easeOut)
        
  ]);
    return ControlledAnimation(
      playback: Playback.PLAY_FORWARD,
      duration: tween.duration,
      tween:tween,


      builder: (context, animation){
        return Positioned(
          top: animation["sheetPosition"],
        child: Container(
            height: screenUtil.setHeight(screenUtil.height),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                color: Color(0xFFFAFAFA),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(ScreenUtil().setHeight(45)),
                    topRight: Radius.circular(ScreenUtil().setHeight(45))))),
      );
      },
    );
  }
}
