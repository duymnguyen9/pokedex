import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cached_network_image/cached_network_image.dart';


import 'package:pokedex/data/pokemon_list_data.dart';
import 'package:pokedex/screens/pokemon_page/pokemon_page.dart';
import 'package:pokedex/models/pokemon.dart';
import 'package:pokedex/services/http/pokemon_service.dart';
import 'package:pokedex/components/splash/splash.dart';

   


class PokemonsListPage extends StatelessWidget {
  const PokemonsListPage({Key key}) : super(key: key);
  final int pokemonsCount = 150;

  

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
        child: pokemonListView(),
      ),
    );
  }

  Widget pokemonListView() {
    return ListView.builder(
      itemCount: 150,
      itemBuilder: (BuildContext context, int index) {
        return InkWell(
          onTap: () {
                    var navigateRoute =           FutureBuilder<Pokemon>(
            future: PokemonService(pokemonID: index+1).fetchPokemon(),
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
              return 
              Stack(
        children: <Widget>[
          SplashScreen(),
          Center(
            child: Container(
                child:  Image(image: AssetImage( 'assets/img/pokeball_loading.gif'),)
              ),
          ),
        ],
      )
              
              ;
            },
          );

          Navigator.push(
  context,
  SlideRightRoute(widget: navigateRoute),
);

          },
          child: pokemonRow(pokemonList[index]),
        );
      },
    );
  }

  Widget pokemonRow(Map dataRow) {
    String imgUrl = "https://assets.pokemon.com/assets/cms2/img/pokedex/full/" +
        dataRow["id"].toString().padLeft(3, '0') +
        ".png";

    Widget textContent() {
      return Container(
        margin: EdgeInsets.fromLTRB(
            ScreenUtil.instance.setWidth(5),
            ScreenUtil.instance.setWidth(0),
            ScreenUtil.instance.setWidth(5),
            ScreenUtil.instance.setWidth(0)),
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
                    fontSize: ScreenUtil.instance.setSp(19),
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
                    fontSize: ScreenUtil.instance.setSp(15),
                    fontWeight: FontWeight.w300),
              ),
            )
          ],
        ),
      );
    }

    Widget rightRowComponent() {
      List<Widget> rightWidgetList = [];
      for (var type in dataRow["type"]) {
        String imgDirectory = 'assets/img/type/' +
            type.toLowerCase().replaceAll(" ", "") +
            ".png";
        rightWidgetList.add(Container(
            child: Image.asset(
          imgDirectory,
          width: ScreenUtil.instance.setWidth(40),
          height: ScreenUtil.instance.setHeight(40),
        )));
      }
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: rightWidgetList,
      );
    }

    Widget leftRowComponent() {
      return Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          CachedNetworkImage(
            height: ScreenUtil.instance.setHeight(50),
            width: ScreenUtil.instance.setWidth(50),
            imageUrl: imgUrl,
          ),
          textContent()
        ],
      );
    }

    return Container(
      height: ScreenUtil.instance.setHeight(75),
      padding: EdgeInsets.fromLTRB(
          ScreenUtil.instance.setWidth(10),
          ScreenUtil.instance.setWidth(0),
          ScreenUtil.instance.setWidth(10),
          ScreenUtil.instance.setWidth(0)),
      decoration: BoxDecoration(
          border: Border(
        bottom: BorderSide(width: 0.3, color: Color(0xFFbdbdbd)),
      )),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[leftRowComponent(), rightRowComponent()],
      ),
    );
  }
}

class SlideRightRoute extends PageRouteBuilder {
  final Widget widget;
  SlideRightRoute({this.widget})
    : super(
        pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
          return widget;
        },
        transitionsBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
          return new SlideTransition(
            position: new Tween<Offset>(
              begin: const Offset(-1.0, 0.0),
              end: Offset.zero,
            ).animate(animation),
            child: child,
           );
         }
      );
}