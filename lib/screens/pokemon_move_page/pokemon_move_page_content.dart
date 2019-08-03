import 'package:flutter/material.dart';
import 'package:pokedex/models/pokemon_move.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pokedex/data/pokemon_color.dart';
import 'package:pokedex/screens/pokemon_page/page_tab/pokemon_page_tab.dart';
import 'package:pokedex/components/animation/pokemon_page_animation.dart';
import 'package:pokedex/screens/pokemon_page/pokemon_page_header.dart';

class PokemonMovePageContent extends StatelessWidget {
  const PokemonMovePageContent({Key key, this.pokemonMoveDetail, this.color})
      : super(key: key);
  final PokemonMoveDetail pokemonMoveDetail;
  final Color color;

  @override
  Widget build(BuildContext context) {

    String mainImgDirectory =
        'assets/img/type/' + pokemonMoveDetail.type + ".png";
    String secondaryImgDirectory =
        'assets/img/tag/' + pokemonMoveDetail.type + '.png';
    return Stack(
      children: <Widget>[
        Column(
          children: <Widget>[
            SizedBox(height: ScreenUtil.getInstance().setHeight(130)),
            SwipeDownTrigger(
              child: HeaderImageAnimation(
                delay: 3,
                child: MovePageIcon(
                    directory: mainImgDirectory,
                    height: ScreenUtil.getInstance().setHeight(110),
                    width: ScreenUtil.getInstance().setWidth(110)),
              ),
            ),
            FadeIn(
              delay: 4,
              child: MoveNamePanel(name: pokemonMoveDetail.name),
            ),
            FadeIn(
              delay: 5,
              child: MovePageIcon(
                  directory: secondaryImgDirectory,
                  height: ScreenUtil.getInstance().setHeight(110),
                  width: ScreenUtil.getInstance().setWidth(110)),
            ),
            SizedBox(
              height: ScreenUtil.getInstance().setHeight(20),
            ),
            FadeIn(
              delay: 6,
              child: MoveDescriptionPanel(
                description: pokemonMoveDetail.description,
              ),
            ),
            SizedBox(
              height: ScreenUtil.getInstance().setHeight(20),
            ),
            FadeIn(
                delay: 6,
                child: MoveSectionPanel(
                    moveDetail: pokemonMoveDetail, typeColor: color)),
          ],
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
}

class MovePageIcon extends StatelessWidget {
  const MovePageIcon({Key key, this.directory, this.height, this.width})
      : super(key: key);
  final String directory;
  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Center(
        child: Image.asset(
          directory,
          width: width,
          height: height,
        ),
      ),
    );
  }
}

class MoveNamePanel extends StatelessWidget {
  const MoveNamePanel({Key key, this.name}) : super(key: key);
  final String name;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        child: Center(
          child: Text(upperCaseEveryWords(name.replaceAll('-', ' ')),
              style: TextStyle(
                  fontFamily: 'Avenir-Book',
                  fontSize: ScreenUtil.getInstance().setSp(40),
                  color: Color(0xFF4F4F4F),
                  fontWeight: FontWeight.w100)),
        ));
  }
}

class MoveDescriptionPanel extends StatelessWidget {
  const MoveDescriptionPanel({Key key, this.description}) : super(key: key);
  final String description;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      //color: Color(0xFFFAFAFA),
      padding: EdgeInsets.only(
          left: ScreenUtil.getInstance().setWidth(20),
          right: ScreenUtil.getInstance().setWidth(20)),
      child: Center(
        child: Text(description.replaceAll('\n', ' '),
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

class MoveSectionPanel extends StatelessWidget {
  const MoveSectionPanel({Key key, this.typeColor, this.moveDetail})
      : super(key: key);
  final PokemonMoveDetail moveDetail;
  final Color typeColor;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: ScreenUtil.getInstance().setWidth(sectionWidth),
        child: Center(
          child: Row(
            children: <Widget>[
              SubSectionWidget(
                pokemonColor: typeColor,
                child: MovePanelText(text: moveDetail.basePower.toString()),
                subSectionHeader: "Base Power",
                alignmentType: MainAxisAlignment.center,
              ),
              SubSectionWidget(
                pokemonColor: typeColor,
                child: MovePanelText(text: moveDetail.accuracy.toString()),
                subSectionHeader: "Accuracy",
                alignmentType: MainAxisAlignment.center,
              ),
              SubSectionWidget(
                isLastSubSection: true,
                pokemonColor: typeColor,
                child: MovePanelText(text: moveDetail.pp.toString()),
                subSectionHeader: "PP",
                alignmentType: MainAxisAlignment.center,
              )
            ],
          ),
        ));
  }
}

class MovePanelText extends StatelessWidget {
  const MovePanelText({
    Key key,
    this.text,
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
          color: Color(0xFF4F4F4F),
          fontFamily: "Avenir-Book",
          height: 1.3,
          fontSize: ScreenUtil.getInstance().setSp(18),
          fontWeight: FontWeight.w300),
    );
  }
}
