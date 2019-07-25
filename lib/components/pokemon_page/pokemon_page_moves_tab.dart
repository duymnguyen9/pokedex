import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pokedex/models/pokemon.dart';
import 'package:pokedex/components/pokemon_page/pokemon_page_comp.dart';
import 'package:pokedex/components/pokemon_page/pokemon_page_tab.dart';


class PokemonMovesTab extends StatelessWidget {
  const PokemonMovesTab({Key key, this.pokemon})
      : super(key: key);
  final Pokemon pokemon;
  @override
  Widget build(BuildContext context) {
        screenSizeStatus("PokemonMovesTab", context);
        return Container(
      color: Color(0xFFFAFAFA),
      child: TabPageViewContainer(
        tabKey: "MOVES",
        pageContent: [MovesSection(pokemon: pokemon)],),);
  }

}

class MovesSection extends StatelessWidget {
  const MovesSection({
    Key key,
    @required this.pokemon,
  }) : super(key: key);

  final Pokemon pokemon;

  @override
  Widget build(BuildContext context) {
    Widget movesSeparatorWidget = Container(
        margin: EdgeInsets.fromLTRB(
            ScreenUtil.getInstance().setWidth(0),
            ScreenUtil.getInstance().setHeight(10),
            ScreenUtil.getInstance().setWidth(0),
            ScreenUtil.getInstance().setHeight(10)),
        decoration: BoxDecoration(
            border: Border(
          bottom: BorderSide(width: 0.3, color: Color(0xFFbdbdbd)),
        )));
    List<PokemonMove> pokemonMovesSorted = pokemon.moves;
    pokemonMovesSorted.sort((a, b) => int.parse(a.levelLearned).compareTo(int.parse(b.levelLearned)));
    List<Widget> movesWidgetList = [];
    for (var move in pokemonMovesSorted) {
      if (move.levelLearned !="0") {
              movesWidgetList.add(new MoveRowWidget(pokemonMove: move));
      movesWidgetList.add(movesSeparatorWidget);
      }

    }
    movesWidgetList.removeLast();
    return Container(
            margin: EdgeInsets.fromLTRB(
          ScreenUtil.getInstance().setWidth(10),
          ScreenUtil.getInstance().setHeight(0),
          ScreenUtil.getInstance().setWidth(10),
          ScreenUtil.getInstance().setHeight(0)),
      child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: movesWidgetList,
          ),
    );
  }
}

class MoveRowWidget extends StatelessWidget {
  const MoveRowWidget({
    Key key,
    @required this.pokemonMove,
  }) : super(key: key);

  final PokemonMove pokemonMove;

  @override
  Widget build(BuildContext context) {
    String pokemonMoveName =
        upperCaseEveryWords(pokemonMove.name.replaceAll('-', ' '));
    String levelLearned = "Level " + pokemonMove.levelLearned;
    String imgDirectory = 'assets/img/type/' + pokemonMovesWithType[pokemonMoveName.toLowerCase().replaceAll(" ", "")]+ ".png";
    return Container(
      margin: EdgeInsets.fromLTRB(
          ScreenUtil.getInstance().setWidth(10),
          ScreenUtil.getInstance().setHeight(5),
          ScreenUtil.getInstance().setWidth(10),
          ScreenUtil.getInstance().setHeight(5)),
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
                          fontSize: ScreenUtil.getInstance().setSp(19),
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
                      fontSize: ScreenUtil.getInstance().setSp(15),
                      fontWeight: FontWeight.w300),
                ),
              )
            ],
          ),
          Container(
             child:           Image.asset(
            imgDirectory,
            width: ScreenUtil.getInstance().setWidth(40),
            height: ScreenUtil.getInstance().setHeight(40),
          ),
          )
        ],
      ),
    );
  }
}