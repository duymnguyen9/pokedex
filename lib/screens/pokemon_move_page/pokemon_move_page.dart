import 'package:flutter/material.dart';
import 'package:pokedex/models/pokemon_move.dart';
import 'package:pokedex/data/pokemon_color.dart';
import 'package:pokedex/screens/pokemon_move_page/pokemon_move_page_content.dart';

class PokemonMovePage extends StatelessWidget {
  const PokemonMovePage({Key key, this.pokemonMove}) : super(key: key);
  final PokemonMoveDetail pokemonMove;

  @override
  Widget build(BuildContext context) {
    return             PokemonMovePageContent(
              pokemonMoveDetail: pokemonMove,
              color: pokemonColors[pokemonMove.type],
            );
  }
}