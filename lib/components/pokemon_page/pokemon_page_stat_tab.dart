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
import 'package:pokedex/components/pokemon_page/pokemon_page_tab.dart';
import 'package:pokedex/components/animation/pokemon_page_animation.dart';


class PokemonPageStatTab extends StatelessWidget {
  const PokemonPageStatTab(
      {Key key, @required this.pokemon, @required this.pokemonColor})
      : super(key: key);
  final Pokemon pokemon;
  final Color pokemonColor;

  @override
  Widget build(BuildContext context) {
    // screenSizeStatus("PokemonPageStatTab", context);
    List<Widget> statSectionLists = [
          PokemonStatSection(
            pokemon: pokemon,
            pokemonColor: pokemonColor,
          ),
          PokemonAbilitySection(
            pokemon: pokemon,
            pokemonColor: pokemonColor,
          ),
          PokemonCaptureSection(
            pokemon: pokemon,
            pokemonColor: pokemonColor,
          ),
          PokemonSpritesSection(
            pokemon: pokemon,
            pokemonColor: pokemonColor,
          )
        ];
        List<Widget> statSectionListsOutput=[];
        double delayCount = 0.5;
        for(var widget in statSectionLists){
          statSectionListsOutput.add(
            FadeIn(delay: 1+delayCount,
            child: widget)
          );
          delayCount +=1;
        }
        statSectionListsOutput.add(BottomTabRoundedCorner(pokemonColor: pokemonColor,));
    return Container(
      color: Color(0xFFFAFAFA),
      child: TabPageViewContainer(
        tabKey: "STATS",
                pageContent: SliverList(
                delegate: SliverChildListDelegate(statSectionListsOutput),
              )
      ),
    );
  }
}

class PokemonStatSection extends StatelessWidget {
  const PokemonStatSection(
      {Key key, @required this.pokemon, @required this.pokemonColor})
      : super(key: key);
  final Pokemon pokemon;
  final Color pokemonColor;

  @override
  Widget build(BuildContext context) {
    List<Widget> pokemonStatsList = [];
    double delaycount = 0.5;
    for (var key in pokemonStatTypesMap.keys) {
      pokemonStatsList.add(
        FadeIn(
          delay: 1+ delaycount,
                  child: PokemonStatRow(
                    pokemon: pokemon,
            pokemonStat:
                pokemon.stats.firstWhere((stat) => stat.name.trim() == key),
            pokemonColor: pokemonColor),
        ));
        delaycount+=0.5;
    }

    return Container(
      margin: EdgeInsets.fromLTRB(0, ScreenUtil.getInstance().setHeight(15), 0,
          ScreenUtil.getInstance().setHeight(30)),
      child: Column(
        children: pokemonStatsList,
      ),
    );
  }
}

class PokemonStatRow extends StatelessWidget {
  const PokemonStatRow(
      {Key key, @required this.pokemonStat, @required this.pokemonColor,@required this.pokemon})
      : super(key: key);
  final PokemonStat pokemonStat;
  final Color pokemonColor;
  final Pokemon pokemon;
    PokemonPageUltility pokemonPageUltility() => PokemonPageUltility(pokemon);


  @override
  Widget build(BuildContext context) {
    double statBarHeight = ScreenUtil.getInstance().setHeight(8);
    double fullBarWidth = ScreenUtil.getInstance().setWidth(240);
    double statBarWidth =
        ScreenUtil.getInstance().setWidth((pokemonStat.value / 240) * 240.0);
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
                  color: pokemonColor,
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
              // Container(
              //   height: statBarHeight,
              //   width: statBarWidth,
              //   decoration: BoxDecoration(
              //       // gradient: pokemonStatBarGradient,
              //       color: pokemonColor,
              //       borderRadius: BorderRadius.circular(
              //           ScreenUtil.getInstance().setHeight(4))),
              // )
              StatBarPanelAnimation(
                statValue: statBarWidth,
                pokemonColor: pokemonColor,
                pokemonGradient: pokemonPageUltility().pokemonColorGradient(),
                child: Container(),
              )
            ],
          )),
        ],
      ),
    );
  }
}

class PokemonAbilitySection extends StatelessWidget {
  const PokemonAbilitySection(
      {Key key, @required this.pokemon, @required this.pokemonColor})
      : super(key: key);
  final Pokemon pokemon;
  final Color pokemonColor;

  @override
  Widget build(BuildContext context) {
    // screenSizeStatus("PokemonStatSection", context);

    List<PokemonAbility> pokemonAbilitiesSorted = pokemon.abilities;
    pokemonAbilitiesSorted.sort((a, b) => a.slot.compareTo(b.slot));
    List<Widget> abilitiesWidgetList = [];
    for (var ability in pokemonAbilitiesSorted) {
      abilitiesWidgetList.add(PokemonAbilityRow(
        pokemonAbility: ability,
        pokemonColor: pokemonColor,
      ));
      abilitiesWidgetList.add(PokemonAbilitySeparatorWidget());
    }
    abilitiesWidgetList.removeLast();

    return SectionPanel(
        pokemon: pokemon,
        sectionHeader: "Abilities",
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: abilitiesWidgetList,
        ));
  }
}

class PokemonAbilitySeparatorWidget extends StatelessWidget {
  const PokemonAbilitySeparatorWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.fromLTRB(
            ScreenUtil.getInstance().setWidth(25),
            ScreenUtil.getInstance().setHeight(10),
            ScreenUtil.getInstance().setWidth(25),
            ScreenUtil.getInstance().setHeight(10)),
        decoration: BoxDecoration(
            border: Border(
          bottom: BorderSide(width: 0.3, color: Color(0xFFbdbdbd)),
        )));
  }
}

class PokemonAbilityRow extends StatelessWidget {
  const PokemonAbilityRow(
      {Key key, @required this.pokemonAbility, @required this.pokemonColor})
      : super(key: key);
  final PokemonAbility pokemonAbility;
  final Color pokemonColor;

  @override
  Widget build(BuildContext context) {
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
            color: pokemonColor,
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
                      color: pokemonColor,
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
}

class PokemonBreedingSection extends StatelessWidget {
  const PokemonBreedingSection(
      {Key key, @required this.pokemon, @required this.pokemonColor})
      : super(key: key);
  final Pokemon pokemon;
  final Color pokemonColor;

  @override
  Widget build(BuildContext context) {
    return SectionPanel(
        pokemon: pokemon,
        sectionHeader: "Breeding",
        child: Row(
          children: <Widget>[
            EggGroupContent(
              pokemon: pokemon,
              pokemonColor: pokemonColor,
            ),
            HatchTimeContent(
              pokemonColor: pokemonColor,
              pokemon: pokemon,
            ),
            GenderContent(
                            pokemonColor: pokemonColor,
              pokemon: pokemon,
            )
          ],
        ));
  }
}

class EggGroupContent extends StatelessWidget {
  const EggGroupContent({Key key, @required this.pokemon, this.pokemonColor})
      : super(key: key);
  final Pokemon pokemon;
  final Color pokemonColor;
  @override
  Widget build(BuildContext context) {
    List<Widget> eggGroupContentList = [];
    for (var item in pokemon.eggGroup) {
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

    return SubSectionWidget(
        pokemonColor: pokemonColor,
        subSectionHeader: "Egg Group",
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: eggGroupContentList,
        ));
  }
}

class HatchTimeContent extends StatelessWidget {
  const HatchTimeContent({Key key, @required this.pokemon,@required this.pokemonColor}) : super(key: key);
  final Pokemon pokemon;
  final Color pokemonColor;

  @override
  Widget build(BuildContext context) {
    return SubSectionWidget(
      pokemonColor: pokemonColor,
        subSectionHeader: "Hatch Time",
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: List()
            ..add(HatchTimeRowBuild(
              isCycle: false,
              pokemon: pokemon,
            ))
            ..add(HatchTimeRowBuild(
              isCycle: true,
              pokemon: pokemon,
            )),
        ));
  }
}

class HatchTimeRowBuild extends StatelessWidget {
  const HatchTimeRowBuild(
      {Key key, @required this.isCycle, @required this.pokemon})
      : super(key: key);
  final bool isCycle;
  final Pokemon pokemon;

  @override
  Widget build(BuildContext context) {
    String textInput;
    if (isCycle == true) {
      textInput = ((pokemon.hatchCycle).toString() + " cycle");
    } else {
      textInput = ((pokemon.hatchCycle * 257).toString() + " steps");
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
}

class GenderContent extends StatelessWidget {
  const GenderContent({Key key,@required this.pokemon,@required this.pokemonColor}) : super(key: key);
  final Pokemon pokemon;
  final Color pokemonColor;

  @override
  Widget build(BuildContext context) {
    List<Widget> genderFinalContent() {
      if (pokemon.genderRate == -1) {
        return [
          Image.asset(
            'assets/img/gender_ring.png',
            width: ScreenUtil.getInstance().setWidth(30),
            height: ScreenUtil.getInstance().setHeight(30),
          )
        ];
      } else {
        return [
          GenderColumn(pokemon: pokemon),
          GenderPieChart(pokemon: pokemon)
        ];
      }
    }

    return SubSectionWidget(
      pokemonColor: pokemonColor,
        isLastSubSection: true,
        subSectionHeader: "Gender",
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: genderFinalContent(),
        ));
  }
}

class GenderPieChart extends StatelessWidget {
  const GenderPieChart({
    Key key,
    @required this.pokemon,
  }) : super(key: key);

  final Pokemon pokemon;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtil.getInstance().setWidth(40),
      height: ScreenUtil.getInstance().setHeight(40),
      child: CircularPercentIndicator(
        radius: ScreenUtil.getInstance().setWidth(37),
        lineWidth: 3.5,
        percent: (pokemon.genderRate.abs() / 8),
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
}

class GenderColumn extends StatelessWidget {
  const GenderColumn({
    Key key,
    @required this.pokemon,
  }) : super(key: key);

  final Pokemon pokemon;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtil.getInstance().setWidth(50),
      height: ScreenUtil.getInstance().setHeight(50),
      child: Column(
        children: <Widget>[
          Container(
            child: Text(
              (100 * pokemon.genderRate.abs() / 8).toStringAsPrecision(3) + '%',
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
              (700 * pokemon.genderRate.abs() / 8).toStringAsPrecision(3) + '%',
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
}

class PokemonCaptureSection extends StatelessWidget {
  const PokemonCaptureSection(
      {Key key, @required this.pokemon, @required this.pokemonColor})
      : super(key: key);
  final Pokemon pokemon;
  final Color pokemonColor;

  @override
  Widget build(BuildContext context) {
    return SectionPanel(
      pokemon: pokemon,
      sectionHeader: "Capture",
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          HabitatContent(pokemon: pokemon, pokemonColor: pokemonColor,),
          GenerationContent(pokemon: pokemon, pokemonColor: pokemonColor,),
          CaptureRateContent(pokemon: pokemon, pokemonColor: pokemonColor)
        ],
      ),
    );
  }
}

class GenerationContent extends StatelessWidget {
  const GenerationContent({
    Key key,
    @required this.pokemon,
     @required this.pokemonColor
  }) : super(key: key);

  final Pokemon pokemon;
  final Color pokemonColor;
  @override
  Widget build(BuildContext context) {
    return SubSectionWidget(
      pokemonColor: pokemonColor,
        subSectionHeader: "Generation",
        child: Container(
          margin:
              EdgeInsets.only(bottom: ScreenUtil.getInstance().setHeight(10)),
          child: Text(
            pokemon.generation,
            style: TextStyle(
                color: Color(0xFF4F4F4F),
                fontFamily: "Avenir-Book",
                height: 1.3,
                fontSize: ScreenUtil.getInstance().setSp(15),
                fontWeight: FontWeight.w300),
          ),
        ));
  }
}

class HabitatContent extends StatelessWidget {
  const HabitatContent({
    Key key,
    @required this.pokemon,
    @required this.pokemonColor
  }) : super(key: key);

  final Pokemon pokemon;
  final Color pokemonColor;

  @override
  Widget build(BuildContext context) {
    return SubSectionWidget(
      pokemonColor: pokemonColor,
        subSectionHeader: "Habitat",
        child: Container(
          margin:
              EdgeInsets.only(bottom: ScreenUtil.getInstance().setHeight(10)),
          child: Text(
            pokemon.habitat,
            style: TextStyle(
                color: Color(0xFF4F4F4F),
                fontFamily: "Avenir-Book",
                height: 1.3,
                fontSize: ScreenUtil.getInstance().setSp(15),
                fontWeight: FontWeight.w300),
          ),
        ));
  }
}

class CaptureRateContent extends StatelessWidget {
  const CaptureRateContent({
    Key key,
    @required this.pokemon,
    @required this.pokemonColor,
  }) : super(key: key);

  final Pokemon pokemon;
  final Color pokemonColor;

  @override
  Widget build(BuildContext context) {
    return SubSectionWidget(
      pokemonColor: pokemonColor,
        isLastSubSection: true,
        subSectionHeader: "Capture Rate",
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            CaptureRateText(pokemon: pokemon),
            CaptureRatePieChart(pokemon: pokemon, pokemonColor: pokemonColor)
          ],
        ));
  }
}

class CaptureRatePieChart extends StatelessWidget {
  const CaptureRatePieChart({
    Key key,
    @required this.pokemon,
    @required this.pokemonColor,
  }) : super(key: key);

  final Pokemon pokemon;
  final Color pokemonColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtil.getInstance().setWidth(40),
      height: ScreenUtil.getInstance().setHeight(43),
      child: CircularPercentIndicator(
        radius: ScreenUtil.getInstance().setWidth(28),
        lineWidth: 3.5,
        percent: (pokemon.captureRate / 550),
        center: Image.asset(
          'assets/img/capture_pokeball.png',
          width: ScreenUtil.getInstance().setWidth(18),
          height: ScreenUtil.getInstance().setHeight(18),
        ),
        progressColor: pokemonColor,
        backgroundColor: Color(0xFFE6E6E6),
      ),
    );
  }
}

class CaptureRateText extends StatelessWidget {
  const CaptureRateText({
    Key key,
    @required this.pokemon,
  }) : super(key: key);

  final Pokemon pokemon;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        (100 * pokemon.captureRate / 550).toStringAsPrecision(3) + '%',
        style: TextStyle(
            color: Color(0xFF80B6F4),
            fontFamily: "Avenir-Book",
            height: 1.3,
            fontSize: ScreenUtil.getInstance().setSp(15),
            fontWeight: FontWeight.w300),
      ),
    );
  }
}

class PokemonSpritesSection extends StatelessWidget {
  const PokemonSpritesSection(
      {Key key, @required this.pokemon, @required this.pokemonColor})
      : super(key: key);
  final Pokemon pokemon;
  final Color pokemonColor;

  @override
  Widget build(BuildContext context) {
    String normalUrl = "https://img.pokemondb.net/sprites/x-y/normal/" +
        pokemon.name.trim() +
        ".png";
    String shinyUrl = "https://img.pokemondb.net/sprites/x-y/shiny/" +
        pokemon.name.trim() +
        ".png";
    return SectionPanel(
      pokemon: pokemon,
      sectionHeader: "Sprites",
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SpriteSubSection(
              pokemonColor: pokemonColor, header: 'Normal', url: normalUrl),
          SpriteSubSection(
              pokemonColor: pokemonColor, header: 'Shiny', url: shinyUrl),
        ],
      ),
    );
  }
}

class SpriteSubSection extends StatelessWidget {
  const SpriteSubSection({
    Key key,
    @required this.pokemonColor,
    @required this.header,
    @required this.url,
  }) : super(key: key);

  final Color pokemonColor;
  final String header;
  final String url;

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          child: Text(
            header,
            style: TextStyle(
                color: pokemonColor,
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
}
