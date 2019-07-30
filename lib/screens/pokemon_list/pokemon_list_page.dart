import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:pokedex/data/pokemon_list_data.dart';
import 'package:pokedex/screens/loading_page.dart';
import 'package:pokedex/components/animation/pokemon_list_page_animation.dart';
import 'package:pokedex/components/animation/route_transition_animation.dart';
import 'package:pokedex/components/pokemon_page/pokemon_page_comp.dart';
import 'package:pokedex/screens/pokemon_list/pokedex_cover.dart';
import 'package:pokedex/screens/pokemon_list/pokemon_list_header.dart';

final int pokemonsCount = 80;

class PokemonsListPage extends StatefulWidget {
  const PokemonsListPage({Key key}) : super(key: key);

  @override
  _PokemonsListPageState createState() => _PokemonsListPageState();
}

class _PokemonsListPageState extends State<PokemonsListPage> {
  ScrollController _hideButtonController;
  bool _isVisible = true;
  bool _isAnimated = false;

  @override
  void initState() {
    super.initState();
    _isAnimated = false;
    _isVisible = true;
    _hideButtonController = ScrollController();
    _hideButtonController.addListener(() {
      scrollListener();
    });
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

    final double topBarHeight = 18 * MediaQuery.of(context).size.height / 100;
    final double startPosition = topBarHeight - topBarHeight / 4;

    return Material(
          child: Stack(children: <Widget>[
          ListDelayAnimation(
            child: CustomScrollView(
              controller: _hideButtonController,
              slivers: <Widget>[
                SliverPersistentHeader(
                  delegate: PokemonListAppBar(
                      expandedHeight: topBarHeight, minHeight: topBarHeight),
                  pinned: false,
                  floating: true,
                ),
                SliverPadding(
                  padding: EdgeInsets.only(
                    top: 10,
                  ),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int index) {
                      return rowItemAnimated(index);
                    }, childCount: 150),
                  ),
                )
              ],
            ),
          ),
          PokemonBottomSheetAnimation(
            startPosition: startPosition+10,
            endPosition: MediaQuery.of(context).size.height - topBarHeight / 2,
            child: AnimatedContainer(
              margin: EdgeInsets.only(
                top: _isVisible ? 0 : topBarHeight / 2,
              ),
              duration: Duration(milliseconds: 200),
              child: PokeDexBottom(topBarHeight: topBarHeight),
            ),
          ),
        ]),
    )
    ;
  }

  void scrollListener() {
    if (_hideButtonController.position.userScrollDirection ==
        ScrollDirection.reverse) {
      setState(() {
        _isVisible = false;
        _isAnimated = false;
      });
    }
    if (_hideButtonController.position.userScrollDirection ==
        ScrollDirection.forward) {
      setState(() {
        _isVisible = true;
        _isAnimated = true;
      });
      
    }
  }
  Widget rowItemAnimated(int index){
    if(_isAnimated == false){
     return ListItemAnimation(
                                          child: PokemonRowBuild(
                        index: index,
                      ),
                    );
    }
    else{
     return PokemonRowBuild(
                        index: index,
                      );
    }
  }

}

class PokemonRowBuild extends StatelessWidget {
  const PokemonRowBuild({
    Key key,
    this.index,
  }) : super(key: key);
  final int index;

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
    List<String> pokemonTypeList = pokemonList[index]["type"];
    Gradient pokemonGradient =
        pokemonColorsGradient[pokemonTypeList[0].trim()];

    Navigator.push(
      context,
      FadeRoute(
          page: LoadingScreen(
        pokemonIndex: pokemonList[index]["id"],
        pokemonGradient: pokemonGradient,
      )),
    );
        },
        child: PokemonRow(dataRow: pokemonList[index]),
      );
  }
}

class PokemonRow extends StatelessWidget {
  const PokemonRow({
    Key key,
    @required this.dataRow,
  }) : super(key: key);

  final Map dataRow;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil.instance.setHeight(90),
      padding: EdgeInsets.fromLTRB(
          ScreenUtil.getInstance().setWidth(10),
          ScreenUtil.getInstance().setWidth(0),
          ScreenUtil.getInstance().setWidth(10),
          ScreenUtil.getInstance().setWidth(0)),
      decoration: BoxDecoration(
          border: Border(
        bottom: BorderSide(width: 0.3, color: Color(0xFFbdbdbd)),
      )),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          new LeftRowComponent(dataRow: dataRow),
          new RightRowComponent(dataRow: dataRow)
        ],
      ),
    );
  }
}

class LeftRowComponent extends StatelessWidget {
  const LeftRowComponent({
    Key key,
    @required this.dataRow,
  }) : super(key: key);

  final Map dataRow;

  @override
  Widget build(BuildContext context) {
    String imgUrl = "https://assets.pokemon.com/assets/cms2/img/pokedex/full/" +
        dataRow["id"].toString().padLeft(3, '0') +
        ".png";
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        CachedNetworkImage(
          height: ScreenUtil.getInstance().setHeight(70),
          width: ScreenUtil.getInstance().setWidth(70),
          imageUrl: imgUrl,
        ),
        PokemonRowTextContent(
          dataRow: dataRow,
        )
      ],
    );
  }
}

class RightRowComponent extends StatelessWidget {
  const RightRowComponent({
    Key key,
    @required this.dataRow,
  }) : super(key: key);

  final Map dataRow;

  @override
  Widget build(BuildContext context) {
    List<Widget> rightWidgetList = [];
    for (var type in dataRow["type"]) {
      String imgDirectory =
          'assets/img/type/' + type.toLowerCase().replaceAll(" ", "") + ".png";
      rightWidgetList.add(Container(
          child: Image.asset(
        imgDirectory,
        width: ScreenUtil.getInstance().setWidth(40),
        height: ScreenUtil.getInstance().setHeight(40),
      )));
    }
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: rightWidgetList,
    );
  }
}

class PokemonRowTextContent extends StatelessWidget {
  const PokemonRowTextContent({Key key, @required this.dataRow})
      : super(key: key);
  final Map dataRow;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(
          ScreenUtil.getInstance().setWidth(5),
          ScreenUtil.getInstance().setWidth(0),
          ScreenUtil.getInstance().setWidth(5),
          ScreenUtil.getInstance().setWidth(0)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            child: Text(
              dataRow["name"][0].toUpperCase() + dataRow["name"].substring(1),
              style: TextStyle(
                  color: Color(0xFF4F4F4F),
                  fontFamily: "Avenir-Medium",
                  height: 1.3,
                  fontSize: ScreenUtil.getInstance().setSp(19),
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
                  fontSize: ScreenUtil.getInstance().setSp(15),
                  fontWeight: FontWeight.w300),
            ),
          )
        ],
      ),
    );
  }
}
