//Flutter Package
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

//Addition Package
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cached_network_image/cached_network_image.dart';


//Internal Package
import 'package:pokedex/models/pokemon.dart';
import 'package:pokedex/components/pokemon_page/pokemon_page_comp.dart';
import 'package:pokedex/components/pokemon_page/pokemon_page_tab.dart';

class PokemonPage extends StatelessWidget {
  const PokemonPage({Key key, this.pokemon}) : super(key: key);
  final Pokemon pokemon;
  PokemonPageUltility pokemonPageUltility() => PokemonPageUltility(pokemon);

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

    return Material(
      child: Container(
        decoration: BoxDecoration(
            gradient: pokemonPageUltility().pokemonColorGradient()),
        child: CustomScrollView(
                physics: const BouncingScrollPhysics(),

          slivers: [
            SliverPersistentHeader(
              delegate: PokemonAppBar(
                  pokemon: pokemon,
                  expandedHeight: ScreenUtil.getInstance().setHeight(220),
                  minHeight: ScreenUtil.getInstance().setHeight(90)),
              pinned: true,
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  Container(
                      height: 2000.0,
                      decoration: BoxDecoration(
                          color: Color(0xFFFAFAFA),
                          borderRadius: BorderRadius.circular(
                              ScreenUtil.getInstance().setWidth(48))),
                      child: cardContent(context)),
                  Container(height: 30)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget cardContent(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(
              top: ScreenUtil.getInstance().setHeight(110),
              bottom: ScreenUtil.getInstance().setHeight(10)),
          width: size.width,
        ),
        pokemonTypePanel(),
        pokemonDescriptionPanel(),
        PokemonTabPanel(
          pokemon: pokemon,
        ),
      ],
    );
  }

  Widget pokemonTypePanel() {
    String pokemonTypeDirectory =
        pokemonPageUltility().getPokemonTypeDirectory();
    return Container(
        height: ScreenUtil.getInstance().setHeight(50),
        child: Center(
            child: Image.asset(
          pokemonTypeDirectory,
          width: ScreenUtil.getInstance().setWidth(120),
          height: ScreenUtil.getInstance().setHeight(40),
        )));
  }

  Widget pokemonDescriptionPanel() {
    return Container(
      padding: EdgeInsets.all(ScreenUtil.getInstance().setWidth(18)),
      child: Center(
        child: Text(pokemon.description.replaceAll('\n', ' '),
            softWrap: true,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontFamily: 'Avenir-Book',
                fontSize: ScreenUtil.getInstance().setSp(14),
                color: Color(0xFF4F4F4F),
                fontWeight: FontWeight.w100,
                height: 1.2)),
      ),
    );
  }
}

class PokemonAppBar extends SliverPersistentHeaderDelegate {
  final double expandedHeight;
  final Pokemon pokemon;
  PokemonPageUltility pokemonPageUltility() => PokemonPageUltility(pokemon);
  final double minHeight;

  PokemonAppBar({@required this.expandedHeight, this.pokemon, this.minHeight});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    double defaultScreenWidth = 375.0;
    double defaultScreenHeight = 812.0;
    ScreenUtil.instance = ScreenUtil(
      width: defaultScreenWidth,
      height: defaultScreenHeight,
      allowFontScaling: true,
    )..init(context);

    double opacityHeaderControlImg() {
      double opacityValue = (1 - shrinkOffset / expandedHeight);
      if (opacityValue > 0.9) {
        return 1;
      } else if (opacityValue > 0.7 &&
          (1.1 - shrinkOffset * 3 / expandedHeight) > 0) {

        return (1.1 - shrinkOffset * 3 / expandedHeight);
      } else
        return 0;
    }

    double opacityHeaderControlTitle() {
      double opacityValue = (1 - shrinkOffset / expandedHeight);
      if (opacityValue > 0.99) {
        return 1;
      } else if (opacityValue > 0.7 &&
          (1 - shrinkOffset * 4 / expandedHeight) > 0) {
        return (1 - shrinkOffset * 4 / expandedHeight);
      } else
        return 0;
    }
        double opacityHeaderControlTitleMain() {
      double opacityValue = (1 - shrinkOffset / expandedHeight);
      double controlledValue = (1 - shrinkOffset * 2 / expandedHeight);
      if (opacityValue > 0.80) {
        return 0;
      } else if (opacityValue > 0.7 &&
           controlledValue> 0) {
        return 1 - controlledValue;
      } else
        return 1;
    }
    return Stack(
      fit: StackFit.expand,
      overflow: Overflow.visible,
      children: [
        pokemonGradientBackGround(),
        Positioned(
          top: ScreenUtil.getInstance().setHeight(10),
          child: Container(
                          width: MediaQuery.of(context).size.width,
            child: Center(
              child: Opacity(
                opacity: opacityHeaderControlTitleMain(),
                child: Container(
                  margin: EdgeInsets.only(top: 35),
                  child: Text(
                      pokemon.name[0].toUpperCase() + pokemon.name.substring(1),
                      style: TextStyle(
                          fontFamily: 'Avenir-Book',
                          fontSize: ScreenUtil.getInstance().setSp(25.0),
                          color: Colors.white,
                          fontWeight: FontWeight.w400)),
                ),
              ),
            ),
          ),
        ),
        Positioned(
          top: ScreenUtil.getInstance().setHeight(290) - shrinkOffset,
          child: Container(
              width: MediaQuery.of(context).size.width,
              child: Center(
                child: Opacity(
                  opacity: opacityHeaderControlTitle(),
                  child: Text(
                      pokemon.name[0].toUpperCase() + pokemon.name.substring(1),
                      style: TextStyle(
                          fontFamily: 'Avenir-Book',
                          fontSize: ScreenUtil.getInstance().setSp(40.0),
                          color: Color(0xFF4F4F4F),
                          fontWeight: FontWeight.w100)),
                ),
              )),
        ),
        Positioned(
          top: ScreenUtil.getInstance().setHeight(103) - shrinkOffset,
          child: Container(
            width: MediaQuery.of(context).size.width,
            child: Opacity(
              opacity: opacityHeaderControlImg(),
              child: CachedNetworkImage(
                imageUrl: pokemon.imgUrl,
                width: ScreenUtil.getInstance().setWidth(180),
                height: ScreenUtil.getInstance().setHeight(180),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget pokemonGradientBackGround() {
    Gradient pokemonColorGradient =
        pokemonPageUltility().pokemonColorGradient();
    return Container(
      decoration: BoxDecoration(gradient: pokemonColorGradient),
    );
  }

  @override
  double get maxExtent => expandedHeight;

  @override
  double get minExtent => minHeight;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}
