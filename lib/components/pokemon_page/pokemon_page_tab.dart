//Flutter Package
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

//Addition Package
import 'package:flutter_screenutil/flutter_screenutil.dart';

//Internal Package
import 'package:pokedex/models/pokemon.dart';
import 'package:pokedex/components/pokemon_page/pokemon_page_comp.dart';
import 'package:pokedex/components/pokemon_page/pokemon_page_evolution_tab.dart';
import 'package:pokedex/components/pokemon_page/pokemon_page_moves_tab.dart';
import 'package:pokedex/components/pokemon_page/pokemon_page_stat_tab.dart';
import 'package:pokedex/components/animation/pokemon_page_animation.dart';



const double sectionWidth = 345;
const double subSectionWidth = sectionWidth / 3;

class PokemonPageTabBarView extends StatelessWidget {
  const PokemonPageTabBarView({Key key, this.pokemon}) : super(key: key);
  final Pokemon pokemon;
  PokemonPageUltility pokemonPageUltility() => PokemonPageUltility(pokemon);
  @override
  Widget build(BuildContext context) {
    Color pokemonColor = pokemonPageUltility().pokemonColor();
    return RoundedCornerAnimation(delay: 2, child:     TabBarView(
      children: <Widget>[
        PokemonPageStatTab(pokemon: pokemon, pokemonColor: pokemonColor),
        PokemonEvolutionTab(pokemon: pokemon, pokemonColor: pokemonColor,),
        PokemonMovesTab(
          pokemon: pokemon,
        ),
      ],
    ),);

  }
}

class TabPageViewContainer extends StatelessWidget {
  const TabPageViewContainer(
      {Key key, @required this.tabKey, @required this.pageContent})
      : super(key: key);
  final String tabKey;
  final SliverList pageContent;

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (BuildContext context) {
        return Container(
          child: CustomScrollView(
            key: PageStorageKey<String>(tabKey),
            physics: ClampingScrollPhysics(),
            slivers: <Widget>[
              SliverOverlapInjector(
                handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
              ),
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                sliver: pageContent,
              )
            ],
          ),
        );
      },
    );
  }
}

class SubSectionWidget extends StatelessWidget {
  const SubSectionWidget(
      {Key key,
      this.subSectionHeader,
      this.child,
      this.isLastSubSection = false,@required this.pokemonColor})
      : super(key: key);
  final String subSectionHeader;
  final Widget child;
  final bool isLastSubSection;
  final Color pokemonColor;

  @override
  Widget build(BuildContext context) {
    //subSectionTitle Widget
    Widget header() {
      return Container(
        margin: EdgeInsets.only(bottom: ScreenUtil.getInstance().setHeight(10)),
        child: Text(
          subSectionHeader,
          style: TextStyle(
              color: pokemonColor,
              fontFamily: "Avenir-Medium",
              height: 1.3,
              fontSize: ScreenUtil.getInstance().setSp(16),
              fontWeight: FontWeight.w400),
        ),
      );
    }

    BoxDecoration subSectionBoxDecoration() {
      if (isLastSubSection) {
        return BoxDecoration();
      } else {
        return BoxDecoration(
            border: Border(
          right: BorderSide(width: 0.3, color: Color(0xFFbdbdbd)),
        ));
      }
    }

    return Container(
      width: ScreenUtil.getInstance().setWidth(subSectionWidth),
      height: ScreenUtil.getInstance().setHeight(87),
      decoration: subSectionBoxDecoration(),
      child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            header(),
            child,
          ]),
    );
  }
}

class SectionTitle extends StatelessWidget {
  const SectionTitle({
    Key key,
    @required this.title,
    this.pokemon,
  }) : super(key: key);

  final String title;
  final Pokemon pokemon;
  PokemonPageUltility pokemonPageUltility() => PokemonPageUltility(pokemon);

  @override
  Widget build(BuildContext context) {
    Color pokemonColor = pokemonPageUltility().pokemonColor();
    return Container(
      height: ScreenUtil.getInstance().setHeight(60),
      margin: EdgeInsets.only(bottom: 10),
      child: Center(
        child: Text(
          title,
          style: TextStyle(
              color: pokemonColor,
              fontFamily: 'Avenir-Book',
              fontSize: ScreenUtil.getInstance().setSp(20)),
        ),
      ),
    );
  }
}

class SectionPanel extends StatelessWidget {
  const SectionPanel({Key key,@required this.sectionHeader, @required this.child, this.haveHeader = true,@required this.pokemon}) : super(key: key);
  final String sectionHeader; 
  final Widget child;
  final bool haveHeader;
  final Pokemon pokemon;

  @override
  Widget build(BuildContext context) {
    Widget header() {
      if (haveHeader) {
        return SectionTitle(
          title: sectionHeader,
          pokemon: pokemon,
        );
      } else {
        return Container();
      }
    }

    return Container(
        width: ScreenUtil.getInstance().setWidth(sectionWidth),
        margin: EdgeInsets.fromLTRB(
            ScreenUtil.getInstance().setWidth(0),
            ScreenUtil.getInstance().setHeight(15),
            ScreenUtil.getInstance().setWidth(0),
            ScreenUtil.getInstance().setHeight(15)),
        child: Column(
          children: <Widget>[header(), child],
        ));
  }
}