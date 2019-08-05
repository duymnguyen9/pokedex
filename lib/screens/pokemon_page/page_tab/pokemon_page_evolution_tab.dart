import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:pokedex/models/pokemon.dart';
import 'package:pokedex/components/pokemon_page/pokemon_page_comp.dart';
import 'package:pokedex/screens/loading_page.dart';
import 'package:pokedex/screens/pokemon_page/page_tab/pokemon_page_tab.dart';
import 'package:pokedex/components/animation/route_transition_animation.dart';
import 'package:pokedex/components/animation/pokemon_page_animation.dart';
import 'package:pokedex/data/pokemon_list_data.dart';
import 'package:pokedex/data/pokemon_color.dart';
import 'package:pokedex/screens/pokemon_page/pokemon_page.dart';

import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class PokemonEvolutionTab extends StatelessWidget {
  const PokemonEvolutionTab(
      {Key key, @required this.pokemon, @required this.pokemonColor})
      : super(key: key);
  final Pokemon pokemon;
  final Color pokemonColor;

  @override
  Widget build(BuildContext context) {
    double delayCount = 0.5;
    List<Widget> evolutionWidgets = [];
    evolutionWidgets.add(Container(
      height: ScreenUtil.getInstance().setHeight(10),
    ));
    List<int> iDlist = [];
    for (var element in pokemon.evolutionList) {
      iDlist.add(int.parse(element["id"]));
      iDlist.add(int.parse(element["idEvolved"]));
      evolutionWidgets.add(FadeIn(
        delay: 0.5 + delayCount,
        child: EvolutionSection(
            evolutionChain: element, pokemonColor: pokemonColor),
      ));
      evolutionWidgets.add(EvolutionSeparatorWidget());
      delayCount += 0.5;
    }
    List<int> idSet = iDlist.toSet().toList();

    evolutionWidgets.add(SectionTitle(
      title: "Size Comparison",
      pokemon: pokemon,
    ));
    if(idSet.isEmpty){
      idSet.add(pokemon.id);
    }
    evolutionWidgets.add(PokemonSizeComparisonPanel(pokemonIDList: idSet));

    evolutionWidgets.add(BottomTabRoundedCorner(
      pokemonColor: pokemonColor,
    ));

    return Container(
      color: Color(0xFFffffff),
      child: TabPageViewContainer(
        tabKey: "EVOLUTIONS",
        pageContent: SliverList(
          delegate: SliverChildListDelegate(evolutionWidgets),
        ),
      ),
    );
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
            name: evolutionChain["name"], id: evolutionChain["id"]),
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
        List<String> pokemonTypeList = pokemonList[int.parse(id) - 1]["type"];
        Gradient pokemonGradient =
            pokemonColorsGradient[pokemonTypeList[0].trim()];

        Navigator.push(
            context,
            ColorTransition(
                page: PokemonPage(
                    loadingScreenType: LoadingScreenType.pokemon,
                    pokemonGradient: pokemonGradient,
                    pokemonIndex: int.parse(id))));
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
                name[0].toUpperCase() + name.substring(1),
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

class PokemonSizeComparisonPanel extends StatelessWidget {
  const PokemonSizeComparisonPanel({Key key, this.pokemonIDList})
      : super(key: key);
  final List<int> pokemonIDList;
  @override
  Widget build(BuildContext context) {
    double panelHeight = MediaQuery.of(context).size.height / 3;

    return Container(
      height: panelHeight,
      width: MediaQuery.of(context).size.width,
      child: FutureBuilder(
        future: pokemonWidgetList(context, panelHeight),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return Container(
              height: panelHeight,
              width: MediaQuery.of(context).size.width,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: snapshot.data,
              ),
            );
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }

          // By default, show a loading spinner.
          return Center(
              child: Image(
            image: AssetImage('assets/img/pokeball1.png'),
            width: 50,
            height: 50,
          ));
        },
      ),
    );
  }

  Widget imageBuild(int id, double height) {
    // String imgUrl = 'https://assets.pokemon.com/assets/cms2/img/pokedex/full/' +
    //     id.toString().padLeft(3, '0') +
    //     '.png';
    String pokemonName = pokemonList[id - 1]["name"];
    String imgUrl =
        'https://img.pokemondb.net/artwork/large/' + pokemonName + '.jpg';
    return Container(
      height: height,
      child: CachedNetworkImage(
        imageUrl: imgUrl,
        height: height,
        fit: BoxFit.fitHeight,
        placeholder: (context, url) =>           Image.asset(
          
            'assets/img/pokeshake.gif',
            height: 50,
            width: 50,
            alignment: Alignment.bottomCenter,
          ),
        errorWidget: (context, url, error) => Icon(Icons.error),
      ),
    );
  }

  Future<List<Widget>> pokemonWidgetList(context, double panelHeight) async {
    List<Widget> _pokemonWidgetList = [];
    List<Map> pokemonMaps = [];
    int maxHeight = 0;
    for (int id in pokemonIDList) {
      int pokemonHeight = await getPokemonHeight(id);
      if (maxHeight < pokemonHeight) {
        maxHeight = pokemonHeight;
      }
      pokemonMaps.add({"id": id, "height": pokemonHeight});
    }
    double relativeHeightUnit;
    if (maxHeight >= 15) {
      relativeHeightUnit = panelHeight / maxHeight;
    } else {
      relativeHeightUnit = panelHeight / 15;
    }
    for (var item in pokemonMaps) {
      _pokemonWidgetList.add(Container(
        height: panelHeight,
        alignment: Alignment.bottomCenter,
        child: imageBuild(item["id"], item["height"] * relativeHeightUnit),
      ));
      // marginValue += MediaQuery.of(context).size.width / 10;
    }
    _pokemonWidgetList.insert(
      0,
      Container(
        height: panelHeight,
        alignment: Alignment.bottomCenter,
        width: 15 * relativeHeightUnit / 2,
        child: Container(
          height: 15 * relativeHeightUnit,
          child: Image.asset(
            'assets/img/ash.png',
          ),
        ),
      ),
    );
    // _pokemonWidgetList.add(imageBuild(, pokemonHeightcapture.toDouble()));
    return _pokemonWidgetList;
  }
}


Future<int> getPokemonHeight(int pokemonID) async {
  final String pokemonUrl =
      'http://pokeapi.co/api/v2/pokemon/' + pokemonID.toString() + '/';
  final pokemonResponseHeight = await http.get(pokemonUrl);

  if (pokemonResponseHeight.statusCode == 200) {
    int height = json.decode(pokemonResponseHeight.body)['height'];
    return height;
  } else {
    throw Exception('Failed to load PokemonFromPokemon');
  }
}
