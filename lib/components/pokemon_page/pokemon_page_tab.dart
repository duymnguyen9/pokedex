//Flutter Package
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

//Addition Package
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:percent_indicator/percent_indicator.dart';

//import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';

//Internal Package
import 'package:pokedex/models/pokemon.dart';
import 'package:pokedex/components/pokemon_page/pokemon_page_comp.dart';
import 'package:pokedex/components/pokemon_page/pokemon_page_evolution_tab.dart';
import 'package:pokedex/components/pokemon_page/pokemon_page_moves_tab.dart';


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

  static const double sectionWidth = 345;
  static const double subSectionWidth = sectionWidth / 3;

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
      // border: Border.all(
      //     width: widget.screenUtil.setWidth(1), color: const Color(0XFF979797)),
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
      height: 1400,
      child: TabBarView(controller: tabController, children: <Widget>[
        statTabPage(),
        PokemonEvolutionTab(pokemon: widget.pokemon, screenUtil: widget.screenUtil,),
        PokemonMovesTab(pokemon: widget.pokemon, screenUtil: widget.screenUtil,),
      ]),
    );
  }

  Widget statTabPage() {
    return Container(
      child: Column(
        children: <Widget>[
          statSection(),
          abilitySection(),
          breedingSection(),
          captureSection(),
          spritesPanel()
        ],
      ),
    );
  }

  Widget statSection() {
    //Create either list of Row either with map or For loop
    List<Widget> pokemonStatsList = [];
    for (var key in pokemonStatTypesMap.keys) {
      pokemonStatsList.add(pokemonStatRow(
          widget.pokemon.stats.firstWhere((stat) => stat.name.trim() == key)));
    }

    //List <Widget> pokemonStatsList = widget.pokemon.stats.map((eachStat)=>pokemonStatRow(eachStat)).toList();

    return Container(
      margin: EdgeInsets.fromLTRB(0, widget.screenUtil.setHeight(15), 0,
          widget.screenUtil.setHeight(30)),
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
                    // gradient: pokemonStatBarGradient,
                    color: pokemonPageUltility().pokemonColor(),
                    borderRadius:
                        BorderRadius.circular(widget.screenUtil.setHeight(4))),
              ),
            ],
          )),
        ],
      ),
    );
  }

  Widget abilitySection() {
    Widget abilitySeparatorWidget = Container(
        margin: EdgeInsets.fromLTRB(
            widget.screenUtil.setWidth(25),
            widget.screenUtil.setHeight(10),
            widget.screenUtil.setWidth(25),
            widget.screenUtil.setHeight(10)),
        decoration: BoxDecoration(
            border: Border(
          bottom: BorderSide(width: 0.3, color: Color(0xFFbdbdbd)),
        )));
    List<PokemonAbility> pokemonAbilitiesSorted = widget.pokemon.abilities;
    pokemonAbilitiesSorted.sort((a, b) => a.slot.compareTo(b.slot));
    List<Widget> abilitiesWidgetList = [];
    for (var ability in pokemonAbilitiesSorted) {
      abilitiesWidgetList.add(abilityRow(ability));
      abilitiesWidgetList.add(abilitySeparatorWidget);
    }
    abilitiesWidgetList.removeLast();
    return sectionPanel(
        sectionHeader: "Abilities",
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: abilitiesWidgetList,
        ));
  }

  Widget abilityRow(PokemonAbility pokemonAbility) {
    String pokemonAbilityName =
        upperCaseEveryWords(pokemonAbility.name.replaceAll('-', ' '));
    String pokemonAbilityDescription =
        pokemonAbility.description.replaceAll('\n', ' ');
    bool isHidden = pokemonAbility.isHidden;

    Widget isHiddenIcon() {
      if (isHidden) {
        return Container(
          margin: EdgeInsets.only(
            left: widget.screenUtil.setWidth(5),
          ),
          child: Icon(
            Icons.link_off,
            color: pokemonPageUltility().pokemonColor(),
            size: widget.screenUtil.setWidth(18),
          ),
        );
      } else {
        return Container();
      }
    }

    return Container(
      margin: EdgeInsets.fromLTRB(
          widget.screenUtil.setWidth(10),
          widget.screenUtil.setHeight(10),
          widget.screenUtil.setWidth(10),
          widget.screenUtil.setHeight(10)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            child: Row(
              children: <Widget>[
                Text(
                  pokemonAbilityName,
                  style: TextStyle(
                      color: pokemonPageUltility().pokemonColor(),
                      fontFamily: "Avenir-Medium",
                      height: 1.3,
                      fontSize: widget.screenUtil.setSp(16),
                      fontWeight: FontWeight.w500),
                ),
                isHiddenIcon()
              ],
            ),
          ),
          Container(
            child: Text(
              pokemonAbilityDescription,
              style: TextStyle(
                  color: Color(0xFF4F4F4F),
                  fontFamily: "Avenir-Book",
                  height: 1.3,
                  fontSize: widget.screenUtil.setSp(15),
                  fontWeight: FontWeight.w300),
            ),
          )
        ],
      ),
    );
  }

  Widget breedingSection() {
    return sectionPanel(
        sectionHeader: "Breeding",
        child: Row(
          children: <Widget>[
            eggGroupContent(),
            hatchTimeContent(),
            genderContent()
          ],
        ));
  }

  Widget eggGroupContent() {
    List<Widget> eggGroupContentList = [];
    for (var item in widget.pokemon.eggGroup) {
      eggGroupContentList.add(Container(
        child: Text(
          upperCaseEveryWords(item),
          style: TextStyle(
              color: Color(0xFF4F4F4F),
              fontFamily: "Avenir-Book",
              height: 1.3,
              fontSize: widget.screenUtil.setSp(15),
              fontWeight: FontWeight.w300),
        ),
      ));
    }

    return subSectionPanel(
        subSectionHeader: "Egg Group",
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: eggGroupContentList,
        ));
  }

  Widget hatchTimeContent() {
    Widget hatchTimeRowBuild(bool isCycle) {
      String textInput;
      if (isCycle == true) {
        textInput = ((widget.pokemon.hatchCycle).toString() + " cycle");
      } else {
        textInput = ((widget.pokemon.hatchCycle * 257).toString() + " steps");
      }
      return Container(
        child: Text(
          textInput,
          style: TextStyle(
              color: Color(0xFF4F4F4F),
              fontFamily: "Avenir-Book",
              height: 1.3,
              fontSize: widget.screenUtil.setSp(15),
              fontWeight: FontWeight.w300),
        ),
      );
    }

    return subSectionPanel(
        subSectionHeader: "Hatch Time",
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: List()
            ..add(hatchTimeRowBuild(false))
            ..add(hatchTimeRowBuild(true)),
        ));
  }

  Widget genderContent() {
    Widget genderColumn() {
      return Container(
        width: widget.screenUtil.setWidth(50),
        height: widget.screenUtil.setHeight(50),
        child: Column(
          children: <Widget>[
            Container(
              child: Text(
                (100 * widget.pokemon.genderRate.abs() / 8).toStringAsPrecision(3) +
                    '%',
                style: TextStyle(
                    color: Color(0xFFCE71E1),
                    fontFamily: "Avenir-Book",
                    height: 1.3,
                    fontSize: widget.screenUtil.setSp(15),
                    fontWeight: FontWeight.w300),
              ),
            ),
            Container(
              child: Text(
                (700 * widget.pokemon.genderRate.abs() / 8).toStringAsPrecision(3) +
                    '%',
                style: TextStyle(
                    color: Color(0xFF80B6F4),
                    fontFamily: "Avenir-Book",
                    height: 1.3,
                    fontSize: widget.screenUtil.setSp(15),
                    fontWeight: FontWeight.w300),
              ),
            ),
          ],
        ),
      );
    }

    Widget genderPie() {
      return Container(
        width: widget.screenUtil.setWidth(40),
        height: widget.screenUtil.setHeight(43),
        child: CircularPercentIndicator(
          radius: widget.screenUtil.setWidth(37),
          lineWidth: 3.5,
          percent: (widget.pokemon.genderRate.abs() / 8),
          center: Image.asset(
            'assets/img/gender_ring.png',
            width: widget.screenUtil.setWidth(18),
            height: widget.screenUtil.setHeight(18),
          ),
          progressColor: Color(0xFFCE71E1),
          backgroundColor: Color(0xFF80B6F4),
        ),
      );
    }
        List<Widget> genderFinalContent(){
          print(widget.pokemon.genderRate.abs());
      if(widget.pokemon.genderRate == -1){
        print("gender Rate is negative");
        return [Image.asset(
            'assets/img/gender_ring.png',
            width: widget.screenUtil.setWidth(30),
            height: widget.screenUtil.setHeight(30),
          )];
      }
      else{
        return [genderColumn(), genderPie()];
      }
    }

    return subSectionPanel(
        isLastSubSection: true,
        subSectionHeader: "Gender",
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: genderFinalContent(),
        ));
  }

  Widget captureSection() {
    Widget habitatContent() {
      return subSectionPanel(
          subSectionHeader: "Habitat",
          child: Container(
            margin: EdgeInsets.only(bottom: widget.screenUtil.setHeight(10)),
            child: Text(
              widget.pokemon.habitat,
              style: TextStyle(
                  color: Color(0xFF4F4F4F),
                  fontFamily: "Avenir-Book",
                  height: 1.3,
                  fontSize: widget.screenUtil.setSp(15),
                  fontWeight: FontWeight.w300),
            ),
          ));
    }

    Widget generationContent() {
      return subSectionPanel(
          subSectionHeader: "Generation",
          child: Container(
            margin: EdgeInsets.only(bottom: widget.screenUtil.setHeight(10)),
            child: Text(
              widget.pokemon.generation,
              style: TextStyle(
                  color: Color(0xFF4F4F4F),
                  fontFamily: "Avenir-Book",
                  height: 1.3,
                  fontSize: widget.screenUtil.setSp(15),
                  fontWeight: FontWeight.w300),
            ),
          ));
    }

    Widget captureRateContent() {
      Widget captureRateText() {
        return Container(
          child: Text(
            (100* widget.pokemon.captureRate/550).toStringAsPrecision(3) + '%',
            style: TextStyle(
                color: Color(0xFF80B6F4),
                fontFamily: "Avenir-Book",
                height: 1.3,
                fontSize: widget.screenUtil.setSp(15),
                fontWeight: FontWeight.w300),
          ),
        );
      }

      Widget captureRatePie() {
        return Container(
          width: widget.screenUtil.setWidth(40),
          height: widget.screenUtil.setHeight(43),
          child: CircularPercentIndicator(
            radius: widget.screenUtil.setWidth(37),
            lineWidth: 3.5,
            percent: (widget.pokemon.captureRate/ 550),
            center: Image.asset(
              'assets/img/capture_pokeball.png',
              width: widget.screenUtil.setWidth(18),
              height: widget.screenUtil.setHeight(18),
            ),
            progressColor: pokemonPageUltility().pokemonColor(),
            backgroundColor: Color(0xFFE6E6E6),
          ),
        );
      }

      return subSectionPanel(
          isLastSubSection: true,
          subSectionHeader: "Capture Rate",
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[captureRateText(), captureRatePie()],
          ));
    }

    return sectionPanel(
      sectionHeader: "Capture",
      child: Row(
        children: <Widget>[
          habitatContent(),
          generationContent(),
          captureRateContent()
        ],
      ),
    );
  }

  Widget spritesPanel() {
    Widget spriteSubSection({String header, String url}) {
      return Container(
          child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            child: Text(
              header,
              style: TextStyle(
                  color: pokemonPageUltility().pokemonColor(),
                  fontFamily: "Avenir-Medium",
                  height: 1.3,
                  fontSize: widget.screenUtil.setSp(16),
                  fontWeight: FontWeight.w400),
            ),
          ),
          Container(
              child: Image.network(url,
                  scale: 0.01,
                  
                  height: widget.screenUtil.setHeight(sectionWidth / 2),
                  filterQuality: FilterQuality.high,
                  fit: BoxFit.fitWidth))
        ],
      ));
    }

    String normalUrl = "https://img.pokemondb.net/sprites/x-y/normal/" +
        widget.pokemon.name.trim() +
        ".png";
    String shinyUrl = "https://img.pokemondb.net/sprites/x-y/shiny/" +
        widget.pokemon.name.trim() +
        ".png";
    return sectionPanel(
      sectionHeader: "Sprites",
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          spriteSubSection(
              header: 'Normal', url: normalUrl),
          spriteSubSection(
              header: 'Shiny', url: shinyUrl),
        ],
      ),
    );
  }

  Widget sectionPanel(
      {String sectionHeader, Widget child, bool haveHeader = true}) {
    Widget header() {
      if (haveHeader) {
        return sectionTitle(sectionHeader);
      } else {
        return Container();
      }
    }

    return Container(
        width: widget.screenUtil.setWidth(sectionWidth),
        margin: EdgeInsets.fromLTRB(
            widget.screenUtil.setWidth(0),
            widget.screenUtil.setHeight(15),
            widget.screenUtil.setWidth(0),
            widget.screenUtil.setHeight(15)),
        child: Column(
          children: <Widget>[header(), child],
        ));
  }

  Widget subSectionPanel(
      {String subSectionHeader, Widget child, bool isLastSubSection = false}) {
    //subSectionTitle Widget
    Widget header() {
      return Container(
        margin: EdgeInsets.only(bottom: widget.screenUtil.setHeight(10)),
        child: Text(
          subSectionHeader,
          style: TextStyle(
              color: pokemonPageUltility().pokemonColor(),
              fontFamily: "Avenir-Medium",
              height: 1.3,
              fontSize: widget.screenUtil.setSp(16),
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
      width: widget.screenUtil.setWidth(subSectionWidth),
      height: widget.screenUtil.setHeight(85),
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

  Widget sectionTitle(String title) {
    Color pokemonColor = pokemonPageUltility().pokemonColor();
    return Container(
      height: widget.screenUtil.setHeight(60),
      margin: EdgeInsets.only(bottom: 10),
      child: Center(
        child: Text(
          title,
          style: TextStyle(
              color: pokemonColor,
              fontFamily: 'Avenir-Book',
              fontSize: widget.screenUtil.setSp(20)),
        ),
      ),
    );
  }
}
