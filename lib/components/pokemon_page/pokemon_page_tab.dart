//Flutter Package
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

//Addition Package
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:percent_indicator/percent_indicator.dart';

//Internal Package
import 'package:pokedex/models/pokemon.dart';
import 'package:pokedex/components/pokemon_page/pokemon_page_comp.dart';
import 'package:pokedex/components/pokemon_page/pokemon_page_evolution_tab.dart';
import 'package:pokedex/components/pokemon_page/pokemon_page_moves_tab.dart';

const double sectionWidth = 345;
const double subSectionWidth = sectionWidth / 3;

class PokemonTabPanel extends StatefulWidget {
  PokemonTabPanel({Key key, this.pokemon}) : super(key: key);
  final Pokemon pokemon;

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
    double defaultScreenWidth = 375.0;
    double defaultScreenHeight = 812.0;
    ScreenUtil.instance = ScreenUtil(
      width: defaultScreenWidth,
      height: defaultScreenHeight,
      allowFontScaling: true,
    )..init(context);
    // return SliverStickyHeader(
    //   header: tabBar(),
    //   sliver: SliverList(
    //       delegate: SliverChildListDelegate([
    //     tabBarPages(),
    //   ])),
    // );
  }

  Widget tabBar() {
    BoxDecoration tabBarIndicatorBoxDecoration = BoxDecoration(
      color: pokemonPageUltility().pokemonColor(),
      borderRadius:
          BorderRadius.circular(ScreenUtil.getInstance().setWidth(22.5)),
      // border: Border.all(
      //     width: ScreenUtil.getInstance().setWidth(1), color: const Color(0XFF979797)),
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
        controller: tabController,
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

  Widget tabBarPages() {
    return Container(
      color: Color(0xFFFAFAFA),
      height: 1400,
      child: TabBarView(controller: tabController, children: <Widget>[
        statTabPage(),
        PokemonEvolutionTab(
          pokemon: widget.pokemon,
          screenUtil: ScreenUtil.getInstance(),
        ),
        PokemonMovesTab(
          pokemon: widget.pokemon,
          screenUtil: ScreenUtil.getInstance(),
        ),
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
      margin: EdgeInsets.fromLTRB(0, ScreenUtil.getInstance().setHeight(15), 0,
          ScreenUtil.getInstance().setHeight(30)),
      child: Column(
        children: pokemonStatsList,
      ),
    );
  }

  Widget pokemonStatRow(PokemonStat pokemonStat) {
    double statBarHeight = ScreenUtil.getInstance().setHeight(8);
    double fullBarWidth = ScreenUtil.getInstance().setWidth(240);
    double statBarWidth =
        ScreenUtil.getInstance().setWidth((pokemonStat.value / 100) * 240.0);
    double statTextWidth = ScreenUtil.getInstance().setWidth(40);

    return Container(
      margin: EdgeInsets.fromLTRB(0, ScreenUtil.getInstance().setHeight(5), 0,
          ScreenUtil.getInstance().setHeight(5)),
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
                  fontSize: ScreenUtil.getInstance().setSp(14),
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
                  fontSize: ScreenUtil.getInstance().setSp(14)),
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
                    borderRadius: BorderRadius.circular(
                        ScreenUtil.getInstance().setHeight(4))),
              ),

              //statBar
              Container(
                height: statBarHeight,
                width: statBarWidth,
                decoration: BoxDecoration(
                    // gradient: pokemonStatBarGradient,
                    color: pokemonPageUltility().pokemonColor(),
                    borderRadius: BorderRadius.circular(
                        ScreenUtil.getInstance().setHeight(4))),
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
            ScreenUtil.getInstance().setWidth(25),
            ScreenUtil.getInstance().setHeight(10),
            ScreenUtil.getInstance().setWidth(25),
            ScreenUtil.getInstance().setHeight(10)),
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
            left: ScreenUtil.getInstance().setWidth(5),
          ),
          child: Icon(
            Icons.link_off,
            color: pokemonPageUltility().pokemonColor(),
            size: ScreenUtil.getInstance().setWidth(18),
          ),
        );
      } else {
        return Container();
      }
    }

    return Container(
      margin: EdgeInsets.fromLTRB(
          ScreenUtil.getInstance().setWidth(10),
          ScreenUtil.getInstance().setHeight(10),
          ScreenUtil.getInstance().setWidth(10),
          ScreenUtil.getInstance().setHeight(10)),
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
                      fontSize: ScreenUtil.getInstance().setSp(16),
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
                  fontSize: ScreenUtil.getInstance().setSp(15),
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
              fontSize: ScreenUtil.getInstance().setSp(15),
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
              fontSize: ScreenUtil.getInstance().setSp(15),
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
        width: ScreenUtil.getInstance().setWidth(50),
        height: ScreenUtil.getInstance().setHeight(50),
        child: Column(
          children: <Widget>[
            Container(
              child: Text(
                (100 * widget.pokemon.genderRate.abs() / 8)
                        .toStringAsPrecision(3) +
                    '%',
                style: TextStyle(
                    color: Color(0xFFCE71E1),
                    fontFamily: "Avenir-Book",
                    height: 1.3,
                    fontSize: ScreenUtil.getInstance().setSp(15),
                    fontWeight: FontWeight.w300),
              ),
            ),
            Container(
              child: Text(
                (700 * widget.pokemon.genderRate.abs() / 8)
                        .toStringAsPrecision(3) +
                    '%',
                style: TextStyle(
                    color: Color(0xFF80B6F4),
                    fontFamily: "Avenir-Book",
                    height: 1.3,
                    fontSize: ScreenUtil.getInstance().setSp(15),
                    fontWeight: FontWeight.w300),
              ),
            ),
          ],
        ),
      );
    }

    Widget genderPie() {
      return Container(
        width: ScreenUtil.getInstance().setWidth(40),
        height: ScreenUtil.getInstance().setHeight(43),
        child: CircularPercentIndicator(
          radius: ScreenUtil.getInstance().setWidth(37),
          lineWidth: 3.5,
          percent: (widget.pokemon.genderRate.abs() / 8),
          center: Image.asset(
            'assets/img/gender_ring.png',
            width: ScreenUtil.getInstance().setWidth(18),
            height: ScreenUtil.getInstance().setHeight(18),
          ),
          progressColor: Color(0xFFCE71E1),
          backgroundColor: Color(0xFF80B6F4),
        ),
      );
    }

    List<Widget> genderFinalContent() {
      print(widget.pokemon.genderRate.abs());
      if (widget.pokemon.genderRate == -1) {
        print("gender Rate is negative");
        return [
          Image.asset(
            'assets/img/gender_ring.png',
            width: ScreenUtil.getInstance().setWidth(30),
            height: ScreenUtil.getInstance().setHeight(30),
          )
        ];
      } else {
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
            margin:
                EdgeInsets.only(bottom: ScreenUtil.getInstance().setHeight(10)),
            child: Text(
              widget.pokemon.habitat,
              style: TextStyle(
                  color: Color(0xFF4F4F4F),
                  fontFamily: "Avenir-Book",
                  height: 1.3,
                  fontSize: ScreenUtil.getInstance().setSp(15),
                  fontWeight: FontWeight.w300),
            ),
          ));
    }

    Widget generationContent() {
      return subSectionPanel(
          subSectionHeader: "Generation",
          child: Container(
            margin:
                EdgeInsets.only(bottom: ScreenUtil.getInstance().setHeight(10)),
            child: Text(
              widget.pokemon.generation,
              style: TextStyle(
                  color: Color(0xFF4F4F4F),
                  fontFamily: "Avenir-Book",
                  height: 1.3,
                  fontSize: ScreenUtil.getInstance().setSp(15),
                  fontWeight: FontWeight.w300),
            ),
          ));
    }

    Widget captureRateContent() {
      Widget captureRateText() {
        return Container(
          child: Text(
            (100 * widget.pokemon.captureRate / 550).toStringAsPrecision(3) +
                '%',
            style: TextStyle(
                color: Color(0xFF80B6F4),
                fontFamily: "Avenir-Book",
                height: 1.3,
                fontSize: ScreenUtil.getInstance().setSp(15),
                fontWeight: FontWeight.w300),
          ),
        );
      }

      Widget captureRatePie() {
        return Container(
          width: ScreenUtil.getInstance().setWidth(40),
          height: ScreenUtil.getInstance().setHeight(43),
          child: CircularPercentIndicator(
            radius: ScreenUtil.getInstance().setWidth(37),
            lineWidth: 3.5,
            percent: (widget.pokemon.captureRate / 550),
            center: Image.asset(
              'assets/img/capture_pokeball.png',
              width: ScreenUtil.getInstance().setWidth(18),
              height: ScreenUtil.getInstance().setHeight(18),
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
                  fontSize: ScreenUtil.getInstance().setSp(16),
                  fontWeight: FontWeight.w400),
            ),
          ),
          Container(
            child: CachedNetworkImage(
                imageUrl: url,
                width: ScreenUtil.getInstance().setHeight(sectionWidth / 2),
                placeholder: (context, url) => CircularProgressIndicator(),
                errorWidget: (context, url, error) => Icon(Icons.error),
                fit: BoxFit.fitWidth),
          ),
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
          spriteSubSection(header: 'Normal', url: normalUrl),
          spriteSubSection(header: 'Shiny', url: shinyUrl),
        ],
      ),
    );
  }

  Widget sectionPanel(
      {String sectionHeader, Widget child, bool haveHeader = true}) {
    Widget header() {
      if (haveHeader) {
        return new SectionTitle(
          title: sectionHeader,
          pokemon: widget.pokemon,
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

  Widget subSectionPanel(
      {String subSectionHeader, Widget child, bool isLastSubSection = false}) {
    //subSectionTitle Widget
    Widget header() {
      return Container(
        margin: EdgeInsets.only(bottom: ScreenUtil.getInstance().setHeight(10)),
        child: Text(
          subSectionHeader,
          style: TextStyle(
              color: Colors.red,
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
      height: ScreenUtil.getInstance().setHeight(85),
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

class SubSectionWidget extends StatelessWidget {
  const SubSectionWidget(
      {Key key,
      this.subSectionHeader,
      this.child,
      this.isLastSubSection = false})
      : super(key: key);
  final String subSectionHeader;
  final Widget child;
  final bool isLastSubSection;

  @override
  Widget build(BuildContext context) {
    //subSectionTitle Widget
    Widget header() {
      return Container(
        margin: EdgeInsets.only(bottom: ScreenUtil.getInstance().setHeight(10)),
        child: Text(
          subSectionHeader,
          style: TextStyle(
              color: Colors.red,
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
      height: ScreenUtil.getInstance().setHeight(85),
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

//NEW SHEET
class PokemonPageTabBarView extends StatelessWidget {
  const PokemonPageTabBarView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TabBarView(
          children: <Widget>[
            TabPageViewContainer(
              tabKey: "STATS",
              pageContent: <Widget>[

              ],
            ),
                        TabPageViewContainer(
              tabKey: "EVOLUTIONS",
              pageContent: <Widget>[

              ],
            ),
                        TabPageViewContainer(
              tabKey: "MOVES",
              pageContent: <Widget>[

              ],
            ),
          ],
        );
  }
}





class TabPageViewContainer extends StatelessWidget {
  const TabPageViewContainer(
      {Key key, @required this.tabKey, @required this.pageContent})
      : super(key: key);
  final String tabKey;
  final List<Widget> pageContent;

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (BuildContext context) {
        return CustomScrollView(
          key: PageStorageKey<String>(tabKey),
          slivers: <Widget>[
            SliverOverlapInjector(
              handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
            ),
            SliverPadding(
              padding: const EdgeInsets.all(8.0),
              sliver: SliverList(
                delegate: SliverChildListDelegate(pageContent),
              ),
            )
          ],
        );
      },
    );
  }
}

