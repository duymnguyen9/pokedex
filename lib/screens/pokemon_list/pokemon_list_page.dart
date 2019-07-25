import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:pokedex/data/pokemon_list_data.dart';
import 'package:pokedex/screens/pokemon_page/pokemon_page.dart';
import 'package:pokedex/models/pokemon.dart';
import 'package:pokedex/services/http/pokemon_service.dart';
import 'package:pokedex/components/splash/splash.dart';
import 'package:pokedex/components/animation/pokemon_list_page_animation.dart';
import 'package:pokedex/components/animation/route_transition_animation.dart';


final int pokemonsCount = 80;

class PokemonsListPage extends StatelessWidget {
  const PokemonsListPage({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    double defaultScreenWidth = 375.0;
    double defaultScreenHeight = 812.0;
    ScreenUtil.instance = ScreenUtil(
      width: defaultScreenWidth,
      height: defaultScreenHeight,
      allowFontScaling: true,
    )..init(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Pokemon"),
      ),
      body: Container(
        color: Color(0xFFFAFAFA),
        child: PokemonListView(),
      ),
    );
  }
}

class PokemonListView extends StatelessWidget {
  const PokemonListView({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double delayBuider(int index){
      if(index<10){
        return (index/2).toDouble();
      }
      else{
        return 0.3;
      }
    }

    return ListView.builder(
      itemCount: 150,
      itemBuilder: (BuildContext context, int index) {

        return  FadeIn(
          delay: delayBuider(index),
                  child: PokemonRowBuild(
            index: index,
            parentWidget: this,
          ),
        );
      },
    );


  }
}

class PokemonRowBuild extends StatelessWidget {
  const PokemonRowBuild({
    Key key,
    this.index, @required this.parentWidget,
  }) : super(key: key);
  final int index;
  final Widget parentWidget;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        var navigateRoute = FutureBuilder<Pokemon>(
          future: PokemonService(pokemonID: index + 1).fetchPokemon(),
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
          FadeRoute(page: navigateRoute),
        );
      },
      child: PokemonRow(dataRow: pokemonList[index]),
    );
  }
}

class PokemonRow extends StatelessWidget {
  const PokemonRow({
    Key key,
    @required this.dataRow,
  }) : super(key: key);

  final Map dataRow;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil.instance.setHeight(75),
      padding: EdgeInsets.fromLTRB(
          ScreenUtil.getInstance().setWidth(10),
          ScreenUtil.getInstance().setWidth(0),
          ScreenUtil.getInstance().setWidth(10),
          ScreenUtil.getInstance().setWidth(0)),
      decoration: BoxDecoration(
          border: Border(
        bottom: BorderSide(width: 0.3, color: Color(0xFFbdbdbd)),
      )),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          new LeftRowComponent(dataRow: dataRow),
          new RightRowComponent(dataRow: dataRow)
        ],
      ),
    );
  }
}

class LeftRowComponent extends StatelessWidget {
  const LeftRowComponent({
    Key key,
    @required this.dataRow,
  }) : super(key: key);

  final Map dataRow;

  @override
  Widget build(BuildContext context) {
    String imgUrl = "https://assets.pokemon.com/assets/cms2/img/pokedex/full/" +
        dataRow["id"].toString().padLeft(3, '0') +
        ".png";
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        CachedNetworkImage(
          height: ScreenUtil.getInstance().setHeight(50),
          width: ScreenUtil.getInstance().setWidth(50),
          imageUrl: imgUrl,
        ),
        PokemonRowTextContent(
          dataRow: dataRow,
        )
      ],
    );
  }
}

class RightRowComponent extends StatelessWidget {
  const RightRowComponent({
    Key key,
    @required this.dataRow,
  }) : super(key: key);

  final Map dataRow;

  @override
  Widget build(BuildContext context) {
    List<Widget> rightWidgetList = [];
    for (var type in dataRow["type"]) {
      String imgDirectory =
          'assets/img/type/' + type.toLowerCase().replaceAll(" ", "") + ".png";
      rightWidgetList.add(Container(
          child: Image.asset(
        imgDirectory,
        width: ScreenUtil.getInstance().setWidth(40),
        height: ScreenUtil.getInstance().setHeight(40),
      )));
    }
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: rightWidgetList,
    );
  }
}

class PokemonRowTextContent extends StatelessWidget {
  const PokemonRowTextContent({Key key, @required this.dataRow})
      : super(key: key);
  final Map dataRow;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(
          ScreenUtil.getInstance().setWidth(5),
          ScreenUtil.getInstance().setWidth(0),
          ScreenUtil.getInstance().setWidth(5),
          ScreenUtil.getInstance().setWidth(0)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            child: Text(
              dataRow["name"],
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
              "#" + dataRow["id"].toString().padLeft(3, '0'),
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
    );
  }
}
