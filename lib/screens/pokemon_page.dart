//Flutter Package
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

//Addition Package
import 'package:flutter_screenutil/flutter_screenutil.dart';

//Internal Package
import 'package:pokedex/models/pokemon.dart';
import 'package:pokedex/components/pokemon_page/pokemon_page_comp.dart';
import 'package:pokedex/components/pokemon_page/pokemon_page_tab.dart';

class PokemonPage extends StatelessWidget {
  const PokemonPage({Key key, this.pokemon}) : super(key: key);
  final Pokemon pokemon;

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
    return PokemonPageBuild(
      pokemon: pokemon,
      screenUtil: ScreenUtil.instance,
    );
  }
}

class PokemonPageBuild extends StatelessWidget {
  const PokemonPageBuild({Key key, this.pokemon, this.screenUtil})
      : super(key: key);
  final Pokemon pokemon;
  final ScreenUtil screenUtil;
  PokemonPageUltility pokemonPageUltility() => PokemonPageUltility(pokemon);

  @override
  Widget build(BuildContext context) {
    Gradient pokemonColorGradient =
        pokemonPageUltility().pokemonColorGradient();
    return Container(
      decoration: BoxDecoration(gradient: pokemonColorGradient),
      child: SingleChildScrollView(child: pageContent(context)),
    );
  }

  Widget pageContent(BuildContext context) {
    return Column(
      children: <Widget>[
        Stack(
          children: <Widget>[
            Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.circular(screenUtil.setWidth(48))),
                margin: EdgeInsets.only(top: screenUtil.setHeight(222)),
                child: cardContent(context)),
            Container(
                margin: EdgeInsets.only(top: screenUtil.setHeight(90)),
                child: Center(
                  // child: Placeholder(
                  //   fallbackWidth: screenUtil.setWidth(180),
                  //   fallbackHeight: screenUtil.setHeight(180),
                  // ),
                  child: Image.network(
                    pokemon.imgUrl,
                    width: screenUtil.setWidth(180),
                    height: screenUtil.setHeight(180),
                  ),
                )),
          ],
        ),
        Container(
          height: 30,
        )
      ],
    );
  }

  Widget cardContent(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(top: screenUtil.setHeight(57), bottom: screenUtil.setHeight(10)),
          width: size.width,
          child: Center(
            child: Text(
                pokemon.name[0].toUpperCase() + pokemon.name.substring(1),
                style: TextStyle(
                    fontFamily: 'Avenir-Book',
                    fontSize: screenUtil.setSp(40.0),
                    color: Color(0xFF4F4F4F),
                    fontWeight: FontWeight.w100)),
          ),
        ),

        pokemonTypePanel(),
        pokemonDescriptionPanel(),

        //TODO: Stats, Evolutions, and Moves Panel
        PokemonTabPanel(
          pokemon: pokemon,
          screenUtil: screenUtil,
        ),
      ],
    );
  }

  Widget pokemonTypePanel() {
    String pokemonTypeDirectory =
        pokemonPageUltility().getPokemonTypeDirectory();
    return Container(
        height: screenUtil.setHeight(50),
        child: Center(
            child: Image.asset(
          pokemonTypeDirectory,
          width: screenUtil.setWidth(120),
          height: screenUtil.setHeight(40),
        )));
  }

  Widget pokemonDescriptionPanel() {
    return Container(
      padding: EdgeInsets.all(screenUtil.setWidth(18)),
      child: Center(
        child: Text(pokemon.description,
            softWrap: true,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontFamily: 'Avenir-Book',
                fontSize: screenUtil.setSp(14),
                color: Color(0xFF4F4F4F),
                fontWeight: FontWeight.w100,
                height: 1.2)),
      ),
    );
  }
}
