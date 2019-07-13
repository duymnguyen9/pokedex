import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:pokedex/models/pokemon.dart';

class PokemonService {
  final int pokemonID;
  PokemonService({this.pokemonID});

  Future<String> fetchAbilities(url) async {
    List<String> versionGroup = [
      'ultra-sun-ultra-moon',
      'black-white',
      'heartgold-soulsilver'
    ];
    final response = await http.get(url);
    if (response.statusCode == 200) {
      var flavorTextEntries = json.decode(response.body)['flavor_text_entries'];
      Map<String, String> flavorMap = {};
      for (var flavor in flavorTextEntries) {
        if (flavor['language']['name'].trim() == 'en'.trim()) {
          if (versionGroup.contains((flavor['version_group']['name'].trim()))) {
            flavorMap[flavor['version_group']['name'].trim()] =
                flavor['flavor_text'];
          }
        }

        // if (flavor['language']['name'] == 'en'.trim() &&
        //     flavor['version_group']['name'].trim() == 'ultra-sun-ultra-moon'.trim()) {
        //   flavorMap['ultra-sun-ultra-moon']=flavor['flavor_text'];
        // } else if (flavor['language']['name'].trim() == 'en'.trim() &&
        //     flavor['version_group']['name'].trim() == 'black-white'.trim()) {
        //   flavorMap['black-white']=flavor['flavor_text'];
        // } else if (flavor['language']['name'].trim() == 'en'.trim() &&
        //     flavor['version_group']['name'].trim() == 'heartgold-soulsilver'.trim()) {
        //   flavorMap['heartgold-soulsilver']=flavor['flavor_text'];
        // }
      }
      String flavorText = 'EMPTY';
      if (flavorMap['ultra-sun-ultra-moon'].isNotEmpty) {
        flavorText = flavorMap['ultra-sun-ultra-moon'];
      } else if (flavorMap['black-white'].isNotEmpty) {
        flavorText = flavorMap['black-white'];
      } else if (flavorMap['heartgold-soulsilver'].isNotEmpty) {
        flavorText = flavorMap['heartgold-soulsilver'];
      }
      return flavorText;
    } else {
      throw Exception('Failed to load pokemon ability fetchAbilities function');
    }
  }

  Future<Pokemon> fetchPokemon() async {
    final String pokemonUrl =
        'http://pokeapi.co/api/v2/pokemon/' + pokemonID.toString() + '/';
    final pokemonResponse = await http.get(pokemonUrl);

    final String speciesUrl = 'http://pokeapi.co/api/v2/pokemon-species/' +
        pokemonID.toString() +
        '/';
    final speciesResponse = await http.get(speciesUrl);

    if (speciesResponse.statusCode == 200 &&
        pokemonResponse.statusCode == 200) {
      var abilitiesJson = json.decode(pokemonResponse.body)['abilities'];
      Map<String, String> abilitiesMap = {};
      for (var ability in abilitiesJson) {
        String flavorText = await fetchAbilities(ability['ability']['url']);
        abilitiesMap[ability['ability']['name']] = flavorText;
      }
      return Pokemon.fromJson(
          pokemonJson: json.decode(pokemonResponse.body),
          speciesJson: json.decode(speciesResponse.body),
          abilitiesFlavor: abilitiesMap);
    } else {
      throw Exception('Failed to load PokemonFromPokemon');
    }
  }
}
