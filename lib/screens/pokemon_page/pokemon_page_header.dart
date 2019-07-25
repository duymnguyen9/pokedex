import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cached_network_image/cached_network_image.dart';

//Internal Package
import 'package:pokedex/models/pokemon.dart';
import 'package:pokedex/components/pokemon_page/pokemon_page_comp.dart';
import 'package:pokedex/components/pokemon_page/pokemon_page_tab.dart';
import 'package:pokedex/components/pokemon_page/pokemon_page_animation.dart';

const double pokemonSheetTopPosition = 222;

class PokemonPageHeader extends StatefulWidget {
  const PokemonPageHeader({Key key, this.pokemon}) : super(key: key);
  final Pokemon pokemon;

  @override
  _PokemonPageHeaderState createState() => _PokemonPageHeaderState();
}

class _PokemonPageHeaderState extends State<PokemonPageHeader> {
  PokemonPageUltility pokemonPageUltility() =>
      PokemonPageUltility(widget.pokemon);

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
                handle:
                    NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                child: SliverPersistentHeader(
                  delegate: PokemonAppBar(
                      pokemon: widget.pokemon,
                      expandedHeight: ScreenUtil.getInstance().setHeight(575),
                      minHeight: ScreenUtil.getInstance().setHeight(165)),
                  pinned: true,
                ),
              ),
            ];
          },
          body: PokemonPageTabBarView(
            pokemon: widget.pokemon,
          )),
    );
  }
}

class PokemonAppBar extends SliverPersistentHeaderDelegate {
  PokemonAppBar({
    @required this.expandedHeight,
    this.pokemon,
    this.minHeight,
  });
  final double expandedHeight;
  final Pokemon pokemon;
  PokemonPageUltility pokemonPageUltility() => PokemonPageUltility(pokemon);
  final double minHeight;

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
    // print("original Shrinkoffset: " + shrinkOffset.toString());
    // print(shrinkOffset);

    double roundedBorderSheetPosition() {
      if (ScreenUtil.getInstance().setHeight(pokemonSheetTopPosition) -
              shrinkOffset >
          ScreenUtil.getInstance().setHeight(88)) {
        return ScreenUtil.getInstance().setHeight(pokemonSheetTopPosition) -
            shrinkOffset;
      } else {
        return ScreenUtil.getInstance().setHeight(88);
      }
    }

    double roundedBorderSheetHeight() {
      if (ScreenUtil.getInstance().setHeight(pokemonSheetTopPosition) -
              shrinkOffset >
          ScreenUtil.getInstance().setHeight(88)) {
        return ScreenUtil.getInstance().setHeight(350);
      } else if (ScreenUtil.getInstance().setHeight(450) - shrinkOffset > 50) {
        return ScreenUtil.getInstance().setHeight(450) - shrinkOffset;
      } else {
        return 50;
      }
    }

    double tabBarHeight = ScreenUtil.getInstance().setHeight(77);
    double pokemonTabbarPosition() {
      // print("TabbarPosition" + (ScreenUtil.getInstance().setHeight(499) -
      //       shrinkOffset).toString());
      //       print("minimum height is: " + ScreenUtil.getInstance().setHeight(165).toString());
      // print("calculated Position: " +(minHeight - tabBarHeight).toString() );

      if (ScreenUtil.getInstance().setHeight(499) - shrinkOffset >
          minHeight - tabBarHeight) {
        return ScreenUtil.getInstance().setHeight(499) - shrinkOffset;
      } else {
        return minHeight - tabBarHeight;
      }
    }

    double pokemonNamePosition() {
      if (shrinkOffset > ScreenUtil.getInstance().setHeight(242)) {
        return ScreenUtil.getInstance().setHeight(45);
      } else {
        return ScreenUtil.getInstance().setHeight(280) - shrinkOffset;
      }
    }

    double pokemonNameColorChange() {
      if (shrinkOffset < ScreenUtil.getInstance().setHeight(242)) {
        return 0.31;
      } else if (shrinkOffset <= ScreenUtil.getInstance().setHeight(394)) {
        return 0.35 +
            (shrinkOffset / ScreenUtil.getInstance().setHeight(394)) * (0.65);
      } else if (shrinkOffset > expandedHeight - 5) {
        return 1;
      } else
        return 1;
    }

    double pokemonNameTextSize() {
      if (shrinkOffset < ScreenUtil.getInstance().setHeight(242)) {
        return ScreenUtil.getInstance().setSp(40);
      } else if (shrinkOffset <= ScreenUtil.getInstance().setHeight(394)) {
        return ScreenUtil.getInstance().setSp(40 -
            ((((shrinkOffset) - ScreenUtil.getInstance().setHeight(242)) /
                    ScreenUtil.getInstance().setHeight(152)) *
                (15)));
      } else
        return ScreenUtil.getInstance().setSp(25);
    }

    double pokemonImageOpacity() {
      if (shrinkOffset < 48) {
        return 1;
      } else if (shrinkOffset >= 48 && shrinkOffset < 66) {
        return ((66 - shrinkOffset) / 18);
      } else if (shrinkOffset >= 66) {
        return 0;
      } else {
        return 0;
      }
    }

    double pokemonTypePanelOpacity() {
      if (shrinkOffset <= ScreenUtil.getInstance().setHeight(239)) {
        return 1;
      } else if (shrinkOffset > ScreenUtil.getInstance().setHeight(239) &&
          shrinkOffset < ScreenUtil.getInstance().setHeight(257)) {
        return 0.98 -
            (0.98 *
                ((shrinkOffset - ScreenUtil.getInstance().setHeight(239)) /
                    (18)));
      } else if (shrinkOffset >= ScreenUtil.getInstance().setHeight(257)) {
        return 0;
      } else {
        return 0;
      }
    }

    double pokemonDescriptionPanelOpacity() {
      if (shrinkOffset <= ScreenUtil.getInstance().setHeight(289)) {
        return 1;
      } else if (shrinkOffset > ScreenUtil.getInstance().setHeight(289) &&
          shrinkOffset < ScreenUtil.getInstance().setHeight(329)) {
        return 0.98 -
            (0.98 *
                ((shrinkOffset - ScreenUtil.getInstance().setHeight(289)) /
                    (40)));
      } else if (shrinkOffset >= ScreenUtil.getInstance().setHeight(270)) {
        return 0;
      } else {
        return 0;
      }
    }

    return Stack(
      fit: StackFit.expand,
      overflow: Overflow.visible,
      children: <Widget>[
        Positioned(
          top: 0,
          child: RoundedCornerAnimation(
            delay: 2.4,
            child: Container(
                height: ScreenUtil.getInstance().setHeight(170),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    gradient: pokemonPageUltility().pokemonColorGradient())),
          ),
        ),
        Positioned(
          top: roundedBorderSheetPosition(),
          child: RoundedCornerAnimation(
            delay: 2.4,
            child: RoundedBackgroundTop(
              bottomHeight: roundedBorderSheetHeight(),
              pokemon: pokemon,
            ),
          ),
        ),

        Positioned(
          top: ScreenUtil.getInstance().setHeight(88) - shrinkOffset,
          child: SwipeDownTrigger(
            child: PokemonMainImage(
              opacityValue: pokemonImageOpacity(),
              pokemon: pokemon,
            ),
          ),
        ),
        //When shrinkOffset gets to 243 changes it to something else
        Positioned(
          top: pokemonNamePosition(),
          child: FadeIn(
            delay: 1.5,
            child: SwipeDownTrigger(
              child: PokemonNamePanel(
                brightness: pokemonNameColorChange(),
                textSize: pokemonNameTextSize(),
                pokemon: pokemon,
              ),
            ),
          ),
        ),
        Positioned(
          top: ScreenUtil.getInstance().setHeight(335) - shrinkOffset,
          child: Opacity(
            opacity: pokemonTypePanelOpacity(),
            child: FadeIn(
              delay: 1.8,
              child: SwipeDownTrigger(
                child: PokemonTypePanel(
                  pokemon: pokemon,
                ),
              ),
            ),
          ),
        ),
        Positioned(
          top: ScreenUtil.getInstance().setHeight(350) - shrinkOffset,
          child: Opacity(
              opacity: pokemonDescriptionPanelOpacity(),
              child: FadeIn(
                delay: 2.1,
                child: PokemonDescriptionPanel(
                  pokemon: pokemon,
                ),
              )),
        ),
        Positioned(
          top: pokemonTabbarPosition(),
          child: FadeIn(
            delay: 2.4,
            child: PokemonPageTabBar(
              pokemon: pokemon,
            ),
          ),
        ),
        Positioned(
            top: ScreenUtil.getInstance().setHeight(30),
            left: ScreenUtil.getInstance().setWidth(10),
            child: FadeIn(
              delay: 2.4,
              child: IconButton(
                icon: const Icon(Icons.expand_more,
                    size: 30, color: Colors.white),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ))
      ],
    );
  }

  @override
  double get maxExtent => expandedHeight;

  @override
  double get minExtent => minHeight;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}

class PokemonNamePanel extends StatelessWidget {
  const PokemonNamePanel({
    Key key,
    @required this.pokemon,
    this.textSize,
    this.brightness,
  }) : super(key: key);

  final Pokemon pokemon;
  final double textSize;
  final double brightness;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        child: Center(
          child: Opacity(
            opacity: 1,
            child: Text(
                pokemon.name[0].toUpperCase() + pokemon.name.substring(1),
                style: TextStyle(
                    fontFamily: 'Avenir-Book',
                    fontSize: textSize,
                    color: HSVColor.fromAHSV(1, 0, 0, brightness).toColor(),
                    fontWeight: FontWeight.w100)),
          ),
        ));
  }
}

class PokemonDescriptionPanel extends StatelessWidget {
  const PokemonDescriptionPanel({Key key, this.pokemon}) : super(key: key);
  final Pokemon pokemon;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil.getInstance().setWidth(160),
      width: MediaQuery.of(context).size.width,
      //color: Color(0xFFFAFAFA),
      padding: EdgeInsets.only(
          left: ScreenUtil.getInstance().setWidth(20),
          right: ScreenUtil.getInstance().setWidth(20)),
      child: Center(
        child: Text(pokemon.description.replaceAll('\n', ' '),
            softWrap: true,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontFamily: 'Avenir-Book',
                fontSize: ScreenUtil.getInstance().setSp(13),
                color: Color(0xFF4F4F4F),
                fontWeight: FontWeight.w300,
                height: 1.2)),
      ),
    );
  }
}

class PokemonTypePanel extends StatelessWidget {
  const PokemonTypePanel({Key key, this.pokemon}) : super(key: key);
  final Pokemon pokemon;
  PokemonPageUltility pokemonPageUltility() => PokemonPageUltility(pokemon);

  @override
  Widget build(BuildContext context) {
    String pokemonTypeDirectory =
        pokemonPageUltility().getPokemonTypeDirectory();
    return Container(
        height: ScreenUtil.getInstance().setHeight(50),
        width: MediaQuery.of(context).size.width,
        child: Center(
            child: Image.asset(
          pokemonTypeDirectory,
          width: ScreenUtil.getInstance().setWidth(120),
          height: ScreenUtil.getInstance().setHeight(40),
        )));
  }
}

class PokemonPageTabBar extends StatelessWidget {
  const PokemonPageTabBar({Key key, this.pokemon}) : super(key: key);
  final Pokemon pokemon;
  PokemonPageUltility pokemonPageUltility() => PokemonPageUltility(pokemon);

  @override
  Widget build(BuildContext context) {
    BoxDecoration tabBarIndicatorBoxDecoration = BoxDecoration(
      color: pokemonPageUltility().pokemonColor(),
      borderRadius:
          BorderRadius.circular(ScreenUtil.getInstance().setWidth(22.5)),
      // border: Border.all(
      //     width: widget.screenUtil.setWidth(1), color: const Color(0XFF979797)),
      boxShadow: [
        BoxShadow(
            color: pokemonPageUltility().pokemonColor().withAlpha(179),
            blurRadius: ScreenUtil.getInstance().setWidth(10))
      ],
    );
    double indicatorHeight = ScreenUtil.getInstance().setHeight(45.0);
    double indicatorWidth = ScreenUtil.getInstance().setWidth(115.0);

    return Container(
      width: MediaQuery.of(context).size.width,
      height: indicatorHeight + ScreenUtil.getInstance().setWidth(38),
      decoration: BoxDecoration(
        color: Color(0xFFFAFAFA),
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(ScreenUtil.getInstance().setWidth(35)),
            topRight: Radius.circular(ScreenUtil.getInstance().setWidth(35))),
      ),
      child: Center(
        child: Container(
          padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
          height: indicatorHeight + ScreenUtil.getInstance().setHeight(15.0),
          width: indicatorWidth * 3,
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
        ),
      ),
    );
  }
}

class PokemonMainImage extends StatelessWidget {
  const PokemonMainImage({Key key, this.pokemon, this.opacityValue})
      : super(key: key);
  final Pokemon pokemon;
  final double opacityValue;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: HeaderImageAnimation(
        delay: 1.1,
        child: CachedNetworkImage(
            imageUrl: pokemon.imgUrl,
            width: ScreenUtil.getInstance().setHeight(180),
            height: ScreenUtil.getInstance().setHeight(180),
            color: Color.fromRGBO(255, 255, 255, opacityValue),
            colorBlendMode: BlendMode.modulate),
      ),
    );
  }
}

class RoundedBackgroundTop extends StatelessWidget {
  const RoundedBackgroundTop({Key key, this.bottomHeight, this.pokemon})
      : super(key: key);
  PokemonPageUltility pokemonPageUltility() => PokemonPageUltility(pokemon);
  final Pokemon pokemon;
  final double bottomHeight;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: bottomHeight,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Color(0xFFFAFAFA),
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(ScreenUtil.getInstance().setWidth(35)),
            topRight: Radius.circular(ScreenUtil.getInstance().setWidth(35))),
      ),
    );
  }
}

class SwipeDownTrigger extends StatelessWidget {
  const SwipeDownTrigger({Key key, this.child}) : super(key: key);
  final Widget child;

  @override
  Widget build(BuildContext context) {
    void _onDragDown(DragUpdateDetails details) {
      // print("Position value: " + details.globalPosition.dy.toString());
      // print("Distance value: " + details.globalPosition.distance.toString());
      // print("direction value: " + details.globalPosition.direction.toString());
      //       print("delta Primary distance: " + details.primaryDelta.toString());
      if (details.primaryDelta > ScreenUtil.getInstance().setHeight(10) &&
          (details.globalPosition.distance <= 1.1 ||
              details.globalPosition.distance >= 0.85))

      Navigator.pop(context);
    }

    return GestureDetector(onVerticalDragUpdate: _onDragDown, child: child);
  }
}
