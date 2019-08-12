import 'package:test/test.dart';
import 'package:pokedex/models/pokemon.dart';
import 'package:pokedex/models/pokemon_move.dart';

import 'package:pokedex/services/http/pokemon_service.dart';


void main(){
  group('PokemonServiceUnitTesting', () {
    test('fetch Pokemon', () async {
      final pokemonServiceTest = PokemonService(pokemonID: 1);

      Pokemon pokemonUnitTest= await pokemonServiceTest.fetchPokemon();
      expect(pokemonUnitTest.name, 'bulbasaur');
    });
  });
  group('PokemonMoveServiceUnitTesting', () {
    test('fetch Pokemon Moves', () async {
      final pokemonMoveServiceTest = PokemonMoveService(pokemonMoveServiceType: PokemonMoveServiceType.id, id: 1);
      PokemonMoveDetail pokemonMoveDetail = await pokemonMoveServiceTest.fetchPokemonMoveData();
      expect(pokemonMoveDetail.name, 'pound');
    });
  });
}