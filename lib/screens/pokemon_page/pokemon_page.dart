//Flutter Package
import 'package:flutter/material.dart';

//Addition Package
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pokedex/models/pokemon_move.dart';
import 'package:pokedex/screens/pokemon_move_page/pokemon_move_page.dart';
import 'package:sprung/sprung.dart';


//Internal Package
import 'package:pokedex/models/pokemon.dart';
import 'package:pokedex/screens/pokemon_page/pokemon_page_header.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:pokedex/screens/loading_page.dart';
import 'package:pokedex/services/http/pokemon_service.dart';


const double pokemonSheetTopPosition = 222;


class PokemonPage extends StatefulWidget {
  const PokemonPage({Key key, this.pokemonGradient, this.pokemonIndex, this.moveID, this.loadingScreenType, this.moveUrl, this.pokemonMoveServiceType})
      : super(key: key);

  final Gradient pokemonGradient;
  final int pokemonIndex;
  final int moveID;
  final LoadingScreenType loadingScreenType;
  final String moveUrl;
  final PokemonMoveServiceType pokemonMoveServiceType;

  @override
  _PokemonPageState createState() => _PokemonPageState();
}

class _PokemonPageState extends State<PokemonPage> {
  bool isLoading;
  Pokemon pokemon;
  bool isPokemon;
  bool isMove;
  PokemonMoveDetail pokemonMove;

  @override
  void initState() {
    setState(() {
      isLoading = true;
      isPokemon = false;
      isMove = false;
    });
    pokemonServiceTypeLookup();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //Set up Resolution Scaling depending on user's device resolutions
    double defaultScreenWidth = 375.0;
    double defaultScreenHeight = 812.0;

    ScreenUtil.instance = ScreenUtil(
      width: defaultScreenWidth,
      height: defaultScreenHeight,
      allowFontScaling: true,
    )..init(context);

    return Material(
        elevation: 5,
        child: Stack(
          children: <Widget>[
            Container(
                height: ScreenUtil.getInstance()
                    .setHeight(ScreenUtil.getInstance().height),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(gradient: widget.pokemonGradient)),
            AnimatedOpacity(

              opacity: isLoading ? 1.0 : 0.0,
              duration: Duration(milliseconds: 300),
              // The green box must be a child of the AnimatedOpacity widget.
              child: LoadingScreenBuild()
            ),
            loadBottomSheet(),
            pokemonPageLoad(),

          ],
        ));
  }

  Widget pokemonPageLoad(){
    if(isPokemon == true && isMove == false){
      return PokemonPageHeader(
        pokemon: pokemon,
      );
    }
    else if(isPokemon == false  && isMove == true){
      return PokemonMovePage(
        pokemonMove: pokemonMove,
      );
    }
    else return Container();
  }
  
  Widget loadBottomSheet(){
    if(isPokemon == true || isMove  == true){
      return AnimatedBottomSheet();
    }
    else {
      return Container();
    }
  }


    void pokemonServiceTypeLookup() async {
    if(widget.loadingScreenType == LoadingScreenType.pokemon){
    Pokemon pokemonResult  = await  PokemonService(pokemonID: widget.pokemonIndex).fetchPokemon();
        setState(() {
      isLoading = false;
      isPokemon = true;
      pokemon = pokemonResult;
    });
    }
    else if(widget.loadingScreenType == LoadingScreenType.move){

     PokemonMoveDetail pokemonMoveResult = await PokemonMoveService(pokemonMoveServiceType: widget.pokemonMoveServiceType, id: widget.moveID, url: widget.moveUrl).fetchPokemonMoveData();
    setState((){
      isLoading = false;
      isMove = true;
      pokemonMove  = pokemonMoveResult;
    });
    }
    else {
      throw("pokemonServiceTypeLookup Error Pokemon_Page.dart");
    }
  }
}


class AnimatedBottomSheet extends StatelessWidget {
  AnimatedBottomSheet({Key key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    MultiTrackTween tween = MultiTrackTween([
      Track("sheetPosition").add(
          Duration(milliseconds: 400),
          Tween(
              begin: ScreenUtil.getInstance().setHeight(ScreenUtil.getInstance().height),
              end: ScreenUtil.getInstance().setHeight(pokemonSheetTopPosition)),
           curve: Sprung(
             damped: Damped.critically
           )
                    // curve: Curves.elasticOut
          )
    ]);
    return ControlledAnimation(
      delay: Duration(milliseconds: 300),
      playback: Playback.PLAY_FORWARD,
      duration: tween.duration,
      tween: tween,
      builder: (context, animation) {
        return Positioned(
          top: animation["sheetPosition"],
          child: Container(
            height: ScreenUtil.getInstance().setHeight(ScreenUtil.getInstance().height),
            width: MediaQuery.of(context).size.width,
            child: Material(
                elevation: 30,
                color: Color(0xFFFAFAFA),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(ScreenUtil.getInstance().setHeight(45)),
                    topRight: Radius.circular(ScreenUtil.getInstance().setHeight(45))),
                child: Container()),
          ),
        );
      },
    );
  }
}
