//Flutter Package
import 'package:flutter/material.dart';

//Addition Package
//import 'package:simple_animations/simple_animations.dart';

//Internal Package
import 'package:pokedex/components/splash/splash.dart';
//import 'package:pokedex/models/pokemon.dart';
//import 'package:pokedex/screens/pokemon_page/pokemon_page.dart';
//import 'package:pokedex/services/http/pokemon_service.dart';
import 'package:pokedex/screens/pokemon_list/pokemon_list_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  const MyApp({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
          body: Stack(
        children: <Widget>[
          SplashScreen(),
          PokemonsListPage(),
        ],
      )),
    );
  }
}


