//Flutter Package
import 'package:flutter/material.dart';

//Addition Package

//Internal Package
import 'package:pokedex/components/splash/splash.dart';
import 'package:pokedex/models/pokemon.dart';
import 'package:pokedex/screens/pokemon_page.dart';
import 'package:pokedex/services/http/pokemon_service.dart';

void main() {
  runApp(MyApp(pokemon: PokemonService(pokemonID: 7).fetchPokemon()));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  final Future<Pokemon> pokemon;

  const MyApp({Key key, this.pokemon}) : super(key: key);
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
          FutureBuilder<Pokemon>(
            future: pokemon,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return PokemonPage(pokemon: snapshot.data);
              } else if (snapshot.hasError) {
                return Container(
                    padding: EdgeInsets.all(30),
                    child: Text(
                      "${snapshot.error}",
                      style: TextStyle(fontSize: 12),
                    ));
              }
              // By default, show a loading spinner.
              return CircularProgressIndicator();
            },
          )
        ],
      )),
    );
  }
}
