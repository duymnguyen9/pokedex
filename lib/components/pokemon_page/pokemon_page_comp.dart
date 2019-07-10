import 'package:flutter/material.dart';
import 'package:pokedex/models/pokemon.dart';

Map<String, Gradient> pokemonStatsGradient = {
  "grass": LinearGradient(
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
      stops: [
        0.0,
        1.0
      ],
      colors: [
        const Color(0xff5FBC51),
        const Color(0xff5AC178),
      ]),
  "water": LinearGradient(
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
      stops: [
        0.1,
        0.7
      ],
      colors: [
        const Color(0xff6CBDE4),
                const Color(0xff4A90DD),

      ]),
};

Map<String, Gradient> pokemonColorsGradient = {
  "grass": LinearGradient(
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
      stops: [
        0.0,
        1.0
      ],
      colors: [
        const Color(0xff5FBC51),
        const Color(0xff5AC178),
      ]),
  "water": LinearGradient(
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
      stops: [
        0.38,
        0.68
      ],
      colors: [
        const Color(0xff559EDF),
        const Color(0xff69B9E3),
      ]),
};


Map<String, Color> pokemonColors = {
  "grass": Color(0xFF5DBE62),
  "water": Color(0xFF559EDF),
};

Map<String, String> pokemonStatTypesMap = {
  "hp": "HP",
  "attack": "ATK",
  "defense": "DEF",
  "special-attack": "SATK",
  "special-defense": "SDEF",
  "speed": "SPD",
};

class PokemonPageUltility {
  final Pokemon pokemon;

  String getPrimaryType() =>
      pokemon.types.firstWhere((type) => type.slot == 1).typeName;

  Gradient pokemonColorGradient() =>
      pokemonColorsGradient[getPrimaryType().toLowerCase()];
  Color pokemonColor() => pokemonColors[getPrimaryType().toLowerCase()];

  Gradient pokemonStatGradient() =>
      pokemonStatsGradient[getPrimaryType().toLowerCase()];

  String getPokemonTypeDirectory() {
    String baseDirectory = 'assets/img/tag/';
    return baseDirectory + getPrimaryType() + '.png';
  }

  PokemonPageUltility(this.pokemon);
}

double sketchSizeConversion(double sketchValue) {
  //return sketchValue * 1.103;
  return sketchValue;
}
