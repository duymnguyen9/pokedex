import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:pokedex/models/pokemon.dart';

class PokemonService {
  final int pokemonID;
  PokemonService({this.pokemonID});

  Future<Pokemon> fetchPokemon() async {
    final String pokemonUrl =
        'http://pokeapi.co/api/v2/pokemon/' + pokemonID.toString() + '/';
    final pokemonResponse = await http.get(pokemonUrl);

    final String speciesUrl = 'http://pokeapi.co/api/v2/pokemon-species/' +
        pokemonID.toString() +
        '/';
    final speciesResponse = await http.get(speciesUrl);

    // print(pokemon.types[0].typeName);
    // print(pokemon.types[0].typeUrl);
    // print(pokemon.types[0].slot.toString());
    // print(pokemon.sprites.frontUrl);
    // print(pokemon.moves[0].levelLearned);
	// print(pokemon.eggGroup[0]);
	// print(pokemon.evolutionUrl);
	// print(pokemon.imgUrl);

      if (speciesResponse.statusCode ==200 && pokemonResponse.statusCode ==200){
    	  return  Pokemon.fromJson(
        pokemonJson: json.decode(pokemonResponse.body),
        speciesJson: json.decode(speciesResponse.body));
      } else{
    	  throw Exception('Failed to load PokemonFromPokemon');
      }
  }
}
