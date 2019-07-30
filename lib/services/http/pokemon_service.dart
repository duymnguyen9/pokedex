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
      List<Map<String, String>> evolutionList = await fetchEvolution(
          json.decode(speciesResponse.body)["evolution_chain"]["url"]);
      return Pokemon.fromJson(
          pokemonJson: json.decode(pokemonResponse.body),
          speciesJson: json.decode(speciesResponse.body),
          abilitiesFlavor: abilitiesMap,
          evolution: evolutionList);
    } else {
      throw Exception('Failed to load PokemonFromPokemon');
    }
  }

  Future fetchEvolution(url) async {
    final response = await http.get(url);
    if (response.statusCode == 200) {
      var evolutionJson = json.decode(response.body)['chain'];
      var currentPosition = evolutionJson["evolves_to"];
      List<Map<String, String>> evolutionList = [];
      for (var item in currentPosition) {
        String typeBuild(var jsonEntry){
          String output;
          if(jsonEntry["evolution_details"][0]["trigger"]["name"] == "level-up"){
            output = "Lv." + item["evolution_details"][0]["min_level"].toString();
          }
          else{
            output = item["evolution_details"][0]["trigger"]["name"];
          }
          return output;
        }
        evolutionList.add({
          "name": evolutionJson["species"]["name"],
          "evolvedName": item["species"]["name"],
          "type": typeBuild(item),
          "id": evolutionJson["species"]["url"]
              .replaceAll("https://pokeapi.co/api/v2/pokemon-species/", "")
              .replaceAll("/", ""),
          "idEvolved": item["species"]["url"]
              .replaceAll("https://pokeapi.co/api/v2/pokemon-species/", "")
              .replaceAll("/", "")
        });
        for (var level2 in item["evolves_to"]) {
          evolutionList.add({
            "name": item["species"]["name"],
            "evolvedName": level2["species"]["name"],
            "type": typeBuild(level2),
            "id": item["species"]["url"]
                .replaceAll("https://pokeapi.co/api/v2/pokemon-species/", "")
                .replaceAll("/", ""),
            "idEvolved": level2["species"]["url"]
                .replaceAll("https://pokeapi.co/api/v2/pokemon-species/", "")
                .replaceAll("/", "")
          });
        }
      }

      // while(currentPosition['evolves_to'].isNotEmpty){
      //   String speciesName = currentPosition['species']['name'];
      //   print(speciesName);
      //   for(var item in  currentPosition['evolves_to']){
      //     String evolvedName = item['species']['name'];
      //     print({speciesName:evolvedName});
      //     evolutionList.add({speciesName:evolvedName});
      //   }
      //   currentPosition = currentPosition['evolves_to'];
      // }
      return evolutionList;
    } else {
      throw Exception('Failed to load pokemon ability fetchAbilities function');
    }
  }
}
