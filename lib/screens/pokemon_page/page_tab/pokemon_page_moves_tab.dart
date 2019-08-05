import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pokedex/models/pokemon.dart';
import 'package:pokedex/components/pokemon_page/pokemon_page_comp.dart';
import 'package:pokedex/screens/loading_page.dart';
import 'package:pokedex/screens/pokemon_page/page_tab/pokemon_page_tab.dart';
import 'package:pokedex/components/animation/pokemon_page_animation.dart';
import 'package:pokedex/data/pokemon_color.dart';
import 'package:pokedex/components/animation/route_transition_animation.dart';
import 'package:pokedex/screens/pokemon_page/pokemon_page.dart';
import 'package:pokedex/services/http/pokemon_service.dart';


class PokemonMovesTab extends StatelessWidget {
  const PokemonMovesTab({Key key, this.pokemon})
      : super(key: key);
  final Pokemon pokemon;
  @override
  Widget build(BuildContext context) {
        screenSizeStatus("PokemonMovesTab", context);
        return Container(
      color: Color(0xFFffffff),
      child: TabPageViewContainer(
        tabKey: "MOVES",

        pageContent: SliverList(
                delegate: SliverChildListDelegate([MovesSection(pokemon: pokemon)]),
              )
        ),);
  }

}

class MovesSection extends StatelessWidget {
  const MovesSection({
    Key key,
    @required this.pokemon,
  }) : super(key: key);

  final Pokemon pokemon;
      PokemonPageUltility pokemonPageUltility() => PokemonPageUltility(pokemon);


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
    double delayCount= 0.5;
    for (var move in pokemonMovesSorted) {
      if (move.levelLearned !="0") {
              movesWidgetList.add( 
                FadeIn(delay: 0.5+ delayCount, child: MoveRowInkwell(pokemonMove: move)));
      movesWidgetList.add(movesSeparatorWidget);
      delayCount +=0.5;
      }
    }
    movesWidgetList.removeLast();

    return 
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[

    Container(
            padding: EdgeInsets.fromLTRB(
          ScreenUtil.getInstance().setWidth(15),
          ScreenUtil.getInstance().setHeight(0),
          ScreenUtil.getInstance().setWidth(15),
          ScreenUtil.getInstance().setHeight(0)),
      child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: movesWidgetList,
          ),
          
    ),
                        BottomTabRoundedCorner(pokemonColor: pokemonPageUltility().pokemonColor()),

                  ],
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

class MoveRowInkwell extends StatelessWidget {
  const MoveRowInkwell({Key key, this.pokemonMove}) : super(key: key);
  final PokemonMove pokemonMove;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
            String pokemonMoveName =
        upperCaseEveryWords(pokemonMove.name.replaceAll('-', ' '));
        String type = pokemonMovesWithType[pokemonMoveName.toLowerCase().replaceAll(" ", "")];
        Gradient pokemonGradient = pokemonColorsGradient[type];
        
        
        Navigator.push(context, 
        FadeRoute(
          page: 
          PokemonPage(
            loadingScreenType: LoadingScreenType.move,
            pokemonMoveServiceType: PokemonMoveServiceType.url,
            pokemonGradient: pokemonGradient,
            moveUrl: pokemonMove.url,
          )
        ));
      },
      child: MoveRowWidget(pokemonMove: pokemonMove,),
    );
  }
}