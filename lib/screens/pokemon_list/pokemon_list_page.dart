import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:pokedex/data/pokemon_list_data.dart';
import 'package:pokedex/components/animation/pokemon_list_page_animation.dart';
import 'package:pokedex/components/animation/route_transition_animation.dart';
import 'package:pokedex/data/pokemon_color.dart';
import 'package:pokedex/screens/loading_page.dart';
import 'package:pokedex/screens/pokemon_list/pokedex_cover.dart';
import 'package:pokedex/screens/pokemon_list/pokemon_list_header.dart';
import 'package:pokedex/screens/pokemon_page/pokemon_page.dart';

//the number of pokemons will be listed
final int pokemonsCount = 300;


//This widget is used for making sure the height of Container != 0
class PokemonListPageBase extends StatelessWidget {
  const PokemonListPageBase({Key key}) : super(key: key);
  Widget verifyScreenHeight(BuildContext context, double screenheight) {
    if (screenheight > 10) {
      return PokemonsListPage();
    } else {
      return Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: verifyScreenHeight(context, MediaQuery.of(context).size.height),
    );
  }
}


class PokemonsListPage extends StatefulWidget {
  const PokemonsListPage({Key key}) : super(key: key);

  @override
  _PokemonsListPageState createState() => _PokemonsListPageState();
}

class _PokemonsListPageState extends State<PokemonsListPage> {
  ScrollController _hideButtonController;
  //_isVisible is used to control whether the bottom bar will be show when scroll
  bool _isVisible = true;
  bool _isInitial = false;
  @override
  void initState() {
    super.initState();
    _isVisible = true;
    _hideButtonController = ScrollController();
    _isInitial = true;

    //Add Listener
    _hideButtonController.addListener(() {
      scrollListener();
    });
  }

  @override
  void dispose() {
    _hideButtonController.removeListener(() {
      scrollListener();
    });
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    //This app was build based on Iphone X resolution
    //ScreenUtil provided a way to normalize dimension with other Screen Resolution
    double defaultScreenWidth = 375.0;
    double defaultScreenHeight = 812.0;
    ScreenUtil.instance = ScreenUtil(
      width: defaultScreenWidth,
      height: defaultScreenHeight,
      allowFontScaling: true,
    )..init(context);

    final double topBarHeight = 14 * MediaQuery.of(context).size.height / 100;
    final double startPosition = topBarHeight - (topBarHeight / 4);

    return Material(
      child: Stack(overflow: Overflow.visible, children: <Widget>[
        CustomScrollView(
          controller: _hideButtonController,
          slivers: <Widget>[
            SliverPersistentHeader(
              delegate: PokemonListAppBar(
                  expandedHeight: topBarHeight, minHeight: topBarHeight, isVisible: _isVisible),
              floating: true,
            ),
            SliverPadding(
              padding: EdgeInsets.only(
                top: 10,
              ),
              sliver: DelayWrapper(
                child: SliverPokemonListBuild(
                  isInitial: _isInitial,
                ),
                delay: Duration(milliseconds: 200),
                waiting: SliverFillRemaining(
                  child: Container(),
                ),
              ),
            )
          ],
        ),
        //Full Bottom Bar with Animation
        //Eventually it wil be change
        BottomPanelAnimation(
          startPosition: startPosition + 10,
          endPosition: MediaQuery.of(context).size.height - topBarHeight / 1.5,
          child: AnimatedContainer(
            margin: EdgeInsets.only(
              top: _isVisible ? 0 : topBarHeight / 1.5,
            ),
            duration: Duration(milliseconds: 200),
            child: PokeDexBottom(topBarHeight: topBarHeight),
          ),
          //   child: Container(width:         MediaQuery.of(context).size.width,
          // height:MediaQuery.of(context).size.height - topBarHeight + topBarHeight / 4, color: Colors.red)
        ),
      ]),
    );
  }

  //Listener for whether to hide bottom bar through _isVisible variable
  void scrollListener() {
    double velocity = _hideButtonController.position.activity.velocity;
    if (_hideButtonController.position.userScrollDirection ==
            ScrollDirection.reverse &&
        velocity >= 100) {
      setState(() {
        _isVisible = false;
      });
    }
    if (_hideButtonController.position.userScrollDirection ==
            ScrollDirection.forward &&
        velocity <= -100) {
      setState(() {
        _isInitial = false;
        _isVisible = true;
      });
    }
  }
}

class SliverPokemonListBuild extends StatelessWidget {
  const SliverPokemonListBuild({Key key, this.isInitial}) : super(key: key);
  final bool isInitial;

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
        if (index < 8) {
          return rowItemAnimated(index);
        } else {
          return PokemonRowBuild(index: index);
        }
      }, childCount: pokemonsCount),
    );
  }

  Widget rowItemAnimated(int index) {
    if (isInitial == true) {
      return ListItemAnimation(
        index: index,
        child: PokemonRowBuild(
          index: index,
        ),
      );
    } else {
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
          ColorTransition(
              page: PokemonPage(
            pokemonGradient: pokemonGradient,
            pokemonIndex: pokemonList[index]["id"],
            loadingScreenType: LoadingScreenType.pokemon,
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
          placeholder: (context, url){
            return Container(
              height: ScreenUtil.getInstance().setHeight(70),
                        width: ScreenUtil.getInstance().setWidth(70),

              child: Image.asset(
            'assets/img/pokeshake.gif',
            height: ScreenUtil.getInstance().setWidth(30),
            width: ScreenUtil.getInstance().setWidth(30),
            alignment: Alignment.bottomCenter,
          ),
            );
          },
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
