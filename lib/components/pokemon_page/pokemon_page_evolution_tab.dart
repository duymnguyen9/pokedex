import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:pokedex/models/pokemon.dart';
import 'package:pokedex/components/pokemon_page/pokemon_page_comp.dart';
import 'package:pokedex/components/pokemon_page/pokemon_page_tab.dart';
import 'package:pokedex/services/http/pokemon_service.dart';
import 'package:pokedex/components/splash/splash.dart';
import 'package:pokedex/screens/pokemon_page/pokemon_page.dart';
import 'package:pokedex/components/animation/route_transition_animation.dart';


class PokemonEvolutionTab extends StatelessWidget {
  const PokemonEvolutionTab({Key key,@required this.pokemon,@required this.pokemonColor})
      : super(key: key);
  final Pokemon pokemon;
  final Color pokemonColor;

  @override
  Widget build(BuildContext context) {
    screenSizeStatus("PokemonPageStatTab", context);
    List<Widget> evolutionWidgets = [];
    evolutionWidgets.add(Container(
      height: ScreenUtil.getInstance().setHeight(10),
    ));
    for (var element in pokemon.evolutionList) {
      evolutionWidgets.add(EvolutionSection(
          evolutionChain: element,
          pokemonColor: pokemonColor));
      evolutionWidgets.add(EvolutionSeparatorWidget());
    }
    screenSizeStatus("PokemonPageStatTab", context);
    return Container(
      color: Color(0xFFFAFAFA),
      child: TabPageViewContainer(
        tabKey: "EVOLUTIONS",
        pageContent: evolutionWidgets,),);
  }
}

class EvolutionSeparatorWidget extends StatelessWidget {
  const EvolutionSeparatorWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.fromLTRB(
            ScreenUtil.getInstance().setWidth(25),
            ScreenUtil.getInstance().setHeight(0),
            ScreenUtil.getInstance().setWidth(25),
            ScreenUtil.getInstance().setHeight(0)),
        decoration: BoxDecoration(
            border: Border(
          bottom: BorderSide(width: 0.3, color: Color(0xFFbdbdbd)),
        )));
  }
}

class EvolutionSection extends StatelessWidget {
  const EvolutionSection({
    Key key,
    @required this.evolutionChain,
    @required this.pokemonColor,
  }) : super(key: key);

  final Map<String, String> evolutionChain;
  final Color pokemonColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        new EvolutionSubSection(
            name: evolutionChain["name"],
            id: evolutionChain["id"]),
        Container(
          width: ScreenUtil.getInstance().setWidth(100),
          height: ScreenUtil.getInstance().setHeight(50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                evolutionChain["type"],
                style: TextStyle(
                    color: pokemonColor,
                    fontFamily: "Avenir-Book",
                    height: 1.3,
                    fontSize: ScreenUtil.getInstance().setSp(15),
                    fontWeight: FontWeight.w400),
              ),
              Image.asset(
                'assets/img/arrow.png',
                width: ScreenUtil.getInstance().setWidth(100),
                height: ScreenUtil.getInstance().setHeight(20),
              ),
            ],
          ),
        ),
        new EvolutionSubSection(
            name: evolutionChain["evolvedName"],
            id: evolutionChain["idEvolved"]),
      ],
    );
  }
}

class EvolutionSubSection extends StatelessWidget {
  const EvolutionSubSection({
    Key key,
    @required this.name,
    @required this.id,
  }) : super(key: key);

  final String name;
  final String id;

  @override
  Widget build(BuildContext context) {
    String imgUrl = 'https://assets.pokemon.com/assets/cms2/img/pokedex/full/' +
        id.padLeft(3, '0') +
        '.png';
    return InkWell(
      onTap: () {
        var navigateRoute = FutureBuilder<Pokemon>(
          future: PokemonService(pokemonID: int.parse(id)
).fetchPokemon(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return PokemonPage(pokemon: snapshot.data);
            } else if (snapshot.hasError) {
              return Container(
                  padding: EdgeInsets.all(30),
                  child: Text(
                    "${snapshot.error}",
                    style: TextStyle(fontSize: 12),
                  ));
            }
            // By default, show a loading spinner.
            return Stack(
              children: <Widget>[
                SplashScreen(),
                Center(
                  child: Container(
                      child: Image(
                    image: AssetImage('assets/img/pokeball_loading.gif'),
                  )),
                ),
              ],
            );
          },
        );

        Navigator.push(
          context,
          SlideUpRoute(widget: navigateRoute),
        );
      },
          child: Container(
        height: ScreenUtil.getInstance().setHeight(180),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              CachedNetworkImage(
                imageUrl: imgUrl,
                width: ScreenUtil.getInstance().setWidth(90),
                height: ScreenUtil.getInstance().setHeight(90),
                placeholder: (context, url) => CircularProgressIndicator(),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
              Container(
                height: ScreenUtil.getInstance().setHeight(15),
              ),
              Text(
                name,
                style: TextStyle(
                    color: Color(0xFF4F4F4F),
                    fontFamily: "Avenir-Book",
                    height: 1.3,
                    fontSize: ScreenUtil.getInstance().setSp(15),
                    fontWeight: FontWeight.w300),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
