import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cached_network_image/cached_network_image.dart';


import 'package:pokedex/models/pokemon.dart';
import 'package:pokedex/components/pokemon_page/pokemon_page_comp.dart';

class PokemonEvolutionTab extends StatelessWidget {
  const PokemonEvolutionTab({Key key, this.pokemon, this.screenUtil})
      : super(key: key);
  final Pokemon pokemon;
  final ScreenUtil screenUtil;
    PokemonPageUltility pokemonPageUltility() =>
      PokemonPageUltility(pokemon);

  @override
  Widget build(BuildContext context) {
        Widget separatorWidget = Container(
        margin: EdgeInsets.fromLTRB(
            screenUtil.setWidth(25),
            screenUtil.setHeight(0),
            screenUtil.setWidth(25),
            screenUtil.setHeight(0)),
        decoration: BoxDecoration(
            border: Border(
          bottom: BorderSide(width: 0.3, color: Color(0xFFbdbdbd)),
        )));

    List<Widget> evolutionWidgets = [];
    evolutionWidgets.add(Container(height: screenUtil.setHeight(10),));
    for (var element in pokemon.evolutionList) {
      evolutionWidgets.add(evolutionSection(element));
      evolutionWidgets.add(separatorWidget);
    }
    return Container(
      color: Colors.white,
      height: 800,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: evolutionWidgets,
      ),
    );
  }

  Widget evolutionSection(Map<String, String> evolutionChain) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        evolutionSubSection(
            evolutionChain["name"], evolutionChain["id"]),
        Container(
          width: screenUtil.setWidth(100),
          height: screenUtil.setHeight(50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
            Text(
              evolutionChain["type"],
              style: TextStyle(
                  color: pokemonPageUltility().pokemonColor(),
                  fontFamily: "Avenir-Book",
                  height: 1.3,
                  fontSize: screenUtil.setSp(15),
                  fontWeight: FontWeight.w400),
            ),
            Image.asset(
            'assets/img/arrow.png',
            width: screenUtil.setWidth(100),
            height: screenUtil.setHeight(20),
          ),
          ],),
        ),
        evolutionSubSection(
            evolutionChain["evolvedName"], evolutionChain["idEvolved"]),
      ],
    );
  }

  Widget evolutionSubSection(String name, String id) {
    String imgUrl = 'https://assets.pokemon.com/assets/cms2/img/pokedex/full/' +
        id.padLeft(3, '0') +
        '.png';
    return Container(
      height: screenUtil.setHeight(180),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            CachedNetworkImage(
        imageUrl:imgUrl,
                      width: screenUtil.setWidth(90),
              height: screenUtil.setHeight(90),
        placeholder: (context, url) => CircularProgressIndicator(),
        errorWidget: (context, url, error) => Icon(Icons.error),
     ),
            Container(
              height: screenUtil.setHeight(15),
            ),
            Text(
              name,
              style: TextStyle(
                  color: Color(0xFF4F4F4F),
                  fontFamily: "Avenir-Book",
                  height: 1.3,
                  fontSize: screenUtil.setSp(15),
                  fontWeight: FontWeight.w300),
            ),
          ],
        ),
      ),
    );
  }
}
