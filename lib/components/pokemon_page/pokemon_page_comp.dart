import 'package:flutter/material.dart';
import 'package:pokedex/models/pokemon.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pokedex/data/pokemon_color.dart';

class BottomTabRoundedCorner extends StatelessWidget {
  const BottomTabRoundedCorner({Key key, this.pokemonColor}) : super(key: key);
  final Color pokemonColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil.getInstance().setHeight(70),
      width: MediaQuery.of(context).size.width,
      child: Stack(
        children: <Widget>[
          Container(
            height: ScreenUtil.getInstance().setHeight(70),
            width: MediaQuery.of(context).size.width,
            color: pokemonColor,
          ),
          Container(
            height: ScreenUtil.getInstance().setHeight(47),
            width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                color: Color(0xFFFAFAFA),
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(ScreenUtil().setHeight(45)),
                    bottomRight: Radius.circular(ScreenUtil().setHeight(45))))
            )
        ],
      ),
    );
  }
}

void screenSizeStatus(String widgetname, BuildContext context) {
  print(widgetname);
  if (ScreenUtil.getInstance().height == 812.0) {
    print("screenSizeStatus: matches!");
  } else {
    print("screen height is " + MediaQuery.of(context).size.height.toString());
    print("iphoneX height supposed to be 812: " +
        ScreenUtil.getInstance().height.toString());
    print("If this is not iphone X, value of 25 is: " +
        (ScreenUtil.getInstance().setWidth(25)).toString());
  }
}

void screenSizeConfiguration(
    BuildContext context, double screenwidth, double screenHeight) {
  ScreenUtil.instance = ScreenUtil(
    width: screenwidth,
    height: screenHeight,
    allowFontScaling: true,
  )..init(context);
  print("default Screen Height: " + ScreenUtil.getInstance().height.toString());
  print(
      "actual Screen Height: " + MediaQuery.of(context).size.height.toString());
}

class PokemonPageUltility {
  final Pokemon pokemon;

  String getPrimaryType() =>
      pokemon.types.firstWhere((type) => type.slot == 1).typeName;

  Gradient pokemonColorGradient() {
    return pokemonColorsGradient[getPrimaryType().toLowerCase()];
  }

  Color pokemonColor() => pokemonColors[getPrimaryType().toLowerCase()];


  String getPokemonTypeDirectory() {
    String baseDirectory = 'assets/img/tag/';
    return baseDirectory + getPrimaryType() + '.png';
  }

  PokemonPageUltility(this.pokemon);
}

