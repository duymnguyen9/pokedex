import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cached_network_image/cached_network_image.dart';

//Internal Package
import 'package:pokedex/models/pokemon.dart';
import 'package:pokedex/components/pokemon_page/pokemon_page_comp.dart';

class PokemonPageHeader extends StatefulWidget {
  const PokemonPageHeader({Key key, this.pokemon}) : super(key: key);
  final Pokemon pokemon;

  @override
  _PokemonPageHeaderState createState() => _PokemonPageHeaderState();
}

class _PokemonPageHeaderState extends State<PokemonPageHeader> {
  PokemonPageUltility pokemonPageUltility() => PokemonPageUltility(widget.pokemon);

  @override
  Widget build(BuildContext context) {
    double defaultScreenWidth = 375.0;
    double defaultScreenHeight = 812.0;
    ScreenUtil.instance = ScreenUtil(
      width: defaultScreenWidth,
      height: defaultScreenHeight,
      allowFontScaling: true,
    )..init(context);

    return DefaultTabController(
      length: 3,
      child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverOverlapAbsorber(
                // This widget takes the overlapping behavior of the SliverAppBar,
                // and redirects it to the SliverOverlapInjector below. If it is
                // missing, then it is possible for the nested "inner" scroll view
                // below to end up under the SliverAppBar even when the inner
                // scroll view thinks it has not been scrolled.
                // This is not necessary if the "headerSliverBuilder" only builds
                // widgets that do not overlap the next sliver.
                handle:
                    NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                child: SliverPersistentHeader(
                  delegate: PokemonAppBar(
                      pokemon: widget.pokemon,
                      expandedHeight: ScreenUtil.getInstance().setHeight(220),
                      minHeight: ScreenUtil.getInstance().setHeight(90),
                      tabBar: tabBar()),
                  pinned: true,

                  // The "forceElevated" property causes the SliverAppBar to show
                  // a shadow. The "innerBoxIsScrolled" parameter is true when the
                  // inner scroll view is scrolled beyond its "zero" point, i.e.
                  // when it appears to be scrolled below the SliverAppBar.
                  // Without this, there are cases where the shadow would appear
                  // or not appear inappropriately, because the SliverAppBar is
                  // not actually aware of the precise position of the inner
                  // scroll views.
                  // forceElevated: innerBoxIsScrolled,
                  // bottom: PreferredSize(
                  //   preferredSize: Size.fromHeight(300),
                  //   child: tabBar()
                  // )
                ),
              ),
            ];
          },
          body: Container()),
    );
  }

  Widget tabBar() {
    BoxDecoration tabBarIndicatorBoxDecoration = BoxDecoration(
      color: pokemonPageUltility().pokemonColor(),
      borderRadius:
          BorderRadius.circular(ScreenUtil.getInstance().setWidth(22.5)),
      // border: Border.all(
      //     width: widget.screenUtil.setWidth(1), color: const Color(0XFF979797)),
      boxShadow: [
        BoxShadow(
            color: Color(0XB3559EDF),
            blurRadius: ScreenUtil.getInstance().setWidth(10))
      ],
    );
    double indicatorHeight = ScreenUtil.getInstance().setHeight(45.0);
    double indicatorWidth = ScreenUtil.getInstance().setWidth(115.0);

    return Container(
      padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
      height: indicatorHeight + 20,
      width: indicatorWidth * 3,
      color: Color(0xFFFAFAFA),
      child: TabBar(
        indicatorSize: TabBarIndicatorSize.tab,
        indicator: tabBarIndicatorBoxDecoration,
        labelStyle: TextStyle(
          fontFamily: 'Avenir-Medium',
          fontSize: ScreenUtil.getInstance().setSp(13),
          color: Colors.white,
          fontWeight: FontWeight.w600,
        ),
        unselectedLabelColor: pokemonPageUltility().pokemonColor(),
        unselectedLabelStyle: TextStyle(
          fontFamily: 'Avenir-Medium',
          fontSize: ScreenUtil.getInstance().setSp(13),
          color: pokemonPageUltility().pokemonColor(),
          fontWeight: FontWeight.w500,
        ),
        tabs: [
          Container(
            width: indicatorWidth,
            height: indicatorHeight,
            child: Center(child: Tab(text: 'STATS')),
          ),
          Container(
            width: indicatorWidth,
            height: indicatorHeight,
            child: Center(child: Tab(text: 'EVOLUTIONS')),
          ),
          Container(
            width: indicatorWidth,
            height: indicatorHeight,
            child: Center(child: Tab(text: 'MOVES')),
          ),
        ],
      ),
    );
  }
}

class PokemonAppBar extends SliverPersistentHeaderDelegate {
  PokemonAppBar(
      {@required this.expandedHeight,
      this.pokemon,
      this.minHeight,
      this.tabBar});
  final double expandedHeight;
  final Pokemon pokemon;
  PokemonPageUltility pokemonPageUltility() => PokemonPageUltility(pokemon);
  final double minHeight;
  final Widget tabBar;
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

    double opacityHeaderControlTitleMain() {
      double opacityValue = (1 - shrinkOffset / expandedHeight);
      double controlledValue = (1 - shrinkOffset * 2 / expandedHeight);
      if (opacityValue > 0.80) {
        return 0;
      } else if (opacityValue > 0.7 && controlledValue > 0) {
        return 1 - controlledValue;
      } else
        return 1;
    }

    return Stack(
      fit: StackFit.expand,
      overflow: Overflow.visible,
      children: [
        Positioned(
          top: ScreenUtil.getInstance().setHeight(5),
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
        // Positioned(
        //     top: ScreenUtil.getInstance().setHeight(80),
        //     child: Container(
        //       height: ScreenUtil.getInstance().setHeight(380.0),
        //       width: MediaQuery.of(context).size.width,
        //       decoration: BoxDecoration(
        //         color: Color(0xFFFAFAFA),
        //         borderRadius: BorderRadius.only(
        //             topLeft:
        //                 Radius.circular(ScreenUtil.getInstance().setWidth(35)),
        //             topRight:
        //                 Radius.circular(ScreenUtil.getInstance().setWidth(35))),
        //       ),
        //     )),
        Positioned(
          top: ScreenUtil.getInstance().setHeight(300) - (shrinkOffset),
          child: Container(
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: <Widget>[
                  Opacity(
                    opacity: 1,
                    child: cardContent(context),
                  ),
                  Stack(
                    children: <Widget>[
                      Container(
                        height: ScreenUtil.getInstance().setHeight(75),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        child: Center(
                          child: tabBar,
                        ),
                      )
                    ],
                  ),
                ],
              )),
        ),
        Positioned(
          top: ScreenUtil.getInstance().setHeight(103) - shrinkOffset,
          child: Container(
            width: MediaQuery.of(context).size.width,
            
              child: CachedNetworkImage(
                imageUrl: pokemon.imgUrl,
                width: ScreenUtil.getInstance().setWidth(190),
                height: ScreenUtil.getInstance().setHeight(190),
                  color: Color.fromRGBO(255, 255, 255, opacityHeaderControlImg()),
  colorBlendMode: BlendMode.modulate
              ),
            ),
          ),
        
        //Black Title Name below Image
        Positioned(
          top: ScreenUtil.getInstance().setHeight(290) - shrinkOffset,
          child: Container(
              width: MediaQuery.of(context).size.width,
              child: Center(
                child: Opacity(
                  opacity: 1,
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

      ],
    );
  }



  Widget cardContent(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.only(
        top: ScreenUtil.getInstance().setHeight(80),
      ),
      width: size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          pokemonTypePanel(),
          pokemonDescriptionPanel(),
        ],
      ),
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

  //Description's Height is 150 of
  Widget pokemonDescriptionPanel() {
    return Container(
      height: ScreenUtil.getInstance().setWidth(150),
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

  @override
  double get maxExtent => expandedHeight;

  @override
  double get minExtent => minHeight;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}
