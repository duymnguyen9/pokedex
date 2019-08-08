//Flutter Package
import 'package:flutter/material.dart';
import 'package:pokedex/screens/pokemon_list/pokemon_list_page.dart';

void main() async {
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
      home: 
          PokemonListPageBase(),
      );
  }
}
