//Flutter Package
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

//Addition Package
import 'package:flutter_screenutil/flutter_screenutil.dart';
//import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';

//Internal Package
import 'package:pokedex/models/pokemon.dart';
import 'package:pokedex/components/pokemon_page/pokemon_page_comp.dart';

class PokemonTabPanel extends StatefulWidget {
  PokemonTabPanel({Key key, this.pokemon, this.screenUtil}) : super(key: key);
  final Pokemon pokemon;
  final ScreenUtil screenUtil;

  _PokemonTabPanelState createState() => _PokemonTabPanelState();
}

class _PokemonTabPanelState extends State<PokemonTabPanel>
    with SingleTickerProviderStateMixin {
  TabController tabController;

  PokemonPageUltility pokemonPageUltility() =>
      PokemonPageUltility(widget.pokemon);

  @override
  void initState() {
    super.initState();

    tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[tabBar(), tabBarPages()],
      ),
    );
  }


  Widget tabBar() {
    BoxDecoration tabBarIndicatorBoxDecoration = BoxDecoration(
      color: pokemonPageUltility().pokemonColor(),
      borderRadius: BorderRadius.circular(widget.screenUtil.setWidth(22.5)),
      border: Border.all(
          width: widget.screenUtil.setWidth(1), color: const Color(0XFF979797)),
      boxShadow: [
        BoxShadow(
            color: Color(0XB3559EDF),
            blurRadius: widget.screenUtil.setWidth(10))
      ],
    );
    double indicatorHeight = widget.screenUtil.setHeight(45.0);
    double indicatorWidth = widget.screenUtil.setWidth(115.0);

    return Container(
      margin: EdgeInsets.fromLTRB(0, 15, 0, 15),
      height: indicatorHeight,
      width: indicatorWidth * 3,
      child: TabBar(
        controller: tabController,
        indicatorSize: TabBarIndicatorSize.tab,
        indicator: tabBarIndicatorBoxDecoration,
        labelStyle: TextStyle(
          fontFamily: 'Avenir-Medium',
          fontSize: widget.screenUtil.setSp(13),
          color: Colors.white,
          fontWeight: FontWeight.w600,
        ),
        unselectedLabelColor: pokemonPageUltility().pokemonColor(),
        unselectedLabelStyle: TextStyle(
          fontFamily: 'Avenir-Medium',
          fontSize: widget.screenUtil.setSp(13),
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

  Widget tabBarPages() {
    return Container(
      height: 1200,
      child: TabBarView(controller: tabController, children: <Widget>[
        statTabPage(),
        Container(color: Colors.green),
        Container(color: Colors.blue)
      ]),
    );
  }


  Widget statTabPage() {
    return Container(
      child: Column(
        children: <Widget>[pokemonStatPanel()],
      ),
    );
  }



  Widget pokemonStatPanel() {
    //Create either list of Row either with map or For loop
    List<Widget> pokemonStatsList = [];
    for (var key in pokemonStatTypesMap.keys) {
      pokemonStatsList.add(pokemonStatRow(widget.pokemon.stats
          .firstWhere((stat) => stat.name.trim() == key)));
    }

    //List <Widget> pokemonStatsList = widget.pokemon.stats.map((eachStat)=>pokemonStatRow(eachStat)).toList();

    return Container(
      margin: EdgeInsets.fromLTRB(0, widget.screenUtil.setHeight(15), 0,
          widget.screenUtil.setHeight(15)),
      child: Column(
        children: pokemonStatsList,
      ),
    );
  }

  Widget pokemonStatRow(PokemonStat pokemonStat) {
    double statBarHeight = widget.screenUtil.setHeight(8);
    double fullBarWidth = widget.screenUtil.setWidth(240);
    double statBarWidth =
        widget.screenUtil.setWidth((pokemonStat.value / 100) * 240.0);
    double statTextWidth = widget.screenUtil.setWidth(40);
    Gradient pokemonStatBarGradient =
        pokemonPageUltility().pokemonStatGradient();

    return Container(
      margin: EdgeInsets.fromLTRB(
          0, widget.screenUtil.setHeight(5), 0, widget.screenUtil.setHeight(5)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            width: statTextWidth,
            margin: EdgeInsets.only(right: statTextWidth / 8),
            child: Text(
              pokemonStatTypesMap[pokemonStat.name],
              style: TextStyle(
                  color: pokemonPageUltility().pokemonColor(),
                  fontFamily: "Avenir-Heavy",
                  fontSize: widget.screenUtil.setSp(14),
                  fontWeight: FontWeight.w600),
            ),
          ),
          Container(
            width: statTextWidth,
            child: Text(
              pokemonStat.value.toString().padLeft(3, '0'),
              style: TextStyle(
                  color: Color(0XFF666666),
                  fontFamily: "Avenir-Book",
                  fontSize: widget.screenUtil.setSp(14)),
            ),
          ),
          Container(
              child: Stack(
            children: <Widget>[
              //Full Empty Bar
              Container(
                height: statBarHeight,
                width: fullBarWidth,
                decoration: BoxDecoration(
                    color: Color(0xFFF0F0F0),
                    borderRadius:
                        BorderRadius.circular(widget.screenUtil.setHeight(4))),
              ),

              //statBar
              Container(
                height: statBarHeight,
                width: statBarWidth,
                decoration: BoxDecoration(
                    gradient: pokemonStatBarGradient,
                    borderRadius:
                        BorderRadius.circular(widget.screenUtil.setHeight(4))),
              ),
            ],
          )),
        ],
      ),
    );
  }
  
    //TODO: abilityPanel
    //TODO: breedingPanel
    //TODO: capturePanel
}
