import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pokedex/models/pokemon.dart';
import 'package:pokedex/components/pokemon_page/pokemon_page_comp.dart';

class PokemonMovesTab extends StatelessWidget {
  const PokemonMovesTab({Key key, this.pokemon, this.screenUtil})
      : super(key: key);
  final Pokemon pokemon;
  final ScreenUtil screenUtil;
    PokemonPageUltility pokemonPageUltility() =>
      PokemonPageUltility(pokemon);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: movesSection(),
    );
  }

    Widget movesSection() {
    Widget movesSeparatorWidget = Container(
        margin: EdgeInsets.fromLTRB(
            screenUtil.setWidth(0),
            screenUtil.setHeight(10),
            screenUtil.setWidth(0),
            screenUtil.setHeight(10)),
        decoration: BoxDecoration(
            border: Border(
          bottom: BorderSide(width: 0.3, color: Color(0xFFbdbdbd)),
        )));
    List<PokemonMove> pokemonMovesSorted = pokemon.moves;
    pokemonMovesSorted.sort((a, b) => int.parse(a.levelLearned).compareTo(int.parse(b.levelLearned)));
    List<Widget> movesWidgetList = [];
    for (var move in pokemonMovesSorted) {
      if (move.levelLearned !="0") {
              movesWidgetList.add(moveRow(move));
      movesWidgetList.add(movesSeparatorWidget);
      }

    }
    movesWidgetList.removeLast();
    return Container(
            margin: EdgeInsets.fromLTRB(
          screenUtil.setWidth(10),
          screenUtil.setHeight(0),
          screenUtil.setWidth(10),
          screenUtil.setHeight(0)),
      child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: movesWidgetList,
          ),
    );
  }
  


   Widget moveRow(PokemonMove pokemonMove) {
    String pokemonMoveName =
        upperCaseEveryWords(pokemonMove.name.replaceAll('-', ' '));
    String levelLearned = "Level " + pokemonMove.levelLearned;
    String imgDirectory = 'assets/img/type/' + pokemonMovesWithType[pokemonMoveName.toLowerCase().replaceAll(" ", "")]+ ".png";
    return Container(
      margin: EdgeInsets.fromLTRB(
          screenUtil.setWidth(10),
          screenUtil.setHeight(5),
          screenUtil.setWidth(10),
          screenUtil.setHeight(5)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                child: 
                    Text(
                      pokemonMoveName,
                      style: TextStyle(
                          color: Color(0xFF4F4F4F),
                          fontFamily: "Avenir-Medium",
                          height: 1.3,
                          fontSize: screenUtil.setSp(19),
                          fontWeight: FontWeight.w500),
                    ),
              ),
              Container(
                child: Text(
                  levelLearned,
                  style: TextStyle(
                      color: Color(0xFFA4A4A4),
                      fontFamily: "Avenir-Book",
                      height: 1.3,
                      fontSize: screenUtil.setSp(15),
                      fontWeight: FontWeight.w300),
                ),
              )
            ],
          ),
          Container(
             child:           Image.asset(
            imgDirectory,
            width: screenUtil.setWidth(40),
            height: screenUtil.setHeight(40),
          ),
          )
        ],
      ),
    );
  }

}